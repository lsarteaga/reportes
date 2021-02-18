import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key}) : super(key: key);
  @override
  _StateStatisticPage createState() => _StateStatisticPage();
}

class _StateStatisticPage extends State<StatisticPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Statistics'),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
