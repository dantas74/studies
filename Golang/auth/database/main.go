package database

import (
	"auth/models"
	_ "github.com/jackc/pgx/v4"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"log"
	"os"
	"time"
)

var counts int64

func openDb(dsn string) (*gorm.DB, error) {
	db, err := gorm.Open(postgres.New(postgres.Config{
		DSN:                  dsn,
		PreferSimpleProtocol: true,
	}), &gorm.Config{})
	if err != nil {
		return nil, err
	}

	if err != nil {
		return nil, err
	}

	err = db.AutoMigrate(
		&models.User{},
	)
	if err != nil {
		return nil, err
	}

	return db, nil
}

func ConnectToDb() *gorm.DB {
	dsn := os.Getenv("DSN")

	for {
		connection, err := openDb(dsn)
		if err != nil {
			log.Println("Postgres not ready yet...")
			counts++
		} else {
			log.Println("Connected to Postgres!")
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
