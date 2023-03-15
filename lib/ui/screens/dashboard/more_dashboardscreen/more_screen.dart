import 'package:demo_splash_screen/controller/cocktail_provider.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/widgets/widget.dart';
import 'package:demo_splash_screen/l10n/localization.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final ScrollController _scrollcontroller = ScrollController();
  final CocktailProvider _cocktailprovider = CocktailProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, AppLocalizations.of(context)!.drink, AllColors.maincolor),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollcontroller,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 10.h),
              child: StreamBuilder(
                stream: _cocktailprovider.getcoctailData().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.drinks!.length,
                      itemBuilder: (context, index) {
                        final coctaildrinkdata =
                            snapshot.data!.drinks!.elementAt(index);
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
                                        (coctaildrinkdata.strDrinkThumb)
                                            .toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.w, top: 15.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Drinkid : ${(coctaildrinkdata.idDrink).toString()}'),
                                      Text(
                                          'Drink : ${(coctaildrinkdata.strDrink).toString()}'),
                                      Text(
                                          'DrinkCategory : ${coctaildrinkdata.strCategory}'),
                                      Text(
                                          'Glass : ${coctaildrinkdata.strGlass}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
