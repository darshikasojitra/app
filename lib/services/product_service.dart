// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/model/model.dart';
import 'package:demo_splash_screen/model/wishlist_data.dart';
import 'package:demo_splash_screen/services/auth_service.dart';
import 'package:flutter/material.dart';

var _documentID = '';
var _cart = FirebaseFirestore.instance.collection('cart');
final AuthService _auth = AuthService();
var _wishlist = FirebaseFirestore.instance.collection('wishlist');
WishlistData? wishlistdata;
 
class Servives {
 static Future<String> getdata() async {
    http.Response response = await http.get(Uri.parse(
        'https://flutter-authentication-8b2ee-default-rtdb.firebaseio.com/product.json'));
    return response.body;
  }

 static Future<List<ProductData>> loaddata({required List<ProductData> list }) async {
    String data = await getdata();
    final jsonResponse = json.decode(data);
      for (Map<dynamic, dynamic> i in jsonResponse) {
        list.add(ProductData.fromJson(i));
      }
    return list;
  }

  static Future<void> addcart(
      {required int quantity,
      required int prize,
      required String pid,
      required String pname}) async {
    if ((quantity -1)  == 0) {
      _cart.add({
        'pname': pname,
        'pid': pid,
        'prize': prize,
        'quantity': quantity,
        'uid': _auth.getUser()!.uid
      });
    } else {
      _cart
          .where("pid", isEqualTo: pid)
          .where("uid", isEqualTo: _auth.getUser()!.uid)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((element) {
                  _documentID = element.reference.id;
                }),
                _cart.doc(_documentID).update({
                  'quantity': quantity,
                  'prize': (quantity) * prize,
                }),
              });
    }
  }

  static Future<void> removecart(int quantity, int prize, String pid) async {
    if (++quantity != 0) {
      _cart
          .where("pid", isEqualTo: pid)
          .where("uid", isEqualTo: _auth.getUser()!.uid)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((element) {
                  _documentID = element.reference.id;
                }),
                _cart.doc(_documentID).update({
                  'quantity': --quantity,
                  'prize': (quantity) * prize,
                }),
              });
    }
  }

  static Future<void> updateprize(
      {required int total, required String id, required int quantity}) async {
    _wishlist
        .doc(_auth.getUser()!.uid)
        .collection("userwishlist")
        .doc(id)
        .update({'total_prize': total, 'total_quantity': quantity});
  }

  static addData(TextEditingController textcontroller) async {
    await _wishlist
        .doc(_auth.getUser()!.uid)
        .collection("userwishlist")
        .doc()
        .set({
      'uid': _auth.getUser()!.uid,
      'uname': _auth.getUser()!.displayName,
      'name': textcontroller.text,
      'total_prize': 0,
      'total_quantity': 0,
    });
  }
}
