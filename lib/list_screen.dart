import 'package:demo_splash_screen/product_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class List_Screen extends StatefulWidget {
  const List_Screen({super.key});

  @override
  State<List_Screen> createState() => _List_ScreenState();
}

class _List_ScreenState extends State<List_Screen> {
  DatabaseReference pref = FirebaseDatabase.instance.ref("product");
   
  static const String _title = 'Your shopping List';
  TextEditingController textcontroller = TextEditingController();
  final ScrollController _scrollcontroller = ScrollController();
  List<String> firsttitle = ['Home', 'Mohmmed', 'Mohmmed / Home Screen'];
  List<String> secondtitle = [
    'Private',
    'Collaboration | Owner',
    'Collaboration | Collaborator'
  ];
  List<String> images = [
    'assets/tesco.png',
    'assets/tesco.png',
    'assets/ocado.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Color(0xff1E8040),
        title: const Text(
          _title,
          style: TextStyle(color: Color(0xff000000), fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
          controller: _scrollcontroller,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              shrinkWrap: true,
              itemCount: firsttitle.length,
              itemBuilder: ((context, index) {
                return Card(
                  shadowColor: const Color(0xff00000034),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xff00000034), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    height: 70.h,
                    width: 330.w,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 7.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${firsttitle[index]}',
                                style: const TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                '${secondtitle[index]}',
                                style: const TextStyle(
                                  color: Color(0xff8D8D8D),
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Image.asset(
                                '${images[index]}',
                                fit: BoxFit.cover,
                                height: 17.h,
                                width: 74.w,
                              ),
                            ],
                          ),
                        ),
                        const LastContainer(),
                      ],
                    ),
                  ),
                );
              }))),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 8.h),
        child: Container(
          height: 35.h,
          width: 340.w,
          child: TextField(
              textAlign: TextAlign.center,
              controller: textcontroller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'New List',
                suffixIcon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Product_Page()));
                      pref.push().set(
                          {'pname': textcontroller.text,
                          'image':'https://www.forbesindia.com/media/images/2022/Sep/img_193773_banana.jpg',
                          'prize':70,
                          'quantity':0,
                          });
                    },
                    icon: const Icon(Icons.add_circle, color: Color(0xff1E8040))),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff1E8040)),
                ),
              ),
            ),)));
  }}

class LastContainer extends StatelessWidget {
  const LastContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 73.w,
      decoration: BoxDecoration(
          color: const Color(0xffE8FEBE),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                ),
                child: const Text(
                  'Totals',
                  style: TextStyle(fontSize: 10, color: Color(0xff8D8D8D)),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              const Text(
                '780',
                style: TextStyle(fontSize: 12, color: Color(0xff333333)),
              )
            ],
          ),
          const Text(
            '£2000',
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff1E8040),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
