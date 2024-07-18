package vo

type LoginResponse struct {
    Username string `json:"username"`
    Email    string `json:"email"`
    Posts    int32  `json:"posts"`
    Role     string `json:"role"`
}
