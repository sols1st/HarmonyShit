import { GoodsItem } from '../models/GoodsModel';
import { mockGoodsList } from '../viewmodel/MockData';
import {  promptAction } from '@kit.ArkUI'

@Component
export default struct WaterFlowGoodsPage {
  @State goodsList: GoodsItem[] = mockGoodsList
  @State isLoadMore: boolean = false

  @Builder
  getGoodsItemView(item: GoodsItem, index: number) {
    Column({ space: 5 }) {
      Image(item.imageUrl)
        .height(index % 2 ? 120 : 180)
        .borderRadius(8)
      Text(item.title)
        .fontSize(14)
        .lineHeight(22)
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      Text(item.price)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 5 })
    }
  }

  @Builder
  getFooter() {
    Row() {
      Text('加载更多...')
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r("app.color.background"))
    .height(60)
    .width('100%')
  }

  build() {
      WaterFlow({ footer: this.getFooter }) {
        ForEach(this.goodsList, (item: GoodsItem, index: number) => {
          FlowItem() {
            this.getGoodsItemView(item, index)
          }
        })
      }
      .height('100%')
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .padding(10)
      .onReachEnd(async () => {
        if (!this.isLoadMore) {
          try {
            this.isLoadMore = true
            await this.loadMore()
            this.isLoadMore = false
          } catch (error) {
            promptAction.showToast({ message: JSON.stringify(error) })
          }
        }
      })
      .margin({ top: 17 })

  }

  loadMore() {
    return new Promise<boolean>((resolve) => {
      setTimeout(() => {
        this.goodsList.push(...this.goodsList.slice(0, 5))
      }, 1000)
      resolve(true)
    })
  }
}
