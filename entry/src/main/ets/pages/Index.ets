import { router } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  build() {
    Navigation() {
    }
    .title("Index")
    .hideTitleBar(false)
    .onAppear(() => {
      router.pushUrl({ url: "pages/Login" })
    })
  }
}
