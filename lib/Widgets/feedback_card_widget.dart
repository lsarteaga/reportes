import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reportes/Models/feedback_model.dart';

class FeedBackCardWidget extends StatelessWidget {
  final FeedBackModel feedBackModel;
  FeedBackCardWidget({Key key, this.feedBackModel}) : super(key: key);
  final CollectionReference feedback =
      FirebaseFirestore.instance.collection('Feedback');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Theme.of(context).primaryColorDark,
      child: ListTile(
          leading: (feedBackModel.type == 'Sugerencia')
              ? Icon(Icons.check)
              : Icon(Icons.error),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
            ),
            onPressed: () => deleteRegister(),
          ),
          title: Text(feedBackModel.title),
          subtitle: Text(feedBackModel.body)),
    );
  }

  Future<void> deleteRegister() {
    return feedback
        .doc(feedBackModel.id)
        .delete()
        .then((value) => print('Registro eliminado'))
        .catchError((error) => print('Error al eliminar: $error'));
  }
}
