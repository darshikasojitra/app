// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_splash_screen/services/auth_service.dart';

var documentID = '';
var refid = '';
var cart = FirebaseFirestore.instance.collection('cart');
final AuthService _auth = AuthService();
var wishlist = FirebaseFirestore.instance.collection('wishlist');

class Servives {
  static addcart(
      {required int quantity,
      required int prize,
      required String pid,
      required String pname}) {
    if ((quantity - 1) == 0) {
      cart.add({
        'pname': pname,
        'pid': pid,
        'prize': prize,
        'quantity': quantity,
        'uid': _auth.getUser()!.uid
      });
    } else {
      cart
          .where("pid", isEqualTo: pid)
          .where("uid", isEqualTo: _auth.getUser()!.uid)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((element) {
                  documentID = element.reference.id;
                }),
                cart.doc(documentID).update({
                  'quantity': quantity,
                  'prize': (quantity) * prize,
                }),
              });
    }
  }

  static removecart(int quantity, int prize, String pid) {
    if (++quantity != 0) {
      cart
          .where("pid", isEqualTo: pid)
          .where("uid", isEqualTo: _auth.getUser()!.uid)
          .get()
          .then((QuerySnapshot snapshot) => {
                snapshot.docs.forEach((element) {
                  documentID = element.reference.id;
                }),
                cart.doc(documentID).update({
                  'quantity': --quantity,
                  'prize': (quantity) * prize,
                }),
              });
    }
  }

  static updateprize({required int total}) {
    wishlist
        .doc(_auth.getUser()!.uid)
        .collection("userwishlist")
        .get()
        .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((element) {
                refid = element.reference.id;
              }),
              wishlist
                  .doc(_auth.getUser()!.uid)
                  .collection('userwishlist')
                  .doc(refid)
                  .update({
                'total_prize': total,
              })
            });
  }
}
