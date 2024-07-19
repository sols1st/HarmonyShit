package entity

type User struct {
    Username string
    Email    string
    Password string
    Role     string
}

func (*User) TableName() string {
    return "users"
}
