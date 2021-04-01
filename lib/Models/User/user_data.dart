import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String email;
  String password;
  String name;

  UserData({this.id, this.email, this.password, this.name});

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('users/').doc('$id');

  Future<void> saveInfo() async {
    await firestoreRef.set(toMap());
  }

  UserData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name') as String;
    email = document.get('email') as String;
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }
}
