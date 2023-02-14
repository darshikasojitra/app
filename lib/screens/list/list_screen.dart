import 'package:demo_splash_screen/screens/list/bottomnavigationbar_textfield.dart';
import 'package:demo_splash_screen/screens/product/product_screen.dart';
import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:demo_splash_screen/resources/all_string.dart';
import 'package:demo_splash_screen/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class List_Screen extends StatefulWidget {
  const List_Screen({super.key});

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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const dashboard_screen()));
              },
              child: Icon(
                Icons.arrow_back,
                color: AllColors.black,
              )),
          backgroundColor: AllColors.maincolor,
          title: Text(
            AllStrings.title,
            style: TextStyle(color: AllColors.black, fontSize: 20),
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  Product_Page())),
                          child: Card(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                   BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Container(
                              height: 70.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                  color: AllColors.white,
                                  borderRadius: BorderRadius.circular(20)),
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
                                        Text(
                                          '${list[index]['name']}',
                                          style: const TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100.h,
                                    width: 73.w,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffE8FEBE),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AllStrings.total,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: AllColors.totals),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(
                                              '${list[index]['total_prize']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AllColors.prize),
                                            ),
                                            
                                          ],
                                        ),
                                        Text(
                                          AllStrings.text2000,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AllColors.maincolor,
                                              fontWeight: FontWeight.bold),
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
