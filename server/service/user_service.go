package service

import (
    "blogger/models/dto"
    "blogger/models/vo"
    "blogger/utils/testmail"
)

func UserLogin(req dto.LoginRequest) vo.LoginResponse {
    var res vo.LoginResponse
    if !testmail.IsEmail(req.Email) {
        res.Posts = 1
        return res
    }

    if req.Email != "test@test.com" {
        res.Posts = 2
        return res
    }

    if req.Password != "123456" {
        res.Posts = 3
        return res
    }
    res = vo.LoginResponse{Username: "wjie", Email: "test@test.com", Role: "user"}

    return res
}
