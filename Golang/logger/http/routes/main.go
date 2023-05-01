package routes

import (
	"github.com/go-chi/chi/v5"
	"logger/http/middleware"
	"net/http"
)

func Routes() http.Handler {
	mux := chi.NewRouter()

	mux.Use(middleware.Cors())
	mux.Use(middleware.Heartbeat())

	mux.Mount("/log-entries", logEntriesRoutes())

	return mux
}
