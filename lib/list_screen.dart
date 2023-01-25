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
      body: Container(
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
      ),
    );
  }
}
