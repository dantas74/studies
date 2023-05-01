package controllers

import (
	"logger/models"
	"logger/shared/helpers"
	"net/http"
)

type LogEntryController struct {
	logEntry models.LogEntry
}

func (l LogEntryController) Create(w http.ResponseWriter, r *http.Request) {
	var requestPayload struct {
		Name string `json:"name"`
		Data string `json:"data"`
	}

	_ = helpers.ReadJson(w, r, &requestPayload)

	event := models.LogEntry{
		Name: requestPayload.Name,
		Data: requestPayload.Data,
	}

	err := l.logEntry.Insert(event)
	if err != nil {
		helpers.ErrorJson(w, err, http.StatusBadRequest)
		return
	}

	responseData := helpers.JsonResponse{
		Error:   false,
		Message: "logged",
	}

	helpers.WriteJson(w, http.StatusAccepted, responseData)
}
