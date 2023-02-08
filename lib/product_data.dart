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
  ProductData.fromJson(Map<dynamic,dynamic> Json)
      : pname = Json["pname"],
        pid = Json['pid'],
        prize = Json['prize'],
         desc = Json['desc'],
        image = Json['image'].toString(),
        quantity = Json['quantity'];

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
