package handlers

import (
    "blogger/config"
    "blogger/constants"
    "blogger/models/dto"
    "blogger/service"
    "encoding/json"
    "io"
    "log"
    "net/http"
)

func LoginHandler(w http.ResponseWriter, r *http.Request) {

    config.Cors(w)
    log.Printf("[request]: %v; remote address: %s\n", r.Method, r.RemoteAddr)

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

    log.Printf("user email: %v\n", loginUser.Email)

    //处理登录请求
    var response = service.UserLogin(loginUser)

    w.Header().Set("Content-Type", "application/json")
    err = json.NewEncoder(w).Encode(response)
    if err != nil {
        log.Println(err.Error())
    }

    constants.ErrorCodeLog(response.Posts)
}

func RegisterHandler(w http.ResponseWriter, r *http.Request) {

    config.Cors(w)
    log.Printf("[request]: %v; remote address: %s\n", r.Method, r.RemoteAddr)

    if r.Method == http.MethodOptions {
        return
    }

    if r.Method != http.MethodPost {
        http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
        return
    }

    var registerUser dto.RegisterRequest
    err := json.NewDecoder(r.Body).Decode(&registerUser)

    if err != nil {
        http.Error(w, "Invalid request body", http.StatusBadRequest)
        body, _ := io.ReadAll(r.Body)
        log.Println("Request Body:", string(body))
        return
    }

    log.Printf("user email: %v\n", registerUser.Email)

    //处理注册请求
    var response = service.UserRegister(registerUser)

    w.Header().Set("Content-Type", "application/json")
    err = json.NewEncoder(w).Encode(response)
    if err != nil {
        log.Println(err.Error())
    }

    constants.ErrorCodeLog(response.Posts)
}
