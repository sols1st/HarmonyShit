import { promptAction, router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { JSON } from '@kit.ArkTS';

@Builder
export default function LoginBuilder() {
  Login()
}

interface User {
  name: string
  email: string
}

@Entry
@Component
struct Login {
  async loginHandle() {
    const req = http.createHttp()
    const res = await req.request("localhost:8080/login",{
      method: http.RequestMethod.POST,
      extraData: "application/json"
    })

    const user = JSON.parse(res.result.toString())

    router.pushUrl({ url: "pages/Home" })
  }

  registerHandle = () => {
    router.pushUrl({ url: "pages/Home" })
  }
  modifyHandle = () => {
    router.pushUrl({ url: "pages/Home" })
    promptAction.showToast({ message: "更改密码成功 ✅" })
  }

  build() {
    NavDestination() {
      Tabs({ barPosition: BarPosition.End }) {

        TabContent() {
          Column({ space: 16 }) {
            ColumnSplit() {
              Image($r("app.media.owl"))
                .width(100)
                .height(100)
            }

            ColumnSplit() {
              TextInput({ placeholder: '用户名' })
                .backgroundColor("#eee")
                .width("80%")
            }

            ColumnSplit() {
              TextInput({ placeholder: '密码' })
                .backgroundColor("#eee")
                .width("80%")
                .type(InputType.Password)
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
            }

            ColumnSplit() {
              TextInput({ placeholder: '手机号' })
                .backgroundColor("#eee")
                .width("80%")
                .type(InputType.PhoneNumber)
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
              TextInput({ placeholder: '手机号' })
                .backgroundColor("#eee")
                .width("80%")
                .type(InputType.PhoneNumber)
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
    .title('Login')
  }
}