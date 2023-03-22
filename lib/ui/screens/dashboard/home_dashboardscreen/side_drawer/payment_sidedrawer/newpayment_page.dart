import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../widgets/widget.dart';

class NewPaymentPage extends StatefulWidget {
  const NewPaymentPage({super.key});

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  String? selectedImage;
  Widget? selectinfo;
  TextEditingController cntrl = TextEditingController();
  static bool? checkval = false;
  final List _images = [
    AllImages.mastercard,
    AllImages.visa,
    AllImages.paypal
    // Image.asset(AllImages.mastercard),
    // Image.asset(AllImages.visa),
    // Image.asset(AllImages.paypal)
  ];
  //final List<Widget> _info =[paymentinfo(checkval),paymentinfo(checkval),paymentinfo(checkval)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 15.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      height: 21.h,
                      width: 27.w,
                      child: Icon(
                        Icons.arrow_back,
                        size: 21.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    children: [
                      Text(
                        'New payment method',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,
                        style: boldTextStyle(
                            fontSize: 16.sp, color: AllColors.black),
                      ),
                      sizebox(height: 5.h),
                      Text(
                        'Choose your Payment Method',
                        style: regularTextStyle(
                            color: AllColors.black, fontSize: 12.sp),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, top: 30.h),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 30,
                          color: Colors.blue,
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                            ),
                            //  color: Colors.green,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = _images[index];
                                });
                              },
                              child: Container(
                                height: 50.h,
                                width: 50.w,
                                margin: EdgeInsets.symmetric(horizontal: 20.h),
                                decoration: BoxDecoration(
                                  color: AllColors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selectedImage == _images[index]
                                        ? AllColors.fontcolor
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                // child: Image.asset(
                                //   _images[index].toString(),
                                //   fit: BoxFit.cover,
                                //   height: 30.h,
                                //   width: 50.w,
                                // ),
                              ),
                            ),
                          ),
                        );
                        // selectedImage == _images[index]
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(top: 70),
                        //         child: Container(
                        //           height: 550,
                        //           width: 100,
                        //           color: Colors.amber,
                        //           child: Column(
                        //             children: [
                        //               TextFormField(),
                        //               Row(
                        //                 children: [
                        //                   Checkbox(
                        //                     value: checkval,
                        //                     onChanged: (value) {
                        //                       checkval = value;
                        //                     },
                        //                   ),
                        //                   Text('Use name on account'),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     : Text('data')
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget paymentinfo(bool? checkval) => Padding(
  //       padding: const EdgeInsets.only(top: 50, left: 10),
  //       child: Form(
  //         child: SizedBox(
  //           height: 500,
  //           child: Column(
  //             children: [
  //               Expanded(
  //                   flex: 1,
  //                   child: TextFormField(
  //                     decoration: const InputDecoration(hintText: 'card no.'),
  //                   )),
  //               //  CustomTextFields(
  //               //               obscureText: false,
  //               //               controller: cntrl,
  //               //               labelText: 'card no.',
  //               //               hintText: 'card no.',
  //               //               validator: Validator.nameValidator),
  //               Row(
  //                 children: [
  //                   Checkbox(
  //                     value: checkval,
  //                     onChanged: (value) {
  //                       checkval = value;
  //                     },
  //                   ),
  //                   Text('Use name on account'),
  //                 ],
  //               ),
  //               Expanded(flex: 1, child: TextFormField()),
  //               Expanded(flex: 1, child: TextFormField()),
  //               Expanded(flex: 1, child: TextFormField()),
  //               Row(
  //                 children: [
  //                   Checkbox(
  //                     value: checkval,
  //                     onChanged: (value) {
  //                       checkval = value;
  //                     },
  //                   ),
  //                   Text('Set as default payment method'),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}


// class PaymentInfo extends StatelessWidget {
//   const PaymentInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool? checkval = false;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextFormField(controller: ,decoration: InputDecoration(
//               hintText: 'Card holder name',
//             ),),
//         Row(
//           children: [
//             Checkbox(value: checkval, onChanged: (value) {
//               checkval = value;
//             },),
//             Text('Use name on account'),
//           ],
//         ),
//         TextFormField(decoration: InputDecoration(
//               hintText: 'Card number',
//             ),),
//         Row(
//           children: [
//             TextFormField(decoration: InputDecoration(
//               hintText: 'Expiry date',
//             ),),
//              TextFormField(decoration: InputDecoration(
//               hintText: 'CCV',
//             ),),
//           ],
//         ),
//         Row(
//           children: [
//             Checkbox(value: checkval, onChanged: (value) {
//               checkval = value;
//             },),
//             Text('Set as default payment method'),
//           ],
//         ),
//       ],
//     );
//   }
// }
