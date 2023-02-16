import 'package:demo_splash_screen/resources/all_style.dart';
import 'package:demo_splash_screen/ui/screens/list/bottomnavigationbar_textfield.dart';
import 'package:demo_splash_screen/ui/screens/product/product_screen.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/string_manager.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class List_Screen extends StatefulWidget {
  const List_Screen({super.key});
static const String id = 'List_Screen';
  @override
  State<List_Screen> createState() => _List_ScreenState();
}

class _List_ScreenState extends State<List_Screen> {
  DatabaseReference pref = FirebaseDatabase.instance.ref("wishlist");
  final ScrollController _scrollcontroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context,
                   dashboard_screen.id);
              },
              child: Icon(
                Icons.arrow_back,
                color: AllColors.black,
              )),
          backgroundColor: AllColors.maincolor,
          title: Text(
            StringManager.title,
            style: regularTextStyle(color: AllColors.black, fontSize: 17.sp),
          ),
        ),
        body: SingleChildScrollView(
            controller: _scrollcontroller,
            child: StreamBuilder(
                stream: pref.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final Map<String, dynamic> map = Map<String, dynamic>.from(
                        snapshot.data!.snapshot.value as Map);
                    List list = [];
                    list.clear();
                    list = map.values.toList();
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context,
                              Product_Page.id),
                          child: Card(
                            elevation: 0,
                            shape:  RoundedRectangleBorder(side: BorderSide(color: AllColors.grey),
                              borderRadius:
                                   BorderRadius.all(Radius.circular(10.r),),
                            ),
                            child: Container(
                              height: 70.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                  color: AllColors.white,
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.w, top: 7.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${list[index]['name']}',
                                            style:  boldTextStyle(
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
                                        borderRadius:
                                            BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
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
                                              '${list[index]['total_prize']}',
                                              style: regularTextStyle(
                                                  fontSize: 12.sp,
                                                  color: AllColors.prize),
                                            ),
                                            
                                          ],
                                        ),
                                        Text(
                                          StringManager.text2000,
                                          style: boldTextStyle(
                                              fontSize: 15.sp,
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
                      }),
                    );
                  }
                  return const CircularProgressIndicator();
                })),
        bottomNavigationBar: const BottomnavigationbarTextfield());
  }
}
