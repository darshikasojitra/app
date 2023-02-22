import 'dart:convert';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/ui/screens/list_dashboardscreen/list_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:demo_splash_screen/ui/screens/product_screen/productcard/product.dart';
import 'package:demo_splash_screen/model/model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  static const String id = 'Product_Page';
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var documentID = '';
  var _total = 0;
  Future addData() async {}
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
  DatabaseReference pref = FirebaseDatabase.instance.ref("wishlist");
  
  final ScrollController _controller = ScrollController();
  void initstate() {
    loaddata();
  }

  void addcart(int quantity, int prize, String pid ,String pname) {
    if (quantity == 0) {
      cart.add({
        'pname':pname,
        'pid': pid,
        'prize': prize,
        'quantity': ++quantity,
        'uid': _auth.getUser()!.uid
      });
    } else {
      FirebaseFirestore.instance
          .collection("cart")
          .where("pid", isEqualTo: pid)
          .where("uid", isEqualTo: _auth.getUser()!.uid)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((element) {
                  documentID = element.reference.id;
                }),
                cart.doc(documentID).update({
                  'quantity': ++quantity,
                  'prize': quantity * prize,
                }),
              });
    }
    setState(() {
      _total = _total + prize;
      pref.child('-NO9A2WrPD86gpOYUwFy').update({
        'total_prize': _total,
      });
    });
  }

  void removecart(int quantity, int prize, String pid) {
    if (quantity > 0) {
      FirebaseFirestore.instance
          .collection("cart")
          .where("pid", isEqualTo: pid)
          .where("uid", isEqualTo: _auth.getUser()!.uid)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((element) {
                  documentID = element.reference.id;
                }),
                cart.doc(documentID).update({
                  'quantity': --quantity,
                  'prize': quantity * prize,
                }),
              });
    }
    setState(() {
      if (_total > 0) {
        _total = _total - prize;
      }
      pref.child('-NO9A2WrPD86gpOYUwFy').update({'total_prize': _total});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, ListScreen.id);
      }, AppLocalizations.of(context)!.home, AllColors.white),
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
                      CustomMaterialButtons(
                        color: AllColors.white,
                        buttontext: AppLocalizations.of(context)!.gotostore,
                        icon: Icons.store,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      CustomMaterialButtons(
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
                             var  pindex = _productlist[index];
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
                                    prize: pindex.prize,
                                    quantity: pindex.quantity,
                                    desc: pindex.desc,
                                    onTapminus: () {
                                      removecart(pindex.quantity,pindex.prize,pindex.pid);
                                    },
                                    onTapplus: () {
                                      addcart(pindex.quantity,pindex.prize,pindex.pid,pindex.pname);
                                      // if (pindex.quantity == 0) {
                                      //   cart.add({
                                      //     'pname': pindex.pname,
                                      //     'pid': pindex.pid,
                                      //     'prize': pindex.prize,
                                      //     'quantity': ++pindex.quantity,
                                      //     'uid': _auth.getUser()!.uid
                                      //   });
                                      // } else {
                                      //   FirebaseFirestore.instance
                                      //       .collection("cart")
                                      //       .where("pid", isEqualTo: pindex.pid)
                                      //       .where("uid",
                                      //           isEqualTo: _auth.getUser()!.uid)
                                      //       .get()
                                      //       .then((QuerySnapshot snapshot) => {
                                      //             snapshot.docs
                                      //                 .forEach((element) {
                                      //               documentID =
                                      //                   element.reference.id;
                                      //                    //print("my docid:"+documentID);
                                      //             }),
                                      //             cart.doc(documentID).update({
                                      //               'quantity':
                                      //                   ++pindex.quantity,
                                      //               'prize': pindex.quantity *
                                      //                   pindex.prize,
                                      //             }),
                                      //           });
                                      // }
                                      // setState(() {
                                      //   _total = _total + pindex.prize;
                                      //   pref
                                      //       .child('-NO9A2WrPD86gpOYUwFy')
                                      //       .update({
                                      //     'total_prize': _total,
                                      //   });
                                      // });

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
