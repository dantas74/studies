package main

import (
	"auth/database"
	"auth/http/routes"
	"auth/models"
	"fmt"
	"log"
	"net/http"
)

const WEB_PORT = "80"

func main() {
	log.Println("Starting authentication service")

	conn := database.ConnectToDb()
	if conn == nil {
		log.Panic("Can't connect to Postgres!")
	}
	models.Conn = conn

	srv := &http.Server{
		Addr:    fmt.Sprintf(":%s", WEB_PORT),
		Handler: routes.Routes(),
	}

	err := srv.ListenAndServe()
	if err != nil {
		log.Panic(err)
	}
}
