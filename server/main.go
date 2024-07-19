package main

import (
    "blogger/handlers"
    "blogger/models/dao"
    "log"
    "net/http"
)

func checkError(err error) {
    if err != nil {
        log.Fatal(err)
    }
}

func main() {
    log.SetFlags(log.Lshortfile | log.Ltime)
    dao.MongoConnect()
    defer dao.DisConnect(dao.Client)

    http.HandleFunc("/login", handlers.LoginHandler)
    http.HandleFunc("/register", handlers.RegisterHandler)

    log.Printf("The server is running-----------------------------------------------\n")

    err := http.ListenAndServe("localhost:8080", nil)
    checkError(err)
}
