package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"net/http"
)

type RequestPayload struct {
	Action string      `json:"action"`
	Auth   AuthPayload `json:"auth,omitempty"`
	Log    LogPayload  `json:"log,omitempty"`
}

type AuthPayload struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type LogPayload struct {
	Name string `json:"name"`
	Data string `json:"data"`
}

func (app *Config) Broker(w http.ResponseWriter, r *http.Request) {
	payload := jsonResponse{
		Error:   false,
		Message: "Hit the broker",
	}

	_ = app.writeJson(w, http.StatusOK, payload)
}

func (app *Config) HandleSubmission(w http.ResponseWriter, r *http.Request) {
	var requestPayload RequestPayload

	err := app.readJson(w, r, &requestPayload)
	if err != nil {
		app.errorJson(w, err, http.StatusBadRequest)
		return
	}

	switch requestPayload.Action {
	case "auth":
		app.authenticate(w, requestPayload.Auth)
	case "log":
		app.logItem(w, requestPayload.Log)
	default:
		app.errorJson(w, errors.New("unknown action"))
	}
}

func (app *Config) authenticate(w http.ResponseWriter, a AuthPayload) {
	jsonData, err := json.MarshalIndent(a, "", "\t")
	if err != nil {
		app.errorJson(w, err, http.StatusBadRequest)
		return
	}

	request, err := http.NewRequest("POST", "http://auth/users/login", bytes.NewBuffer(jsonData))
	if err != nil {
		app.errorJson(w, err, http.StatusBadRequest)
		return
	}

	client := &http.Client{}
	response, err := client.Do(request)
	if err != nil {
		app.errorJson(w, err, http.StatusBadRequest)
		return
	}

	defer response.Body.Close()

	if response.StatusCode == http.StatusUnauthorized {
		app.errorJson(w, errors.New("invalid credentials"), http.StatusUnauthorized)
		return
	} else if response.StatusCode != http.StatusAccepted {
		app.errorJson(w, errors.New("error calling auth service"), http.StatusInternalServerError)
		return
	}

	var responseData jsonResponse

	err = json.NewDecoder(response.Body).Decode(&responseData)
	if err != nil {
		app.errorJson(w, err, http.StatusBadRequest)
		return
	}

	if responseData.Error {
		app.errorJson(w, err, http.StatusUnauthorized)
		return
	}

	var payload jsonResponse
	payload.Error = false
	payload.Message = "Authenticated!"
	payload.Data = responseData.Data

	app.writeJson(w, http.StatusAccepted, payload)
}

func (a *Config) logItem(w http.ResponseWriter, entry LogPayload) {
	jsonData, _ := json.MarshalIndent(entry, "", "\t")

	logServiceUrl := "http://logger/log-entries"

	request, err := http.NewRequest("POST", logServiceUrl, bytes.NewBuffer(jsonData))
	if err != nil {
		a.errorJson(w, err, http.StatusBadRequest)
		return
	}

	request.Header.Set("Content-Type", "application/json")

	client := &http.Client{}

	response, err := client.Do(request)
	if err != nil {
		a.errorJson(w, err, http.StatusInternalServerError)
		return
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusAccepted {
		a.errorJson(w, errors.New("can't connect to log service"), http.StatusInternalServerError)
		return
	}

	var payload jsonResponse
	payload.Error = false
	payload.Message = "logged"

	a.writeJson(w, http.StatusAccepted, payload)
}
