export enum ErrorCode {
  ACCEPT = 0,
  EmailError,
  EmailExist,
  UserNotExist,
  UsernameExist,
  PasswordError,
  PassInvalid
}

const ErrorMessage = (err: number) => {
  switch (err) {
    case ErrorCode.ACCEPT:
      return "请求成功"
    case ErrorCode.EmailError:
      return "邮箱格式错误"
    case ErrorCode.EmailExist:
    return "邮箱已经被使用"
    case ErrorCode.UserNotExist:
      return "用户不存在"
    case ErrorCode.PasswordError:
      return "密码错误"
    case ErrorCode.PassInvalid:
      return "密码少于6位"
    default:
      return "响应状态不存在"
  }
}

export default ErrorMessage