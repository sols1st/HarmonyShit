import { LoginUser, User } from '../pages/Login'
import { http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'

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
      console.log("received the login response!")
    } else {
      console.log("Net work or server error!");
    }
  }).catch((e: BusinessError) => {
    console.log(e.message)
  })
  return new Promise<User>(resolve =>{
    resolve(user)
  })
}

export default  userLogin