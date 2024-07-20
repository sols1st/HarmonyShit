import mainViewModel from '../viewmodel/MainViewModel';
import ItemData from '../models/ItemDataModel';
import { promptAction } from '@kit.ArkUI';

@Component
export default struct Index {
  swiperController: SwiperController = new SwiperController();

  firstClickGridHandle = (message:string) => {
    promptAction.showDialog({ title: "跳转", message:message })
  }

  secondClickGridHandle = (title:string) => {
    promptAction.showDialog({ title: "商品信息", message:title })
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Search({ placeholder: '输入商品名称' })
          .searchButton('搜索')
          .width(400)
          .height(40)
          .backgroundColor("FFFFF")
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .width('100%')

        Swiper(this.swiperController) {
          ForEach(mainViewModel.getSwiperImages(), (img: Resource) => {
            Image(img)
              .borderRadius(16)
          }, (img: Resource) => JSON.stringify(img.id))
        }
        .autoPlay(true)

        Grid() {
          ForEach(mainViewModel.getFirstGridData(), (item: ItemData) => {
            GridItem() {
              Column() {
                Image(item.img)
                  .width(24)
                  .height(24)
                Text(item.title)
                  .fontSize(12)
                  .margin({ top: 4 })
              }
            }.onClick(()=>{
              this.firstClickGridHandle(item.title.toString())
            })
          }, (item: ItemData) => JSON.stringify(item))
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap(6)
        .rowsGap(12)
        .padding({ top: 12, bottom: 12 })
        .height(124)
        .backgroundColor(Color.White)
        .borderRadius(24)


        Grid() {
          ForEach(mainViewModel.getSecondGridData(), (secondItem: ItemData) => {
            GridItem() {
            }
            .onClick(()=>{
              this.secondClickGridHandle(secondItem.title.toString())
            })
            .padding({ top: 8, left: 8 })
            .borderRadius(12)
            .align(Alignment.TopStart)
            .backgroundImage(secondItem.img)
            .backgroundImageSize(ImageSize.Cover)
            .width('100%')
            .height('100%')
          }, (secondItem: ItemData) => JSON.stringify(secondItem))
        }
        .width('100%')
        .height(300)
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(12)
        .margin({ bottom: 55 })
      }
    }
    .scrollBar(BarState.Off)
    .height('100%')
  }
}
