package middleware

import (
	"github.com/go-chi/chi/v5/middleware"
	"net/http"
)

func Heartbeat() func(handler http.Handler) http.Handler {
	return middleware.Heartbeat("/ping")
}
