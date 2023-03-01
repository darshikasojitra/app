import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/l10n/localization.dart';
import 'package:demo_splash_screen/model/wishlist_data.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  static const String id = 'List_Screen';
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ScrollController _scrollcontroller = ScrollController();
  final AuthService auth = AuthService();
  WishlistData? wishlistData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(context, () {
          Navigator.pushNamed(context, DashboardScreen.id);
        }, AppLocalizations.of(context)!.title, AllColors.maincolor),
        body: SingleChildScrollView(
            controller: _scrollcontroller,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('wishlist')
                    .doc(auth.getUser()!.uid)
                    .collection('userwishlist')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    // ignore: unrelated_type_equality_checks
                    if (snapshot.hasError == ConnectionState.waiting) {
                      return const Text('Loadinf');
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AllColors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          if (index == snapshot.data!.docs.length) {
                            return Container();
                          } else {
                            DocumentSnapshot doc =
                                snapshot.data!.docs.elementAt(index);
                            doc.id;
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                      wishlist: WishlistData(id: doc.id),
                                    ),
                                  )),
                              // Navigator.pushNamed(context, ProductPage.id),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: AllColors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                child: Container(
                                  height: 70.h,
                                  width: 330.w,
                                  decoration: BoxDecoration(
                                      color: AllColors.white,
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, top: 7.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '${doc['name']}',
                                                style: boldTextStyle(
                                                  color: AllColors.totals,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 100.h,
                                        width: 73.w,
                                        decoration: BoxDecoration(
                                            color: AllColors.slidable,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.r),
                                                bottomRight:
                                                    Radius.circular(10.r))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  StringManager.total,
                                                  style: regularTextStyle(
                                                      fontSize: 10.sp,
                                                      color: AllColors.totals),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Text(
                                                  '${doc['total_prize']}',
                                                  style: regularTextStyle(
                                                      fontSize: 12.sp,
                                                      color: AllColors.prize),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Quantity :${doc['total_quantity']}',
                                              style: boldTextStyle(
                                                fontSize: 11.sp,
                                                color: AllColors.maincolor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      );
                    }
                  } else {
                    return Container();
                  }
                })),
        bottomNavigationBar: const BottomnavigationbarTextfield());
  }
}
