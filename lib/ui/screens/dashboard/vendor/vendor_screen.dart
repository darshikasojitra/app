import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../controller/controller.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final UsDataProvider _usDataProvider = UsDataProvider();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usDataProvider.getUsData().asStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.source!.length,
            itemBuilder: (context, index) {
              var ldata = snapshot.data?.source?.elementAt(index);
              return Center(
                  child: Container(
                child: Column(
                  children: [
                    Text((ldata?.measures).toString()),
                    Text((ldata?.annotations?.sourceName).toString()),
                    TextButton(
                        onPressed: () async {
                          final Uri url =
                              Uri.parse(ldata?.annotations?.datasetLink ?? "");
                          if (!await launchUrl(url,
                              mode: LaunchMode.externalApplication)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child:
                            Text((ldata?.annotations?.datasetLink).toString()))
                  ],
                ),
              ));
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
