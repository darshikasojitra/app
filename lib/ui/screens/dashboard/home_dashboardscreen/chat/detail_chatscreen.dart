import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailChatScreen extends StatefulWidget {
  static const String id = 'DetailChatScreen';
  const DetailChatScreen({super.key});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  TextEditingController chatController = TextEditingController();
  // List<ChatMessage> messages = [
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(
  //       messageContent: "Hey, I am doing fine dude. wbu?",
  //       messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(
  //       messageContent: "Is there any thing wrong?", messageType: "sender"),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.maincolor,
        flexibleSpace: SafeArea(
          child: chatappbar,
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('detailchat')
                  
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14.w, right: 14.w, top: 10.h, bottom: 10.h),
                        child: Align(
                          alignment: (Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AllColors.grey,
                            ),
                            padding: EdgeInsets.all(10.h),
                            child: Text(
                              snapshot.data?.docs[index]['chat'],
                              style: TextStyle(fontSize: 13.sp),
                            ),
                          ),
                        ),
                      );
                    },   
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          sendmessage(chatController),
        ],
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

Widget chatappbar = Row(
  children: [
    Padding(
      padding: EdgeInsets.only(left: 45.w),
      child: CircleAvatar(
        backgroundColor: AllColors.white,
        child: Text(
          'Name'.substring(0, 1).toUpperCase(),
          style: regularTextStyle(color: AllColors.black, fontSize: 20.sp),
        ),
      ),
    ),
    SizedBox(
      width: 5.w,
    ),
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Name',
            ),
            Text(
              'data',
            ),
          ],
        ),
      ),
    )
  ],
);
Widget sendmessage(TextEditingController chatController) => Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AllColors.maincolor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: AllColors.white,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Expanded(
              child: TextFormField(
                controller: chatController,
                decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                  suffixIcon: FloatingActionButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('detailchat')
                          .add({'chat': chatController.text});
                    },
                    backgroundColor: AllColors.maincolor,
                    elevation: 0,
                    child: Icon(
                      Icons.send,
                      color: AllColors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
// Container(
//                   //color: Colors.blue,
//                   padding: EdgeInsets.only(
//                       left: 14.w, right: 14.w, top: 10.h, bottom: 10.h),
//                   child: Align(
//                     alignment: (messages[index].messageType == "receiver"
//                         ? Alignment.topLeft
//                         : Alignment.topRight),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.r),
//                         color: (messages[index].messageType == "receiver"
//                             ? AllColors.grey
//                             : AllColors.maincolor),
//                       ),
//                       padding: EdgeInsets.all(10.h),
//                       child: Text(
//                         messages[index].messageContent,
//                         style: TextStyle(fontSize: 13.sp),
//                       ),
//                     ),
//                   ),
//                 );