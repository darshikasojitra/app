import 'dart:convert';
import 'package:demo_splash_screen/ui/screens/product/bottomnavigationbar_container.dart';
import 'package:demo_splash_screen/ui/screens/product/material_button.dart';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/model/product_data.dart';
import 'package:demo_splash_screen/ui/screens/product/product_card.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_images.dart';
import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:demo_splash_screen/ui/screens/list/list_screen.dart';
import 'package:demo_splash_screen/ui/screens/product/slidable_action.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Product_Page extends StatefulWidget {
  const Product_Page({super.key});
  static const String id = 'Product_Page';
  @override
  State<Product_Page> createState() => _Product_PageState();
}

// ignore: camel_case_types
class _Product_PageState extends State<Product_Page> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  var total = 0;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pushNamed(context, List_Screen.id);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Icon(
                Icons.arrow_back,
                color: AllColors.black,
              ),
            )),
        leadingWidth: 30,
        backgroundColor: AllColors.white,
        title: Text(
          StringManager.home,
          style: regularTextStyle(color: AllColors.black, fontSize: 16.sp),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 5.w, left: 8.h,right: 8.h,bottom: 50.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AllImages.tesco,
                        fit: BoxFit.cover,
                        height: 17.h,
                        width: 70.w,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AllColors.maincolor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 175.w,
                      ),
                      Icon(
                        Icons.people,
                        color: AllColors.maincolor,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5, top: 20, bottom: 20, right: 20),
                        child: Icon(
                          Icons.share,
                          color: AllColors.maincolor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      MaterialButtons(
                        color: AllColors.white,
                        buttontext: StringManager.gotostore,
                        icon: Icons.store,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Row(
                        children: [
                          MaterialButtons(
                            buttontext: StringManager.newidea,
                            color: AllColors.buttoncolor,
                            icon: Icons.add_circle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  StreamBuilder(
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
                                startActionPane: (ActionPane(
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        label: StringManager.checkoff,
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
                                        lable: StringManager.swap,
                                        icon: Icons.swap_horiz_sharp),
                                    Slidable_Action(
                                        lable: StringManager.move,
                                        icon: Icons.move_to_inbox),
                                    Slidable_Action(
                                        lable: StringManager.copy,
                                        icon: Icons.copy),
                                    Slidable_Action(
                                        lable: StringManager.delete,
                                        icon: Icons.delete),
                                  ],
                                ),
                                child: ProductCard(
                                  image: pindex.image.toString(),
                                  pname: pindex.pname,
                                  pid: pindex.pid,
                                  prize: pindex.prize.toString(),
                                  quantity: pindex.quantity.toString(),
                                  desc: pindex.desc,
                                  onTapminus: () {
                                    if (pindex.quantity > 0) {
                                      cref.child(pindex.pname).update({
                                        'quantity': --pindex.quantity,
                                        'prize': pindex.quantity * pindex.prize,
                                      });
                                    }
                                    setState(() {
                                      if (total > 0) {
                                        total = total - pindex.prize;
                                      }
                                      pref
                                          .child('-NO9A2WrPD86gpOYUwFy')
                                          .update({'total_prize': total});
                                    });
                                  },
                                  onTapplus: () {
                                    if (pindex.quantity == 0) {
                                      cref.child(pindex.pname).set({
                                        'pname': pindex.pname,
                                        'pid': pindex.pid,
                                        'prize': pindex.prize,
                                        'quantity': ++pindex.quantity,
                                        'uid': auth.getUser()!.uid
                                      });
                                    } else {
                                      cref.child(pindex.pname).update({
                                        'quantity': ++pindex.quantity,
                                        'prize': pindex.quantity * pindex.prize,
                                      });
                                    }
                                    setState(() {
                                      total = total + pindex.prize;
                                      pref
                                          .child('-NO9A2WrPD86gpOYUwFy')
                                          .update({
                                        'total_prize': total,
                                      });
                                    });
                                  },
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
                ],
              ),
            ),
          ),
          Positioned(
            left: 3,
            top: 760,
            right: 3,
            child: BottomnavigationbarContaineer(
              total: total,
            ),
          )
        ],
      ),
    );
  }
}


 // MaterialButton(
                  //   color: AllColors.buttoncolor,
                  //   onPressed: () {},
                  //   height: 30.h,
                  //   minWidth: 157.w,
                  //   shape: RoundedRectangleBorder(
                  //       side: BorderSide(color: AllColors.maincolor, width: 1),
                  //       borderRadius: BorderRadius.circular(40)),
                  //   child: Row(
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(
                  //             left: 15.w, top: 9.h, bottom: 8.h, right: 30.w),
                  //         child: Text(
                  //           StringManager.newidea,
                  //           style: TextStyle(
                  //               color: AllColors.maincolor,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 16),
                  //         ),
                  //       ),
                  //       Icon(
                  //         Icons.add_circle,
                  //         size: 22,
                  //         color: AllColors.maincolor,
                  //       ),
                  //     ],
                  //   ),
                  // ),