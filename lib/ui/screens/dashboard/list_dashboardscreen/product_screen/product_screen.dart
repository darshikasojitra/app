import 'package:demo_splash_screen/model/wishlist_data.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:demo_splash_screen/model/model.dart';
import 'package:demo_splash_screen/services/product_service.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  ProductPage({super.key, required this.wishlist});
  WishlistData wishlist;
  static const String id = 'Product_Page';
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _controller = ScrollController();
  final List<ProductData> _productlist = [];
  var _total = 0;
  var _totalquantity = 0;
  late int savedtotal;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  Future<void> gettotal() async {
    prefs = await _prefs;
    savedtotal = (prefs.containsKey('saved') ? prefs.getInt('saved') : 0)!;
    setState(() {
      _total = savedtotal;
    });
  }
  @override
  void initState() {
    //gettotal();
    super.initState();
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
                      stream: Servives.loaddata(list: _productlist).asStream(),
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
                                        //prefs.setInt("saved", _total);
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
          ),
        ],
      ),
    );
  }
}
