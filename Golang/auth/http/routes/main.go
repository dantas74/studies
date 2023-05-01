package routes

import (
	"auth/http/middleware"
	"github.com/go-chi/chi/v5"
	"net/http"
)

func Routes() http.Handler {
	mux := chi.NewRouter()

	mux.Use(middleware.Cors())
	mux.Use(middleware.Heartbeat())

	mux.Mount("/users", userRoutes())

	return mux
}
