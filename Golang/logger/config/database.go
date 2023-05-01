package config

import (
	"context"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"os"
	"time"
)

var counts = 10

func openDb(mongoUri string) (*mongo.Client, error) {
	clientOptions := options.Client().ApplyURI(mongoUri).SetAuth(options.Credential{
		Username: os.Getenv("MONGO_USER"),
		Password: os.Getenv("MONGO_PASSWORD"),
	})

	db, err := mongo.Connect(context.TODO(), clientOptions)
	if err != nil {
		return nil, err
	}

	return db, nil
}

func ConnectToDb() *mongo.Client {
	mongoUri := os.Getenv("MONGO_URI")

	for {
		connection, err := openDb(mongoUri)
		if err != nil {
			log.Println("Mongo not ready yet...")
			counts++
		} else {
			log.Println("Connected to Mongo!")
			return connection
		}

		if counts > 10 {
			log.Println(err)
			return nil
		}

		log.Println("Backing off for two seconds...")
		time.Sleep(2 * time.Second)
		continue
	}
}

func DisconnectDb(connection *mongo.Client) {
	ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
	cancel()

	func() {
		if err := connection.Disconnect(ctx); err != nil {
			panic(err)
		}
	}()
}
