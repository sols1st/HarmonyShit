package entity

type User struct {
    id       uint32
    username string
    email    string
    password string
    posts    uint32
    salt     string
}

func (*User) TableName() string {
    return "users"
}
