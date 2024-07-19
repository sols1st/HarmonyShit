export enum ErrorCode {
  EmailError = 1,
  UserNotExist = 2,
  PasswordError = 3,
}

const ErrorMessage = (err: number) => {
  switch (err) {
    case ErrorCode.EmailError:
      return "邮箱格式不正确！"
    case ErrorCode.UserNotExist:
      return "用户不存在，请检查邮箱是否输入正确！"
    case ErrorCode.PasswordError:
      return "密码错误"
    default:
      return ""
  }
}

export default ErrorMessage