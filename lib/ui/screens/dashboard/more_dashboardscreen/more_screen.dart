import 'package:demo_splash_screen/controller/cocktail_provider.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/widgets/widget.dart';
import 'package:demo_splash_screen/l10n/localization.dart';

class MoreScreen extends StatefulWidget {
  static var querypara;

  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final ScrollController _scrollcontroller = ScrollController();
  TextEditingController textcontroller = TextEditingController();
  final CocktailProvider _cocktailprovider = CocktailProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, AppLocalizations.of(context)!.drink, AllColors.maincolor),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollcontroller,
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                left: 10.w,
              ),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    child: Row(
                      children: [
                        Container(
                            height: 40,
                            width: 290,
                            child: TextFormField(
                              controller: textcontroller,
                              decoration: InputDecoration(
                                hintText: 'Search here drinks',
                                contentPadding: EdgeInsets.only(left: 8.w),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AllColors.maincolor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AllColors.maincolor)),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                            color: AllColors.maincolor,
                            onPressed: () async {
                              await _cocktailprovider
                                  .getcoctailData(textcontroller.text);
                              setState(() {});
                            },
                            child: Text(
                              'Search',
                              style: TextStyle(color: AllColors.white),
                            )),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      apicocktaildata(_cocktailprovider, textcontroller.text)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget apicocktaildata(CocktailProvider cocktailprovider, String controller) =>
    StreamBuilder(
      stream: cocktailprovider.getcoctailData(controller).asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.drinks != null) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data?.drinks?.length,
                itemBuilder: (context, index) {
                  final coctaildrinkdata =
                      snapshot.data?.drinks?.elementAt(index);
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: SizedBox(
                      height: 100.h,
                      width: 400.w,
                      child: Row(
                        children: [
                          Container(
                            height: 100.h,
                            width: 95.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),
                                  topLeft: Radius.circular(10.r)),
                              image: DecorationImage(
                                image: NetworkImage(
                                  (coctaildrinkdata?.strDrinkThumb).toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 15.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Drinkid : ${(coctaildrinkdata?.idDrink).toString()}'),
                                Text(
                                    'Drink : ${(coctaildrinkdata?.strDrink).toString()}'),
                                Text(
                                    'DrinkCategory : ${coctaildrinkdata?.strCategory}'),
                                Text('Glass : ${coctaildrinkdata?.strGlass}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Text('No Data');
          }
        }
        return Center(
            child: Padding(
          padding: EdgeInsets.only(top: 230.h),
          child: Text(
            'Search Your Favorite Drinks',
            style:
                regularTextStyle(color: AllColors.maincolor, fontSize: 17.sp),
          ),
        ));
      },
    );
