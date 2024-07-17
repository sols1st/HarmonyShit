import { router } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  pathStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pathStack) {
    }
    .title("Index")
    .hideTitleBar(false)
    .onAppear(() => {
      router.pushUrl({ url: "pages/Login" })
    })
  }
}
