class ProductData {
  String pname;
  String pid;
  String image;
  int prize;
  int quantity;
  String desc;

  ProductData(
      {required this.pname,
      required this.pid,
      required this.prize,
      required this.image,
      required this.desc,
      required this.quantity});
  factory ProductData.fromJson(Map<dynamic, dynamic> parsedjson) {
    return ProductData(
        pname: parsedjson["pname"],
        pid: parsedjson['pid'].toString(),
        prize: parsedjson['prize'],
        image: parsedjson['image'],
        desc: parsedjson['desc'],
        quantity: parsedjson['quantity']);
  }

  /* Map toJson() {
    return {
      'pid': pid,
      'pname': pname,
      'image': image,
      'desc':desc,
      'amount': prize,
      'quantity': quantity
    };
  }*/
}
