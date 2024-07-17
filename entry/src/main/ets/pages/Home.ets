import { Prompt, promptAction, router } from '@kit.ArkUI'

@Styles
function imgStyle() {
  .width(40)
  .height(40)
  .aspectRatio(1)
  .borderRadius(50)
}

@Extend(Button)
function buttonExtend(type: "alipay" | "wechat") {
  .type(ButtonType.Normal)
  .fontColor("#fff")
  .backgroundColor(type === "alipay" ? "#ff578ae0" : "#ff20de1b")
  .onClick(() => {
    if (type === "alipay") {
      promptAction.showToast({ message: "Alipay!" })
    }
    else {
      promptAction.showToast({ message: "Wechat" })
    }
  })
}

@Styles
function buttonStyles() {
  .width("80%")
  .height("50")
  .borderRadius(5)

}

@Builder
function buttonBuilder(type: "alipay" | "wechat") {
  Button(type === "alipay" ? "支付宝" : "微信")
    .buttonStyles()
    .buttonExtend(type)
}


@Builder
export default function HomeBuilder() {
  Home()
}

@Entry
@Component
struct Home {
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Grid() {
            GridItem() {
              Image($r("app.media.arrow_left"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.owl"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.arrow_right"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.arrow_left"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.owl"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.arrow_right"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.arrow_left"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.owl"))
                .imgStyle()
            }

            GridItem() {
              Image($r("app.media.arrow_right"))
                .imgStyle()
            }
          }
        }.tabBar("主页")

        TabContent() {

          Column({ space: 16 }) {
            ColumnSplit() {
              buttonBuilder("alipay")
            }

            ColumnSplit() {
              buttonBuilder("wechat")
            }

            ColumnSplit() {
              buttonBuilder("alipay")
            }

            ColumnSplit() {
              buttonBuilder("wechat")
            }

            ColumnSplit() {
              buttonBuilder("alipay")

            }

            ColumnSplit() {
              buttonBuilder("wechat")
            }

            ColumnSplit() {
              buttonBuilder("alipay")
            }
          }

        }.tabBar("消息")

        TabContent() {
          Column({ space: 10 }) {

            ColumnSplit() {
              Row({ space: 36 }) {
                RowSplit() {
                  Image($r("app.media.arrow_left"))
                    .imgStyle()
                }

                RowSplit() {
                  Text("评论回复")
                }
              }.justifyContent(FlexAlign.Center)
            }

            Row({ space: 10 }) {

              RowSplit() {
                Image($r("app.media.owl"))
                  .imgStyle()
              }.alignSelf(ItemAlign.Start)

              RowSplit() {
                Column({ space: 10 }) {
                  Text("Storious")
                    .fontWeight(FontWeight.Bold)
                    .fontStyle(FontStyle.Normal)
                  Text("description,,,,,,,,,,,,,,,,,,,," +
                    ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,") {

                  }.width("60%")
                }.justifyContent(FlexAlign.Start)
                .alignItems(HorizontalAlign.Start)
                .layoutWeight("80%")
              }
            }
          }.alignItems(HorizontalAlign.Start)

        }.tabBar("个人")
      }
    }
    .title('Home')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}