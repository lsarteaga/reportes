import 'package:flutter/material.dart';
import 'package:reportes/Models/feedback_model.dart';

class FeedBackCardWidget extends StatelessWidget {
  final FeedBackModel feedBackModel;
  FeedBackCardWidget({Key key, this.feedBackModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Theme.of(context).primaryColorDark,
      child: ListTile(
          trailing: Icon(Icons.arrow_right),
          leading: Icon(Icons.airport_shuttle),
          title: Text(feedBackModel.title),
          subtitle: Text(feedBackModel.body)),
    );
  }
}
