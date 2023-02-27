import 'dart:convert';
import 'package:demo_splash_screen/model/wishlist_data.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:demo_splash_screen/model/model.dart';
import 'package:demo_splash_screen/services/product_service.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key, required this.wishlist});
  WishlistData wishlist;
  static const String id = 'Product_Page';
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var _total = 0;
  var _totalquantity = 0;
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

  final ScrollController _controller = ScrollController();
  void initstate() {
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pop(context);
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
                                          lable: AppLocalizations.of(context)!
                                              .swap,
                                          icon: Icons.swap_horiz_sharp),
                                      Slidable_Action(
                                          lable: AppLocalizations.of(context)!
                                              .move,
                                          icon: Icons.move_to_inbox),
                                      Slidable_Action(
                                          lable: AppLocalizations.of(context)!
                                              .copy,
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
                                        Servives.removecart(--pindex.quantity,
                                            pindex.prize, pindex.pid);
                                        setState(() {
                                          if (_total > 0) {
                                            _total = _total - pindex.prize;
                                            _totalquantity = _totalquantity - 1;
                                            Servives.updateprize(
                                                total: _total,
                                                id: widget.wishlist.id!,
                                                quantity: _totalquantity);
                                          }
                                        });
                                      },
                                      onTapplus: () {
                                        Servives.addcart(
                                          quantity: ++pindex.quantity,
                                          prize: pindex.prize,
                                          pid: pindex.pid,
                                          pname: pindex.pname,
                                        );
                                        setState(() {
                                          _total = _total + pindex.prize;
                                          _totalquantity = _totalquantity + 1;
                                          Servives.updateprize(
                                              total: _total,
                                              id: widget.wishlist.id!,
                                              quantity: _totalquantity);
                                        });
                                      }));
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