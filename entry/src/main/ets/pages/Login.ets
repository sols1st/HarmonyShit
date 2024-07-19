import { promptAction, router } from '@kit.ArkUI';
import userLogin from '../api/auth';
import userRegister from '../api/register';
import ErrorMessage from '../constants/ErrorCode';

@Builder
export default function LoginBuilder() {
  Login()
}

export class User {
  username?: string
  email?: string
  posts: number = 0
  role?: string
}

export class LoginUser {
  email?: string
  password?: string
}

export class RegisterUser {
  username?: string
  email?: string
  password?: string
}

@Entry
@Component
struct Login {
  @State loginUser: LoginUser = {
    // email: "test@test.com",
    // password: "123456"
  }
  @State registerUser: RegisterUser = {
    username: "",
    email: "",
    password: ""
  }
  @State checkPass: string = ""
  loginHandle = async () => {
    if (this.loginUser.email === "" || this.loginUser.password === "") {
      promptAction.showToast({ message: "用户名或密码为空" })
    }
    let user = AppStorage.get("User") as User

    user = await userLogin(this.loginUser)
    if (user.posts === 0) {
      AppStorage.setOrCreate("User", user)
    }
    if (user.role !== "not login" && user.role !== undefined) {
      router.pushUrl({ url: "pages/Main" })
    } else {
      const msg = ErrorMessage(user.posts)
      console.log(msg)
      promptAction.showToast({ message: msg })
    }
  }
  registerHandle = async () => {
    if (this.checkPass !== this.registerUser.password) {
      promptAction.showToast({ message: "两次密码输入不一致" })
    }
    let user = await userRegister(this.registerUser)
    if (user.role !== "not login") {
      AppStorage.setOrCreate("User", user)
      router.pushUrl({ url: "pages/Main" })
    } else {
      const msg = ErrorMessage(user.posts)
      promptAction.showToast({ message: msg })
    }
  }
  modifyHandle = () => {
    router.pushUrl({ url: "pages/Main" })
    promptAction.showDialog({ title: "系统消息", message: "更改密码成功 ✅" })
  }

  build() {

    Tabs({ barPosition: BarPosition.End }) {

      TabContent() {
        Column({ space: 16 }) {
          ColumnSplit() {
            Image($r("app.media.owl"))
              .width(100)
              .height(100)
          }

          ColumnSplit() {
            TextInput({ placeholder: '邮箱' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Email)
              .onChange(value => {
                this.loginUser.email = value
              })
          }

          ColumnSplit() {
            TextInput({ placeholder: '密码' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Password)
              .onChange(value => {
                this.loginUser.password = value
              })
          }

          ColumnSplit() {
            Button({ stateEffect: true, type: ButtonType.Capsule }) {
              Text("登录")
                .fontColor("#fff")
                .fontWeight(FontWeight.Bold)
            }
            .height(40)
            .width("80%")
            .onClick(this.loginHandle)
          }
        }
      }
      .tabBar('登录')

      TabContent() {
        Column({ space: 16 }) {
          ColumnSplit() {
            Image($r('app.media.owl'))
              .width(100)
              .height(100)
          }

          ColumnSplit() {
            TextInput({ placeholder: '用户名' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.USER_NAME)
              .onChange(value => {
                this.registerUser.username = value
              })
          }

          ColumnSplit() {
            TextInput({ placeholder: '邮箱' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Email)
              .onChange(value => {
                this.registerUser.email = value
              })
          }

          ColumnSplit() {
            TextInput({ placeholder: '密码' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Password)
              .onChange(value => {
                this.registerUser.password = value
              })
          }

          ColumnSplit() {
            TextInput({ placeholder: '确认密码' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Password)
              .onChange(value => {
                this.checkPass = value
              })
          }

          ColumnSplit() {
            Button({ stateEffect: true, type: ButtonType.Capsule }) {
              Text("注册")
                .fontColor("#fff")
                .fontWeight(FontWeight.Bold)
            }
            .height(40)
            .width("80%")
            .onClick(this.registerHandle)
          }
        }
      }
      .tabBar('注册')

      TabContent() {
        Column({ space: 16 }) {
          ColumnSplit() {
            Image($r('app.media.owl'))
              .width(100)
              .height(100)
          }

          ColumnSplit() {
            TextInput({ placeholder: '邮箱' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Email)
          }

          ColumnSplit() {
            TextInput({ placeholder: '验证码' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Number)
          }

          ColumnSplit() {
            TextInput({ placeholder: '密码' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Password)
          }

          ColumnSplit() {
            TextInput({ placeholder: '确认密码' })
              .backgroundColor("#eee")
              .width("80%")
              .type(InputType.Password)
          }

          ColumnSplit() {
            Button({ stateEffect: true, type: ButtonType.Capsule }) {
              Text("更改密码")
                .fontColor("#fff")
                .fontWeight(FontWeight.Bold)
            }
            .height(40)
            .width("80%")
            .onClick(this.modifyHandle)
          }
        }
      }.tabBar("忘记密码")

    }
  }
}