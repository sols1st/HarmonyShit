import ItemData from '../models/ItemDataModel';
import { mockGoodsList } from '../viewmodel/MockData'

export class IndexViewModel {
  getSwiperImages(): Array<Resource> {
    let swiperImages: Resource[] = [
      $r('app.media.jd1'),
      $r('app.media.jd2'),
      $r('app.media.jd3'),
      $r('app.media.jd4')
    ]
    return swiperImages
  }

  getFirstGridData(): Array<ItemData> {
    let firstGridData: ItemData[] = [
      new ItemData('加油卡', $r('app.media.icon1')),
      new ItemData('游戏', $r('app.media.icon2')),
      new ItemData('酒店', $r('app.media.icon3')),
      new ItemData('云建站', $r('app.media.icon4')),
      new ItemData('PLUS会员', $r('app.media.icon5')),
      new ItemData('礼品卡', $r('app.media.icon6')),
      new ItemData('企业会员', $r('app.media.icon7')),
      new ItemData('话费', $r('app.media.icon8'))
    ]
    return firstGridData
  }

  getSecondGridData(): Array<ItemData> {
    let secondGridData: ItemData[] = []
    mockGoodsList.slice(1, 5).forEach(item => {
      secondGridData.push(new ItemData(item.title, item.imageUrl))
    });
    return secondGridData
  }

  getSettingListData(): Array<ItemData> {
    let settingListData: ItemData[] = [
      new ItemData('推送通知', $r('app.media.news'), ''),
      new ItemData('菜单设置', $r('app.media.data'), ''),
      new ItemData('服务', $r('app.media.menu'), ''),
      new ItemData('收藏', $r('app.media.about'), ''),
      new ItemData('设置', $r('app.media.storage'), ''),
      new ItemData('隐私', $r('app.media.privacy'), '')
    ]
    return settingListData
  }
}

export default new IndexViewModel()