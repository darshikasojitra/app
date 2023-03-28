import 'package:demo_splash_screen/ui/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/widgets/widget.dart';

class NewPaymentPage extends StatefulWidget {
  const NewPaymentPage({super.key});

  @override
  State<NewPaymentPage> createState() => _NewPaymentPageState();
}

class _NewPaymentPageState extends State<NewPaymentPage> {
  String? selectedImage;
  final ScrollController _scrollcontroller = ScrollController();
  TextEditingController cntrl = TextEditingController();
  static bool? checkval = false;
  static bool? chechboxval = false;
  final List _images = [AllImages.mastercard, AllImages.visa, AllImages.paypal];
  Future<void> _selectindex(int index) async {
    setState(() {
      selectedImage = _images[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollcontroller,
        child: SafeArea(
          child: Column(
            children: [
              appbar(context),
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 30.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55.h,
                      width: 300.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: cardImage(index),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 300.h,
                      width: 300.w,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: cardInfo(index),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              sizebox(height: 150.h),
              saveButton
            ],
          ),
        ),
      ),
    );
  }

  Widget appbar(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 10.w, top: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, PaymentMethodScreen.id),
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
                  style: boldTextStyle(fontSize: 16.sp, color: AllColors.black),
                ),
                sizebox(height: 5.h),
                Text(
                  'Choose your Payment Method',
                  style:
                      regularTextStyle(color: AllColors.black, fontSize: 12.sp),
                )
              ],
            ),
          ],
        ),
      );

  Widget cardImage(int index) => GestureDetector(
        onTap: () => _selectindex(index),
        child: Container(
          height: 55.h,
          width: 60.w,
          margin: EdgeInsets.symmetric(horizontal: 10.h),
          decoration: BoxDecoration(
            color: AllColors.grey,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: selectedImage == _images[index]
                  ? AllColors.fontcolor
                  : Colors.transparent,
              width: 2.w,
            ),
          ),
          child: Image.asset(
            _images[index].toString(),
          ),
        ),
      );

  Widget cardInfo(int index) => SizedBox(
        //height: 320.h,
        width: 300.w,
        child: selectedImage == _images[index]
            ? Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Column(
                  children: [
                    CustomTextFields(
                      obscureText: false,
                      validator: Validator.nameValidator,
                      hintText: 'Card holder name',
                      labelText: 'Card holder name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AllColors.buttoncolor),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AllColors.maincolor,
                          value: checkval,
                          onChanged: (value) {
                            setState(() {
                              checkval = value;
                            });
                          },
                        ),
                        const Text('Use name on account'),
                      ],
                    ),
                    CustomTextFields(
                      obscureText: false,
                      validator: Validator.nameValidator,
                      hintText: 'Card number',
                      labelText: 'Card number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AllColors.buttoncolor),
                      ),
                    ),
                    selectedImage == _images[2]
                        ? sizebox(height: 0)
                        : sizebox(height: 17.h),
                    selectedImage == _images[2]
                        ? const Text('')
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomTextFields(
                                  obscureText: false,
                                  hintText: 'Expiry date',
                                  labelText: 'Expiry date',
                                  validator: Validator.nameValidator,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AllColors.buttoncolor),
                                  ),
                                ),
                              ),
                              sizebox(width: 8.w),
                              Flexible(
                                child: CustomTextFields(
                                  obscureText: false,
                                  hintText: 'CCV',
                                  labelText: 'CCV',
                                  validator: Validator.nameValidator,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AllColors.buttoncolor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AllColors.maincolor,
                          value: chechboxval,
                          onChanged: (value) {
                            setState(() {
                              chechboxval = value;
                            });
                          },
                        ),
                        const Text('Set as default payment method'),
                      ],
                    ),
                  ],
                ),
              )
            : const Text(''),
      );

  Widget saveButton = Padding(
    padding: EdgeInsets.all(30.h),
    child: MaterialButton(
      height: 35.h,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      onPressed: () {},
      color: AllColors.maincolor,
      child: Text('Save',
          style: regularTextStyle(fontSize: 16.sp, color: AllColors.white)),
    ),
  );
}
