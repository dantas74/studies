package config

import (
	"fmt"
	"log"
	"logger/http/routes"
	"net/http"
)

const WEB_PORT = "80"

func StartHttpServer() {
	srv := &http.Server{
		Addr:    fmt.Sprintf(":%s", WEB_PORT),
		Handler: routes.Routes(),
	}

	err := srv.ListenAndServe()
	if err != nil {
		log.Panic(err)
	}
}
