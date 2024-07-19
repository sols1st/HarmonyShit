package service

import (
    "blogger/constants"
    "blogger/models/dao"
    "blogger/models/dto"
    "blogger/models/entity"
    "blogger/models/vo"
    "blogger/utils/testmail"
)

func UserLogin(req dto.LoginRequest) vo.LoginResponse {
    var res vo.LoginResponse
    if !testmail.IsEmail(req.Email) {
        res.Posts = constants.EmailError
        return res
    }
    // mongoDB 读取用户数据
    data := dao.QueryUser(dao.Client, req.Email)

    if data.Email != req.Email {
        res.Posts = constants.UserNotExist
        return res
    }

    if req.Password != data.Password {
        res.Posts = constants.PasswordError
        return res
    }

    res = vo.LoginResponse{
        Username: data.Username, Email: data.Email, Role: data.Role, Posts: constants.ACCEPT}

    return res
}

func UserRegister(req dto.RegisterRequest) vo.RegisterResponse {
    var res vo.RegisterResponse
    if !testmail.IsEmail(req.Email) {
        res.Posts = constants.EmailError
        return res
    }

    if len(req.Password) < 6 {
        res.Posts = constants.PassInvalid
        return res
    }

    // mongoDB 读取用户数据
    data := dao.QueryUser(dao.Client, req.Email)
    if data.Email == req.Email {
        res.Posts = constants.EmailExist
        return res
    }

    res = vo.RegisterResponse{Username: req.Username, Email: req.Email, Role: "user", Posts: constants.ACCEPT}

    // mongDB 添加用户
    dao.AddUser(dao.Client, entity.User{Username: res.Username, Email: res.Email, Password: req.Password, Role: "user"})

    return res
}
