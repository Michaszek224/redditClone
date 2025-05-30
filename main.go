package main

import (
	"html/template"
	"log"
	"net/http"
	"redditClone/db"
)

var templ *template.Template

func main() {
	// Initialize the database connection
	db.InitDB()

	// Set up Http server and routes
	http.HandleFunc("/", index)
	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatalf("Error starting server: %v", err)
	}
}

func init() {
	// Parsing HTML templates
	var err error
	templ, err = template.ParseGlob("templates/*.html")
	if err != nil {
		log.Fatalf("Error parsing templates: %v", err)
	}

}

func index(w http.ResponseWriter, r *http.Request) {
	// Rendering home page
	err := templ.ExecuteTemplate(w, "index.html", nil)
	if err != nil {
		http.Error(w, "Error rendering template", http.StatusInternalServerError)
		log.Printf("Error executing template: %v", err)
		return
	}
}
