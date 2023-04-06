import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/vendor_dashboardscreen/addnewuser_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Vendors');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AllColors.maincolor,
          title: customSearchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (customIcon.icon == Icons.search) {
                      customIcon = const Icon(Icons.cancel);
                      customSearchBar = const ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                        title: TextField(
                          decoration: InputDecoration(
                            hintText: 'type in vendor name...',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else {
                      customIcon = const Icon(Icons.search);
                      customSearchBar = const Text('Vendors');
                    }
                  });
                },
                icon: customIcon)
          ]),
      body: Stack(children: [
        Positioned(
          top: 510.h,
          left: 10.w,
          right: 10.w,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: MaterialButton(
                height: 40.h,
                color: AllColors.buttoncolor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AllColors.maincolor),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AddNewUserScreen.id);
                },
                child: Text(
                  'Add Favorite Vendor',
                  style: regularTextStyle(
                      color: AllColors.maincolor, fontSize: 14.sp),
                ),
              )),
        )
      ]),
    );
  }
}
