import { LoginUser, User } from '../pages/Login'
import { http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { promptAction } from '@kit.ArkUI'

const url = "localhost:8080/login"

const userLogin = async (loginUser: LoginUser): Promise<User> => {
  const req = http.createHttp()
  const res = req.request(url, {
    method: http.RequestMethod.POST,
    extraData: loginUser,
  })
  console.log("Send login request !")
  let user: User
  await res.then((data) => {
    if (data.responseCode == 200) {
      user = JSON.parse(data.result.toString()) as User
      console.log("Received the login response!")
    } else {
      promptAction.showToast({ message: "网络请求失败" })
      console.log("Net work or server error!");
    }
  }).catch((e: BusinessError) => {
    promptAction.showToast({ message: "服务器发生错误" })
    console.log(e.message)
  })
  return new Promise<User>(resolve => {
    resolve(user)
  })
}


const checkUser = (user: User): Boolean => {
  return (user.posts === 0 && user.role !== "not login" && user.role !== undefined)
}
export {checkUser}

export default userLogin