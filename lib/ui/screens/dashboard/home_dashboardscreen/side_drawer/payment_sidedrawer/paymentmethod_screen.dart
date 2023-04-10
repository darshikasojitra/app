import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/list_dashboardscreen/product_screen/product_widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';
import 'newpayment_page.dart';

class PaymentMethodScreen extends StatefulWidget {
  static const String id = 'PaymentMethodScreen';
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool? checkval = false;
  Future<void> _removecard(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      int index) async {
    FirebaseFirestore.instance
        .collection('cardinfo')
        .doc(snapshot.data?.docs[index].id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    bool? selectedCard = false;
    final ScrollController controller = ScrollController();
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, "Payment Methods", AllColors.white),
      body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              materialButton(),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('cardinfo')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 600.h,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data?.docs
                              .elementAt(index) as DocumentSnapshot<Object?>;
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: AllColors.grey),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              child: Container(
                                  height: 120.h,
                                  width: 335.w,
                                  decoration: BoxDecoration(
                                    color: AllColors.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: selectedCard == true
                                          ? AllColors.fontcolor
                                          : Colors.transparent,
                                      width: 3.w,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 120.h,
                                        width: 80.w,
                                        child: Image.asset(
                                          doc['image'].toString(),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '**** **** **** ' +
                                                      (doc['cardno']).substring(
                                                          (doc['cardno'])
                                                                  .length -
                                                              4),
                                                  style: regularTextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                sizedBoxSpacer(width: 72.w),
                                                PopupMenuButton(
                                                  iconSize: 20,
                                                  position:
                                                      PopupMenuPosition.under,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.sp)),
                                                  onSelected: (value) {
                                                    setState(() {});
                                                  },
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                        onTap: () {},
                                                        value: '/edit',
                                                        child:
                                                            const Text('Edit'),
                                                      ),
                                                      PopupMenuItem(
                                                        onTap: () =>
                                                            _removecard(
                                                                snapshot,
                                                                index),
                                                        value: '/remove',
                                                        child: const Text(
                                                            'Remove'),
                                                      )
                                                    ];
                                                  },
                                                )
                                              ],
                                            ),
                                            Text(
                                              '${doc['cardname']}',
                                              style: regularTextStyle(
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              '${doc['expdate']}',
                                              style: regularTextStyle(
                                                  fontSize: 12.sp),
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor:
                                                      AllColors.maincolor,
                                                  value: checkval,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checkval = value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Set as default payment method',
                                                  style: regularTextStyle(
                                                      fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          )),
    );
  }

  Widget materialButton() => MaterialButton(
      onPressed: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NewPaymentPage())),
      child: Text(
        'New Payment +',
        style: TextStyle(color: AllColors.maincolor, fontSize: 16.sp),
      ));
}
