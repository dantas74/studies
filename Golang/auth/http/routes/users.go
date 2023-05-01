package routes

import (
	"auth/http/controllers"
	"github.com/go-chi/chi/v5"
)

func userRoutes() chi.Router {
	router := chi.NewRouter()
	userController := controllers.UserController{}

	router.Post("/login", userController.Authenticate)
	router.Put("/reset-password", userController.ResetPassword)

	return router
}
