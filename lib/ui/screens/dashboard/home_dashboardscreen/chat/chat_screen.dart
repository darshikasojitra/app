import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/home_dashboardscreen/chat/detail_chatscreen.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/list_dashboardscreen/product_screen/product_widget/product_widget.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, 'Chat', AllColors.maincolor),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.h, left: 16.h, right: 16.h),
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8.h),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(color: AllColors.maincolor),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 13.h,),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailChatScreen.id);
              },
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 595,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:const Text('Name'),
                        subtitle:const Text('data'),
                        leading: CircleAvatar(
                          backgroundColor: AllColors.maincolor,
                          child: Text(
                            'Name'.substring(0, 1).toUpperCase(),
                            style: regularTextStyle(
                                color: AllColors.white, fontSize: 20.sp),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
