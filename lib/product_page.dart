import 'dart:convert';
import 'package:demo_splash_screen/auth_service.dart';
import 'package:demo_splash_screen/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class Product_Page extends StatefulWidget {
  const Product_Page({super.key});

  @override
  State<Product_Page> createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Home',
          style: TextStyle(color: Color(0xff000000)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 8.h),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/tesco.png',
                    fit: BoxFit.cover,
                    height: 17.h,
                    width: 70.w,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff1E8040),
                    size: 20,
                  ),
                  SizedBox(
                    width: 175.w,
                  ),
                  const Icon(
                    Icons.people,
                    color: Color(0xff1E8040),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 5, top: 20, bottom: 20, right: 20),
                    child: Icon(
                      Icons.share,
                      color: Color(0xff1E8040),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    height: 30.h,
                    minWidth: 157.w,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff1E8040), width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.store,
                          size: 22,
                          color: Color(0xff1E8040),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Text(
                          'Go to Store',
                          style: TextStyle(
                              color: Color(0xff1E8040),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  MaterialButton(
                    color: const Color(0xffF8FFEB),
                    onPressed: () {},
                    height: 30.h,
                    minWidth: 157.w,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xff1E8040), width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, top: 9.h, bottom: 8.h, right: 30.w),
                          child: const Text(
                            'New Idea',
                            style: TextStyle(
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        const Icon(
                          Icons.add_circle,
                          size: 22,
                          color: Color(0xff1E8040),
                        ),
                      ],
                    ),
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
                        return Slidable(
                          startActionPane: (ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  label: 'Check-off',
                                  backgroundColor: const Color(0xffE5E4D7),
                                  icon: Icons.check_box,
                                  foregroundColor: const Color(0xff707070),
                                  onPressed: (context) {},
                                ),
                              ])),
                          endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  label: 'Swap',
                                  backgroundColor: const Color(0xffE8FEBE),
                                  icon: Icons.swap_horiz,
                                  foregroundColor: const Color(0xff1E8040),
                                  onPressed: (context) {},
                                ),
                                SlidableAction(
                                  label: 'Move',
                                  backgroundColor: const Color(0xffE8FEBE),
                                  icon: Icons.move_to_inbox,
                                  foregroundColor: const Color(0xff1E8040),
                                  onPressed: (context) {},
                                ),
                                SlidableAction(
                                  label: 'Copy',
                                  backgroundColor: const Color(0xffE8FEBE),
                                  icon: Icons.copy,
                                  foregroundColor: const Color(0xff1E8040),
                                  onPressed: (context) {},
                                ),
                                SlidableAction(
                                  label: 'delete',
                                  backgroundColor: const Color(0xffE8FEBE),
                                  icon: Icons.delete,
                                  foregroundColor: const Color(0xff1E8040),
                                  onPressed: (context) { cref.remove();},
                                )
                              ]),
                          child: Card(
                            elevation: 0,
                            shadowColor: const Color(0xff00000034),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xff00000034), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 139.h,
                                  width: 97.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          _productlist[index].image),
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
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.h, bottom: 5.h)),
                                              const Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Color(0xff1E8040),
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              const Text(
                                                '4.5',
                                                style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ))),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.0.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 140.w, top: 10.h),
                                        child: Image.asset(
                                          'assets/tesco.png',
                                          fit: BoxFit.cover,
                                          height: 17.h,
                                          width: 70.w,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Text(_productlist[index].pname),
                                      Row(
                                        children: [
                                          Text(_productlist[index].pid),
                                          SizedBox(
                                            width: 170.w,
                                          ),
                                          const Text('6 x KG')
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            _productlist[index]
                                                .prize
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xff8D8D8D)),
                                          ),
                                          SizedBox(
                                            width: 135.w,
                                          ),
                                          const Text('£ 7.90',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xff333333))),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          const Text(
                                            '£ 6.90',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff1E8040),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        _productlist[index].desc,
                                        style: const TextStyle(
                                            color: Color(0xffB11F1F)),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 130.w,
                                                bottom: 5.h,
                                                top: 10.h),
                                            child: Container(
                                              height: 20.h,
                                              width: 90.w,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE8FEBE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      //cref.remove();
                                                      //cref.child('cart/').remove();
                                                      cref.child('pid/111').update({'quantity': ServerValue.increment(-1)});
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Color(0xff1E8040),
                                                    ),
                                                  ),
                                                  Text(_productlist[index]
                                                                .quantity.toString()),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                         ServerValue
                                                             .increment(1);
                                                      });
                                                      cref.push().set({
                                                        'pname':
                                                            _productlist[index]
                                                                .pname,
                                                        'pid':
                                                            _productlist[index]
                                                                .pid,
                                                        'amount':
                                                            _productlist[index]
                                                                .prize,
                                                        'quantity':1,
                                                        'uid':
                                                            auth.getUser()!.uid
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle_outline,
                                                      color: Color(0xff1E8040),
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
                  return CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
        child: Container(
          height: 33.h,
          width: 350.w,
          decoration: BoxDecoration(
              color: const Color(0xff1E8040),
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.w, right: 20.w),
                child: const Icon(
                  Icons.list,
                  color: Color(0xffFFFFFF),
                  size: 30,
                ),
              ),
              Container(
                  height: 32.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 17.w, top: 7.h, bottom: 6.h, right: 10.w),
                        child: Image.asset(
                          'assets/cart.png',
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
                                const Text('Totals',
                                    style: TextStyle(
                                        color: Color(0xff8D8D8D),
                                        fontSize: 12)),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Text(
                                  "320",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          const Text(
                            '£2000',
                            style: TextStyle(
                                color: Color(0xff1E8040),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: 5.w, top: 10.h, bottom: 10.h, right: 17.w),
                child: const Text(
                  'Buy the list',
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
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


                                
      
                      