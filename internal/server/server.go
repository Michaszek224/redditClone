package server

import (
	"html/template"
	"log"
	"net/http"
)

// Initialize the template variable
var templ *template.Template

func StartServer() {
	// Parsing HTML templates
	var err error
	templ, err = template.ParseGlob("templates/*.html")
	if err != nil {
		log.Fatalf("Error parsing templates: %v", err)
	}

	// Handlers
	http.HandleFunc("/", index)

	// Starting the server
	log.Println("Starting server on :8080")
	http.ListenAndServe(":8080", nil)
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
