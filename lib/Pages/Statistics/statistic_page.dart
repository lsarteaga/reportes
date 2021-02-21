import 'package:flutter/material.dart';
import 'package:reportes/Widgets/drawer_widget.dart';

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.bar_chart),
              ),
              Tab(
                icon: Icon(Icons.pie_chart),
              ),
              Tab(
                icon: Icon(Icons.stacked_line_chart_rounded),
              )
            ],
          ),
          title: Text('Estadísticas'),
          centerTitle: true,
        ),
        drawer: DrawerWidget(),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
