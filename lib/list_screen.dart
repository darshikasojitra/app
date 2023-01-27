import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/product_page.dart';
import 'package:demo_splash_screen/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class List_Screen extends StatefulWidget {
  const List_Screen({super.key});

  @override
  State<List_Screen> createState() => _List_ScreenState();
}

class _List_ScreenState extends State<List_Screen> {
  static const String _title = 'Your shopping List';
  final TextEditingController textcontroller = TextEditingController();
  final ScrollController _scrollcontroller = ScrollController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Color(0xff1E8040),
        title: Text(
          _title,
          style: TextStyle(color: Color(0xff000000), fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollcontroller,
        child: Padding(
          padding: const EdgeInsets.only(right:10.0,left: 10,top: 20),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Column( mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Private',
                            style: TextStyle(
                              color: Color(0xff8D8D8D),
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 259,
                    ),
                    Container(
                      height: 100,
                      width: 79,
                      decoration: BoxDecoration(
                          color: Color(0xffE8FEBE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Totals',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff8D8D8D)),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '780',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff333333)),
                              )
                            ],
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
             const SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohmmed',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Collaboration | Owner',
                              style: TextStyle(
                                color: Color(0xff8D8D8D),
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Image.asset(
                                'assets/tesco.png',
                                fit: BoxFit.cover,
                                height: 20,
                                width: 74,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 206,
                    ),
                    Container(
                      height: 100,
                      width: 79,
                      decoration: BoxDecoration(
                          color: Color(0xffE8FEBE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Totals',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff8D8D8D)),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '780',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff333333)),
                              )
                            ],
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohmmed / Home Screen',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Collaboration | Collaborator',
                              style: TextStyle(
                                color: Color(0xff8D8D8D),
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:10),
                              child: Container(
                                child: Image.asset(
                                  'assets/ocado.png',
                                  fit: BoxFit.cover,
                                  height: 20,
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 118,
                    ),
                    Container(
                      height: 100,
                      width: 79,
                      decoration: BoxDecoration(
                          color: Color(0xffE8FEBE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Totals',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff8D8D8D)),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '780',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff333333)),
                              )
                            ],
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
     ], ),
    ),),
      bottomSheet: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8, bottom: 8),
          child:
              TextField(
                textAlign: TextAlign.center,
                controller: textcontroller,
                autofocus: true,
                decoration: InputDecoration(
                  fillColor: Color(0xffF8FFEB),
                  floatingLabelStyle: TextStyle(color: Color(0xff1E8040)),
                  hintText: 'New List',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8,top: 0,bottom: 0),
                    child: FloatingActionButton.small(
                      backgroundColor:Color(0xff1E8040) ,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Product_Page()));
                //       FirebaseFirestore.instance
                // .collection('products')
                // .add({'text': 'data added through app'});
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Color(0xff1E8040)),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // )
      
        ),
      ),
    );
  }
}


/*bottomSheet: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextField(
                textAlign: TextAlign.center,
                controller: textcontroller,
                autofocus: true,
                decoration: InputDecoration(
                  fillColor: Color(0xffF8FFEB),
                  floatingLabelStyle: TextStyle(color: Color(0xff1E8040)),
                  hintText: 'New List',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8,top: 0,bottom: 0),
                    child: FloatingActionButton.small(
                      backgroundColor:Color(0xff1E8040) ,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Product_Page()));
                //       FirebaseFirestore.instance
                // .collection('products')
                // .add({'text': 'data added through app'});
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Color(0xff1E8040)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),*/
      /*Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 400,
            decoration: BoxDecoration(color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Column(
                    children: [
                      Text(
                        'Home',
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Private',
                        style: TextStyle(
                          color: Color(0xff8D8D8D),
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 259,
                ),
                Container(
                  height: 100,
                  width: 79,
                  decoration: BoxDecoration(color: Color(0xffE8FEBE),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15,),
                            child: Text(
                              'Totals',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xff8D8D8D)),
                            ),
                          ),SizedBox(width: 4,),
                          Text('780',style: TextStyle(
                                fontSize: 12, color: Color(0xff333333)),)
                        ],
                      ),
                      Text('£2000',style: TextStyle(fontSize: 16,color: Color(0xff1E8040),fontWeight: FontWeight.bold),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),,*/

        /*SingleChildScrollView(
        controller: _scrollcontroller,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Column( mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Home',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Private',
                            style: TextStyle(
                              color: Color(0xff8D8D8D),
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 259,
                    ),
                    Container(
                      height: 100,
                      width: 79,
                      decoration: BoxDecoration(
                          color: Color(0xffE8FEBE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Totals',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff8D8D8D)),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '780',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff333333)),
                              )
                            ],
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
             const SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohmmed',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Collaboration | Owner',
                              style: TextStyle(
                                color: Color(0xff8D8D8D),
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Image.asset(
                                'assets/tesco.png',
                                fit: BoxFit.cover,
                                height: 20,
                                width: 74,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 206,
                    ),
                    Container(
                      height: 100,
                      width: 79,
                      decoration: BoxDecoration(
                          color: Color(0xffE8FEBE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Totals',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff8D8D8D)),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '780',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff333333)),
                              )
                            ],
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mohmmed / Home Screen',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Collaboration | Collaborator',
                              style: TextStyle(
                                color: Color(0xff8D8D8D),
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:10),
                              child: Container(
                                child: Image.asset(
                                  'assets/ocado.png',
                                  fit: BoxFit.cover,
                                  height: 20,
                                  width: 90,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 118,
                    ),
                    Container(
                      height: 100,
                      width: 79,
                      decoration: BoxDecoration(
                          color: Color(0xffE8FEBE),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Text(
                                  'Totals',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xff8D8D8D)),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '780',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff333333)),
                              )
                            ],
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E8040),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
     ], ),
    ),),*/