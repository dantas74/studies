package main

import (
	"auth/config"
	"auth/models"
	"log"
)

func main() {
	log.Println("Starting authentication service")

	conn := config.ConnectToDb()
	if conn == nil {
		log.Panic("Can't connect to Postgres!")
	}
	models.Conn = conn

	config.StartHttpServer()
}
