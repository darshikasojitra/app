import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Product_Page extends StatefulWidget {
  const Product_Page({super.key});

  @override
  State<Product_Page> createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {
  bool isChecked = false;
  var _itemCount = 10;
  ScrollController _controller = ScrollController();
  TextEditingController newcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Home',
          style: TextStyle(color: Color(0xff000000)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {},
                    height: 40,
                    minWidth: 150,
                    child: Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 22,
                          color: Color(0xff1E8040),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Go to Store',
                          style: TextStyle(
                              color: Color(0xff1E8040),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff1E8040), width: 1),
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  SizedBox(
                    width: 90,
                  ),
                  MaterialButton(color: Color(0xffF8FFEB),
                    onPressed: () {},
                    height: 40,
                    minWidth: 150,
                    child: Row(
                      children: [
                        Text(
                          'New Idea',
                          style: TextStyle(
                              color: Color(0xff1E8040),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 9,bottom: 9,right: 1),
                          child: Icon(
                            Icons.add_circle,
                            size: 22,
                            color: Color(0xff1E8040),
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff1E8040), width: 1),
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  /*MaterialButton(
                    onPressed: () {},
                    height: 30,
                    minWidth: 90,
                    child: Row(
                      children: [
                        Text(
                          'New Idea',
                          style: TextStyle(
                              color: Color(0xff1E8040),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MaterialButton(
                            color: Color(0xff1E8040),
                            onPressed: () {},
                            shape: CircleBorder(
                                side: BorderSide(
                              color: Color(0xff1E8040),
                            )),
                            child: Icon(
                              Icons.add,
                              size: 10,
                              color: Color(0xffE8FEBE),
                            )),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xff1E8040), width: 1),
                        borderRadius: BorderRadius.circular(30)),
                  ),*/
                ],
              ),
            ),
            Container(
              child: ListView.separated(
                controller: _controller,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 5),
                itemCount: _itemCount,
                itemBuilder: ((context, int index) {
                  return Slidable(
                    startActionPane:
                        (ActionPane(motion: DrawerMotion(), children: [
                      SlidableAction(
                        label: 'Check-off',
                        backgroundColor: Color(0xffE5E4D7),
                        icon: Icons.check_box,
                        foregroundColor: Color(0xff707070),
                        onPressed: (context) {},
                      ),
                    ])),
                    endActionPane:
                        ActionPane(motion: DrawerMotion(), children: [
                      SlidableAction(
                        label: 'Swap',
                        backgroundColor: Color(0xffE8FEBE),
                        icon: Icons.swap_horiz,
                        foregroundColor: Color(0xff1E8040),
                        onPressed: (context) {},
                      ),
                      SlidableAction(
                        label: 'Move',
                        backgroundColor: Color(0xffE8FEBE),
                        icon: Icons.move_to_inbox,
                        foregroundColor: Color(0xff1E8040),
                        onPressed: (context) {},
                      ),
                      SlidableAction(
                        label: 'Copy',
                        backgroundColor: Color(0xffE8FEBE),
                        icon: Icons.copy,
                        foregroundColor: Color(0xff1E8040),
                        onPressed: (context) {},
                      ),
                      SlidableAction(
                        label: 'delete',
                        backgroundColor: Color(0xffE8FEBE),
                        icon: Icons.delete,
                        foregroundColor: Color(0xff1E8040),
                        onPressed: (context) {},
                      )
                    ]),
                    child: Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 170,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/sb.jpeg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(margin: EdgeInsets.all(5),
                                    height: 20,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Row(
                                      children: const[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 5,  bottom: 5)),
                                        Icon(
                                          Icons.star,
                                          size: 15,
                                          color: Color(0xff1E8040),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ))),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            height: 170,
                            width: 260,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 180),
                                  child: Image.asset(
                                    'assets/tesco.png',
                                    fit: BoxFit.cover,
                                    height: 20,
                                    width: 74,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 180),
                                    child: const Text('Samsung TV')),
                                Row(
                                  children: const [
                                    Text('Screen size'),
                                    SizedBox(
                                      width: 120,
                                    ),
                                    Text('6 x KG')
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      '(500 g - £5)',
                                      style:
                                          TextStyle(color: Color(0xff8D8D8D)),
                                    ),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    Text('£ 7.90',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xff333333))),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      '£ 6.90',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff1E8040),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 125),
                                  child: const Text(
                                    'Lorem Ipsum dolor....',
                                    style: TextStyle(color: Color(0xffB11F1F)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MaterialButton(
                                        color: Color(0xffE8FEBE),
                                        shape: const CircleBorder(
                                            side: BorderSide(
                                                color: Color(0xff1E8040))),
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                        )),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text('1'),
                                    MaterialButton(
                                        color: Color(0xffE8FEBE),
                                        onPressed: () {},
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Color(0xff1E8040))),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        )),
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
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 0),
        child: Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
              color: Color(0xff1E8040),
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 20),
                child: Icon(
                  Icons.list,
                  color: Color(0xffFFFFFF),
                  size: 30,
                ),
              ),
              Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 19, top: 7, bottom: 6, right: 13),
                        child: Image.asset(
                          'assets/Group 1648.png',
                          height: 26,
                          width: 24,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Row(
                              children: [
                                Text('Totals',
                                    style: TextStyle(
                                        color: Color(0xff8D8D8D),
                                        fontSize: 12)),
                                Text(
                                  '780',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Text(
                            '£2000',
                            style: TextStyle(
                                color: Color(0xff1E8040),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, bottom: 10, right: 10),
                child: Text(
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

    //   body: StreamBuilder(
    //   stream: FirebaseFirestore.instance.collection("products").snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     return ListView(
    //       children: snapshot.data!.document.map((document) {
    //         return Container(
    //           child: Center(child: Text(document['text'])),
    //         );
    //       }).toList(),
    //     );
    //   },
    // ),
  }
}
/*Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              height: 40,
              width: 335,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xff1E8040),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ]),
        ),*/

      /*TextField(
                controller: newcontroller,
                autofocus: true,
                decoration: InputDecoration(
                    fillColor: Color(0xffF8FFEB),
                    floatingLabelStyle: TextStyle(color: Color(0xff1E8040)),
                    hintText: 'New List',
                    suffixIcon: FloatingActionButton.small(//mini:true,
                      backgroundColor:Color(0xff1E8040) ,
                      onPressed: () {},
                      child: Icon(
                        Icons.add,size: 20,
                        color: Colors.white,
                      ),
                      //shape: CircleBorder(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Color(0xff1E8040)),
                    ),
                ),
              ),*/

              /*Container(
                    height: 40,
                    width: 150,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: newcontroller,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF8FFEB),
                        floatingLabelStyle: TextStyle(color: Color(0xff1E8040),backgroundColor: Color(0xffF8FFEB),),
                        hintText: 'New Idea',
                        border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                 
                      ),
                      focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                   borderSide: BorderSide(color: Color(0xff1E8040)),
                   ),
                    ),
                  ),)*/

                  /*SlidableAction(
                        label: 'delete',
                        backgroundColor: Color(0xffE8FEBE),
                        icon: Icons.delete,
                        onPressed: (context) {},
                      )*/