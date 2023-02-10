import 'dart:convert';
import 'package:demo_splash_screen/auth_service.dart';
import 'package:demo_splash_screen/model/product_data.dart';
import 'package:demo_splash_screen/product_card.dart';
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
  String newKey = "";
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
   final ScrollController _controller = ScrollController();

  void initstate() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                                  margin: const EdgeInsets.all(5),
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
                                    width: 135.w,
                                  ),
                                  Text('£ 7.90',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: AllColors.totals)),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text(
                                    '£ 6.90',
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
                                                cref.child(newKey).update({
                                                  'quantity': --pindex.quantity,
                                                  'prize': pindex.quantity *
                                                      pindex.prize,
                                                });
                                              }
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
                                                newKey = cref.push().key!;
                                                cref.child(newKey).set({
                                                  'pname': pindex.pname,
                                                  'pid': pindex.pid,
                                                  'prize': pindex.prize,
                                                  'quantity': ++pindex.quantity,
                                                  'uid': auth.getUser()!.uid
                                                });
                                              } else {
                                                cref.child(newKey).update({
                                                  'quantity': ++pindex.quantity,
                                                  'prize': pindex.quantity *
                                                      pindex.prize,
                                                });
                                              }
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
        });
  }
}
