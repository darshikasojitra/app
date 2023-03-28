import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/list_dashboardscreen/product_screen/product_widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';
import 'newpayment_page.dart';

class PaymentMethodScreen extends StatelessWidget {
  static const String id = 'PaymentMethodScreen';
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, "Payment Methods", AllColors.white),
      body: SingleChildScrollView(
          controller: _controller,
          child: Column(
            children: [
              MaterialButton(
                  onPressed: ()=>  Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NewPaymentPage())),
                  child: Text(
                    'New Payment +',
                    style: TextStyle(color: AllColors.maincolor,fontSize: 16.sp),
                  ))
            ],
          )),
    );
  }
}
