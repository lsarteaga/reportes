import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reportes/Models/User/user_auth.dart';
import 'package:reportes/Models/feedback_model.dart';
import 'package:reportes/Widgets/feedback_card_widget.dart';

class FeedBackSdkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserAuth userAuth = UserAuth();
    CollectionReference feedback =
        FirebaseFirestore.instance.collection('Feedback');

    return StreamBuilder<QuerySnapshot>(
        stream: feedback
            .where('userId', isEqualTo: userAuth.auth.currentUser.uid)
            .snapshots(),
        //stream: feedback.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Error al mostrar registros',
              style: Theme.of(context).textTheme.headline6,
            ));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (userAuth.auth.currentUser.uid != null) {
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                FeedBackModel model = FeedBackModel.fromJson(document.data());
                model.id = document.id;
                print(model.id);
                return FeedBackCardWidget(
                  feedBackModel: model,
                );
              }).toList(),
            );
          } else {
            return Text('data');
          }
        });
  }
}
