import 'package:demo_splash_screen/controller/usdata_provider.dart';
import 'package:demo_splash_screen/model/responses/data_info.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final UsDataProvider _usDataProvider = UsDataProvider();
  final ScrollController _scrollcontroller = ScrollController();
  Future<void> _getinfo(Source? data) async {
    final Uri url = Uri.parse(data?.annotations?.datasetLink ?? "");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollcontroller,
      child: Column(
        children: [
          SizedBox(
            child: StreamBuilder(
              stream: _usDataProvider.getUsData().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.source!.length,
                    itemBuilder: (context, index) {
                      final sourcedata =
                          snapshot.data?.source?.elementAt(index);
                      return Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Card(
                            color: AllColors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: AllColors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: SizedBox(
                              height: 82.h,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, top: 20, right: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((sourcedata?.measures).toString()),
                                    Text((sourcedata?.annotations?.sourceName)
                                        .toString()),
                                    Padding(
                                      padding: EdgeInsets.only(left: 190.w),
                                      child: TextButton(
                                          onPressed: () => _getinfo(sourcedata),
                                          child: Text(
                                            StringManager.getmoreinfo,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 12.sp,
                                                color: AllColors.maincolor),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
              height: 680,
              child: StreamBuilder(
                stream: _usDataProvider.getUsData().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.udata?.length,
                        itemBuilder: ((context, index) {
                          final uslocaldata =
                              snapshot.data?.udata?.elementAt(index);
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: AllColors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: SizedBox(
                              height: 70.h,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, top: 20, right: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ID Nation: ${uslocaldata?.slugNation ?? ''}'),
                                    Text(
                                        'Population : ${(uslocaldata?.population).toString()}'),
                                    Text('Year : ${uslocaldata?.year ?? ''}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ))
        ],
      ),
    );
  }
}
