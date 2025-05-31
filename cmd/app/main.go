package main

import (
	"redditClone/internal/db"
	"redditClone/internal/server"
)

func main() {
	// Initialize the database connection
	db.InitDB()

	server.StartServer()
}
