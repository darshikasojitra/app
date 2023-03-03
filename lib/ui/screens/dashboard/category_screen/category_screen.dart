import 'package:demo_splash_screen/controller/controller.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final UsDataProvider _usDataProvider = UsDataProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _usDataProvider.getUsData().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.udata?.length,
                  itemBuilder: ((context, index) {
                    var uslocaldata = snapshot.data?.udata?.elementAt(index);
                    return Card(
                      color: AllColors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AllColors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID Nation: ${uslocaldata?.slugNation ?? ''}'),
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
          }),
    );
  }
}
