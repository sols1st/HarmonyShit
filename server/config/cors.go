package config

import "net/http"

// Cors 手动设置header处理跨域
func Cors(w http.ResponseWriter) {
    w.Header().Set("Access-Control-Allow-Origin", "[*]")
    w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
    w.Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
}
