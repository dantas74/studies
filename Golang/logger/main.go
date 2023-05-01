package main

import (
	"log"
	"logger/config"
	"logger/models"
)

func main() {
	log.Println("Starting logging service")

	conn := config.ConnectToDb()
	if conn == nil {
		log.Panic("Can't connect to Mongo")
	}
	models.Conn = conn

	defer config.DisconnectDb(conn)

	config.StartHttpServer()
}
