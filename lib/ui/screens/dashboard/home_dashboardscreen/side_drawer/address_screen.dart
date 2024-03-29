import 'dart:async';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:demo_splash_screen/ui/screens/dashboard/list_dashboardscreen/product_screen/product_widget/product_widget.dart';
import 'package:demo_splash_screen/ui/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});
  static const String id = 'AddressScreen';
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late GoogleMapController myController;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = LatLng(23.0225, 72.5714);
  final Set<Marker> _markers = {};
  LatLng _currentMapPosition = _center;
  void _addMarker() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_currentMapPosition.toString()),
        position: _currentMapPosition,
        infoWindow: const InfoWindow(title: 'Nice Place', snippet: 'Welcome!'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    //myController = controller;
    _controller.complete(controller);
  }

  Future<Position> getUsercurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _userlocation() async {
    getUsercurrentLocation().then((value) async {
      _markers.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'current location')));
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, () {
        Navigator.pushNamed(context, DashboardScreen.id);
      }, 'Address', AllColors.maincolor),
      body: Stack(
        children: [
          GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 10.0,
              ),
              myLocationEnabled: true,
              markers: _markers,
              onCameraMove: _onCameraMove),
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 10.w),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () {
                  _addMarker();
                  _userlocation();
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.green,
                child: const Icon(Icons.map, size: 30.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
