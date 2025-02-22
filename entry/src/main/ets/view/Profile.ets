import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import ItemData from '../models/ItemDataModel';
import mainViewModel from '../viewmodel/MainViewModel';
import { User } from '../pages/Login';


@Component
export default struct Profile {
  @State user: User = AppStorage.get("User") as User;

  @Builder
  settingCell(item: ItemData) {
    Row() {
      Row({ space: 12 }) {
        Image(item.img)
          .width(22)
          .height(22)
        Text(item.title)
          .fontSize(16)
      }

      Toggle({ type: ToggleType.Switch, isOn: false })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({
      left: 8,
      right: 22
    })
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Column() {
          Text('我的')
            .fontWeight(FontWeight.Medium)
            .fontSize(17)
            .margin({ top: 17 })
            .padding({ left: 5 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // 个人信息
        Row() {
          Image($r('app.media.owl'))
            .width(48)
            .height(48)
          Column() {
            Text(this.user.username)
              .fontSize(20)
            Text(this.user.email)
              .fontSize(12)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 24 })
        }
        .margin({ top: 8 })
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(96)
        .backgroundColor(Color.White)
        .padding({ left: 24 })
        .borderRadius(16)

        // 功能列表
        List() {
          ForEach(mainViewModel.getSettingListData(), (item: ItemData) => {
            ListItem() {
              //构建每一个item
              this.settingCell(item)
            }
            .height(48)
          }, (item: ItemData) => JSON.stringify(item))
        }
        .backgroundColor(Color.White)
        .width('100%')
        .height('42%')
        // 为列表增加分隔线
        .divider({
          strokeWidth: 1,
          color: Color.Grey,
          startMargin: 42,
          endMargin: 42
        })
        .borderRadius(16)
        .padding({ top: 4, bottom: 4, left: 8 })

        Blank()

        Button('退出登录', { type: ButtonType.Capsule })
          .width('90%')
          .height(40)
          .fontSize(16)
          .fontColor($r('app.color.setting_button_fontColor'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.setting_button_backgroundColor'))
          .margin({ bottom: 55 })
          .onClick(() => {
            promptAction.showToast({ message: '退出登录' })
            router.replaceUrl({ url: 'pages/Login' })
          })
      }
      .height('100%')
    }
  }
}



