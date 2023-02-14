import 'dart:convert';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/model/product_data.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:demo_splash_screen/slidable_action.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class ProductStreambuilder extends StatefulWidget {
  const ProductStreambuilder({super.key});

  @override
  State<ProductStreambuilder> createState() => _ProductStreambuilderState();
}

class _ProductStreambuilderState extends State<ProductStreambuilder> {
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  var total = 0;
  int gettotal(){
     var _totals = total;
     return _totals;
    }
  Future<String> getdata() async {
    http.Response response = await http.get(Uri.parse(
        "https://flutter-authentication-8b2ee-default-rtdb.firebaseio.com/product.json"));
    return response.body;
  }

  final List<ProductData> _productlist = [];
  Future loaddata() async {
    String pdata = await getdata();
    final jsonResponse = json.decode(pdata);
    setState(() {
      for (Map<dynamic, dynamic> i in jsonResponse) {
        _productlist.add(ProductData.fromJson(i));
      }
    });
    return _productlist;
  }

  final AuthService auth = AuthService();
  final cref = FirebaseDatabase.instance.ref("cart");
  DatabaseReference pref = FirebaseDatabase.instance.ref("wishlist");
  final ScrollController _controller = ScrollController();

  void initstate() {
    loaddata();
    gettotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: StreamBuilder(
          stream: loaddata().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                controller: _controller,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10.h),
                itemCount: 5,
                itemBuilder: ((context, int index) {
                  var pindex = _productlist[index];
                  
                  return Slidable(
                    startActionPane:
                        (ActionPane(motion: const DrawerMotion(), children: [
                      SlidableAction(
                        label: AllStrings.checkoff,
                        backgroundColor: AllColors.checkoff,
                        icon: Icons.check_box,
                        foregroundColor: AllColors.checkbox,
                        onPressed: (context) {},
                      ),
                    ])),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: [
                        Slidable_Action(
                            lable: AllStrings.swap, icon: Icons.swap_horiz_sharp),
                        Slidable_Action(
                            lable: AllStrings.move, icon: Icons.move_to_inbox),
                        Slidable_Action(lable: AllStrings.copy, icon: Icons.copy),
                        Slidable_Action(
                            lable: AllStrings.delete, icon: Icons.delete),
                      ],
                    ),
                    //child: const ProductCard(),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AllColors.white, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 139.h,
                            width: 97.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(pindex.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    margin: EdgeInsets.all(5.h),
                                    height: 15.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(40)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.h, bottom: 5.h)),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: AllColors.maincolor,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          AllStrings.ratingtext,
                                          style: TextStyle(
                                            color: AllColors.totals,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(right: 140.w, top: 10.h),
                                  child: Image.asset(
                                    AllImages.tesco,
                                    fit: BoxFit.cover,
                                    height: 17.h,
                                    width: 70.w,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(pindex.pname),
                                Row(
                                  children: [
                                    Text(pindex.pid),
                                    SizedBox(
                                      width: 170.w,
                                    ),
                                    const Text(AllStrings.kg)
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      pindex.prize.toString(),
                                      style: TextStyle(color: AllColors.prize),
                                    ),
                                    SizedBox(
                                      width: 155.w,
                                    ),
                                    Text('£ 7.90',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: AllColors.totals)),
                                    SizedBox(
                                      width: 6.w,
                                    ),
                                    Text(
                                      '$total',
                                      // '£ 6.90',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AllColors.maincolor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  pindex.desc,
                                  style: TextStyle(color: AllColors.desc),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 130.w, bottom: 5.h, top: 10.h),
                                      child: Container(
                                        height: 20.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(
                                            color: AllColors.slidable,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (pindex.quantity > 0) {
                                                  cref
                                                      .child(pindex.pname)
                                                      .update({
                                                    'quantity': --pindex.quantity,
                                                    'prize': pindex.quantity *
                                                        pindex.prize,
                                                  });
                                                }
                                                setState(() {
                                                  if (total > 0) {
                                                    total =
                                                        total - pindex.prize;
                                                  }
                                                  pref
                                                      .child(
                                                          '-NO9A2WrPD86gpOYUwFy')
                                                      .update({
                                                    'total_prize': total
                                                  });
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_circle_outline,
                                                color: AllColors.maincolor,
                                              ),
                                            ),
                                            Text(_productlist[index]
                                                .quantity
                                                .toString()),
                                            GestureDetector(
                                              onTap: () {
                                                if (pindex.quantity == 0) {
                                                  cref.child(pindex.pname).set({
                                                    'pname': pindex.pname,
                                                    'pid': pindex.pid,
                                                    'prize': pindex.prize,
                                                    'quantity': ++pindex.quantity,
                                                    'uid': auth.getUser()!.uid
                                                  });
                                                } else {
                                                  cref
                                                      .child(pindex.pname)
                                                      .update({
                                                    'quantity': ++pindex.quantity,
                                                    'prize': pindex.quantity *
                                                        pindex.prize,
                                                  });
                                                }
                                                setState(() {
                                                  total = total + pindex.prize;
                                                  pref
                                                      .child(
                                                          '-NO9A2WrPD86gpOYUwFy')
                                                      .update({
                                                    'total_prize': total,
                                                  });
                                                });
                                              },
                                              child: Icon(
                                                Icons.add_circle_outline,
                                                color: AllColors.maincolor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                separatorBuilder: ((context, index) {
                  return const Divider();
                }),
              );
            }
            return const CircularProgressIndicator();
          }),
          bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
        child: Container(
          height: 33.h,
          width: 350.w,
          decoration: BoxDecoration(
              color: AllColors.maincolor,
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.w, right: 20.w),
                child: Icon(
                  Icons.list,
                  color: AllColors.white,
                  size: 30,
                ),
              ),
              Container(
                  height: 32.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      color: AllColors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 17.w, top: 7.h, bottom: 6.h, right: 10.w),
                        child: Image.asset(
                          AllImages.cart,
                          height: 26.h,
                          width: 20.w,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 3.0.h),
                            child: Row(
                              children: [
                                Text(AllStrings.total,
                                    style: TextStyle(
                                        color: AllColors.prize, fontSize: 12)),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text('0',
                                  //'$total',
                                  style: TextStyle(
                                      color: AllColors.black, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                color: AllColors.maincolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: 5.w, top: 10.h, bottom: 10.h, right: 20.w),
                child: Text(
                  AllStrings.buythelist,
                  style: TextStyle(
                      color: AllColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
        
  }
}
