package main

import (
	"html/template"
	"log"
	"net/http"
)

var templ *template.Template

func main() {
	http.HandleFunc("/", index)
	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatalf("Error starting server: %v", err)
	}
}

func init() {
	var err error
	templ, err = template.ParseGlob("templates/*.html")
	if err != nil {
		log.Fatalf("Error parsing templates: %v", err)
	}
}

func index(w http.ResponseWriter, r *http.Request) {
	err := templ.ExecuteTemplate(w, "index.html", nil)
	if err != nil {
		http.Error(w, "Error rendering template", http.StatusInternalServerError)
		log.Printf("Error executing template: %v", err)
		return
	}
}
