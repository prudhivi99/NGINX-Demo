package main

import (
    "fmt"
    "log"
    "net/http"
    "os"
)

func handler(w http.ResponseWriter,r *http.Request){
	hostname = os.Hostname()
	fmt.Fprintf(w, "Hello from %s!\n", hostname)
}

func main() {
	http.HandleFunc("/",handler)
    log.Println("Starting server on :3000")
	http.ListenAndServe(":3000",nil)
}