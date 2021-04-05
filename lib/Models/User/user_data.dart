import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  String email;
  String password;
  String name;
  String profileImage;

  UserData({this.id, this.email, this.password, this.name, this.profileImage});

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('users/').doc('$id');

  Future<void> saveInfo() async {
    await firestoreRef.set(toMap());
  }

  Future<void> saveInfo2() async {
    await firestoreRef.set(toMap2());
  }

  UserData.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name') as String;
    email = document.get('email') as String;
  }

  UserData.fromDocument2(DocumentSnapshot document) {
    id = document.id;
    name = document.get('name') as String;
    email = document.get('email') as String;
    profileImage = document.get('profileImage') as String;
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }

  // map para editar el avatar
  Map<String, dynamic> toMap2() {
    return {'name': name, 'email': email, 'profileImage': profileImage};
  }
}
