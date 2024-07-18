export default class ItemData {

  title: Resource|string;
  img: Resource|string;
  others?: Resource|string;

  constructor(title: Resource|string, img: Resource|string, others?: Resource|string) {
    this.title = title;
    this.img = img;
    this.others = others;
  }
}