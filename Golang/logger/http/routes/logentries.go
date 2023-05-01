package routes

import (
	"github.com/go-chi/chi/v5"
	"logger/http/controllers"
	"net/http"
)

func logEntriesRoutes() http.Handler {
	router := chi.NewRouter()
	controller := controllers.LogEntryController{}

	router.Post("/", controller.Create)

	return router
}
