package controllers

import (
	"auth/models"
	"auth/shared/helpers"
	"errors"
	"fmt"
	"net/http"
)

type UserController struct {
	UserModel models.User
}

func (u UserController) Authenticate(w http.ResponseWriter, r *http.Request) {
	var payload struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}

	err := helpers.ReadJson(w, r, &payload)
	if err != nil {
		helpers.ErrorJson(w, err, http.StatusBadRequest)
		return
	}

	user, err := u.UserModel.GetByEmail(payload.Email)
	if err != nil {
		helpers.ErrorJson(w, errors.New("invalid credentials"), http.StatusBadRequest)
		return
	}

	valid, err := user.PasswordMatches(payload.Password)
	if err != nil || !valid {
		helpers.ErrorJson(w, errors.New("invalid credentials"), http.StatusUnauthorized)
		return
	}

	responseData := helpers.JsonResponse{
		Error:   false,
		Message: fmt.Sprintf("Logged in user %s", user.Email),
		Data:    user,
	}

	helpers.WriteJson(w, http.StatusAccepted, responseData)
}

func (u UserController) ResetPassword(w http.ResponseWriter, r *http.Request) {
	var payload struct {
		Email                string `json:"email"`
		Password             string `json:"password"`
		PasswordVerification string `json:"passwordVerification"`
	}

	err := helpers.ReadJson(w, r, &payload)
	if err != nil {
		helpers.ErrorJson(w, err, http.StatusBadRequest)
		return
	}

	if payload.Password != payload.PasswordVerification {
		helpers.ErrorJson(w, errors.New("passwords don't match"), http.StatusBadRequest)
		return
	}

	err = u.UserModel.ResetPassword(payload.Email, payload.Password)
	if err != nil {
		helpers.ErrorJson(w, err, http.StatusBadRequest)
		return
	}

	responseData := helpers.JsonResponse{
		Error:   false,
		Message: "Successfully changed your password",
	}

	helpers.WriteJson(w, http.StatusOK, responseData)
}
