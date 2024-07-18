package main

import (
    "blogger/config"
    "blogger/models/dto"
    "blogger/models/vo"
    "encoding/json"
    "io"
    "log"
    "net/http"
)

func checkError(err error) {
    if err != nil {
        log.Fatal(err)
    }
}

func loginHandle(w http.ResponseWriter, r *http.Request) {

    config.Cors(w)
    log.Printf("request: %v; remote address: %s; origin: %s\n\n", r.Method, r.RemoteAddr, r.Header.Get("Origin"))

    if r.Method == http.MethodOptions {
        return
    }

    if r.Method != http.MethodPost {
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
        return
    }

    var loginUser dto.LoginRequest
    err := json.NewDecoder(r.Body).Decode(&loginUser)

    if err != nil {
        http.Error(w, "Invalid request body", http.StatusBadRequest)
        body, _ := io.ReadAll(r.Body)
        log.Println("Request Body:", string(body))
        return
    }

    log.Printf("user email: %v, user password: %v\n", loginUser.Email, loginUser.Password)

    var response vo.LoginResponse
    if loginUser.Email == "test@test.com" && loginUser.Password == "123456" {
        response = vo.LoginResponse{
            Username: "wjie",
            Email:    "test@test.com",
            Role:     "user",
        }
    } else {
        response = vo.LoginResponse{
            Role: "tourist",
        }
    }

    w.Header().Set("Content-Type", "application/json")
    err = json.NewEncoder(w).Encode(response)
    checkError(err)
    log.Print("login is accepted!\n\n")
}

func main() {
    http.HandleFunc("/login", loginHandle)
    log.SetFlags(log.Lshortfile | log.Ltime)

    log.Printf("The server is running!\n")

    err := http.ListenAndServe("localhost:8080", nil)
    checkError(err)
}
