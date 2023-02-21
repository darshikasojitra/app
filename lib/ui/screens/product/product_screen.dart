import 'dart:convert';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/model/auth_service.dart';
import 'package:demo_splash_screen/model/product_data.dart';
import 'package:demo_splash_screen/ui/screens/list/list_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:demo_splash_screen/ui/screens/product/productcard/product.dart';

class Product_Page extends StatefulWidget {
  const Product_Page({super.key});
  static const String id = 'Product_Page';
  @override
  State<Product_Page> createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {
  var documentID = '';
  var _total = 0;
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

  final AuthService _auth = AuthService();
  var cart = FirebaseFirestore.instance.collection('cart');
  var wishlist = FirebaseFirestore.instance.collection('wishlist');
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
              padding: EdgeInsets.only(
                  top: 5.w, left: 8.h, right: 8.h, bottom: 50.w),
              child: Column(
                children: [
                 const DropDownBar(),
                  Row(
                    children: [
                      MaterialButtons(
                        color: AllColors.white,
                        buttontext: AppLocalizations.of(context)!.gotostore,
                        icon: Icons.store,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      MaterialButtons(
                        buttontext: AppLocalizations.of(context)!.newidea,
                        color: AllColors.buttoncolor,
                        icon: Icons.add_circle,
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
                                        label: AppLocalizations.of(context)!
                                            .checkoff,
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
                                        lable:
                                            AppLocalizations.of(context)!.swap,
                                        icon: Icons.swap_horiz_sharp),
                                    Slidable_Action(
                                        lable:
                                            AppLocalizations.of(context)!.move,
                                        icon: Icons.move_to_inbox),
                                    Slidable_Action(
                                        lable:
                                            AppLocalizations.of(context)!.copy,
                                        icon: Icons.copy),
                                    Slidable_Action(
                                        lable: AppLocalizations.of(context)!
                                            .delete,
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
                                        FirebaseFirestore.instance
                                            .collection("cart")
                                            .where("pid", isEqualTo: pindex.pid)
                                            .where("uid",
                                                isEqualTo: _auth.getUser()!.uid)
                                            .get()
                                            .then((QuerySnapshot snapshot) => {
                                                  snapshot.docs
                                                      .forEach((element) {
                                                    documentID =
                                                        element.reference.id;
                                                  }),
                                                  cart.doc(documentID).update({
                                                    'quantity':
                                                        --pindex.quantity,
                                                    'prize': pindex.quantity *
                                                        pindex.prize,
                                                  }),
                                                });
                                      }
                                      setState(() {
                                        if (_total > 0) {
                                          _total = _total - pindex.prize;
                                        }
                                        pref
                                            .child('-NO9A2WrPD86gpOYUwFy')
                                            .update({'total_prize': _total});
                                      });
                                    },
                                    onTapplus: () {
                                      if (pindex.quantity == 0) {
                                        cart.add({
                                          'pname': pindex.pname,
                                          'pid': pindex.pid,
                                          'prize': pindex.prize,
                                          'quantity': ++pindex.quantity,
                                          'uid': _auth.getUser()!.uid
                                        });
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection("cart")
                                            .where("pid", isEqualTo: pindex.pid)
                                            .where("uid",
                                                isEqualTo: _auth.getUser()!.uid)
                                            .get()
                                            .then((QuerySnapshot snapshot) => {
                                                  snapshot.docs
                                                      .forEach((element) {
                                                    documentID =
                                                        element.reference.id;
                                                  }),
                                                  cart.doc(documentID).update({
                                                    'quantity':
                                                        ++pindex.quantity,
                                                    'prize': pindex.quantity *
                                                        pindex.prize,
                                                  }),
                                                });
                                      }
                                      setState(() {
                                        _total = _total + pindex.prize;
                                        pref
                                            .child('-NO9A2WrPD86gpOYUwFy')
                                            .update({
                                          'total_prize': _total,
                                        });
                                      });
                                    }),
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
            left: 3.w,
            top: 590.h,
            right: 3.w,
            child: BottomnavigationbarContaineer(
              total: _total,
            ),
          )
        ],
      ),
    );
  }
}
