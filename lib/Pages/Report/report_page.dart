import 'package:flutter/material.dart';
import 'package:reportes/Models/report_model.dart';
import 'package:reportes/Pages/Report/report_form_page.dart';
import 'package:reportes/Widgets/report_view.dart';
import 'package:reportes/Providers/report_provider.dart';
import 'package:reportes/Widgets/drawer_widget.dart';
import 'dart:core';
import 'package:animate_do/animate_do.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key key}) : super(key: key);
  @override
  _StateReportPage createState() => _StateReportPage();
}

class _StateReportPage extends State<ReportPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<ReportModel> items = [];
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  AnimationController emptyListController;
  int counter = 0;
  String defaul =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqkt2_8w_YlDxmV1oxsjbBdb0Ywa_L5BPimg&usqp=CAU';

  @override
  void initState() {
    //_fetchData();
    emptyListController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    emptyListController.forward();
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    emptyListController.dispose();
    super.dispose();
  }

  _fetchData() async {
    var data = await ReportProvider.getJsonReports();
    setState(() {
      List<dynamic> results = data['docs'];
      results.forEach((element) {
        items.add(ReportModel.fromJson(element));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          'Reportes',
          key: Key('main-app-title'),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => goToNewItemView(),
      ),
      body: renderBody(),
    );
  }

  Widget renderBody() {
    if (items.length > 0) {
      return buildListView();
    } else {
      return emptyList();
    }
  }

  Widget emptyList() {
    return Center(
      child: FadeTransition(
        opacity: emptyListController,
        child: Text('Sin reportes'),
      ),
    );
  }

  Widget buildListView() {
    return AnimatedList(
      key: animatedListKey,
      initialItemCount: items.length,
      itemBuilder: (BuildContext context, int index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: buildItem(items[index], index),
        );
      },
    );
  }

  Widget buildItem(ReportModel item, int index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(
        color: Colors.red[700],
      ),
      onDismissed: (direction) => removeItemFromList(item, index),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  void removeItemFromList(ReportModel item, int index) async {
    var data = await ReportProvider.deleteReport(item.slug);
    if (data != null) {
      animatedListKey.currentState.removeItem(index, (context, animation) {
        return SizedBox(
          width: 0,
          height: 0,
        );
      });
      deleteItem(item);
    }
  }

  void deleteItem(ReportModel item) {
    items.remove(item);
    if (items.isEmpty) {
      if (emptyListController != null) {
        emptyListController.reset();
        setState(() {});
        emptyListController.forward();
      }
    }
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Reporte eliminado'),
      duration: Duration(milliseconds: 500),
    ));
  }

  void goToNewItemView() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ReportFormPage();
    })).then((value) {
      if (value != null) {
        value.forEach((element) {
          print(counter);
          counter++;
        });
        // modificaciones
        if (counter == 4) {
          counter = 0;
          addItem(ReportModel(
              title: value[0],
              description: value[1],
              address: value[2],
              coverImage: value[3]));
        } else {
          counter = 0;
          addItem(ReportModel(
              title: value[0],
              description: value[1],
              address: value[2],
              coverImage: defaul));
        }
      }
    });
  }

  void addItem(ReportModel item) async {
    var data = await ReportProvider.createReport(item);
    print(data);
    if (data != null) {
      // ordena tipo fila
      items.insert(0, ReportModel.fromJson(data));
      // ordena tipo cola
      //this.items.insert(this.items.length, ReportModel.fromJson(data));
      print('current item added');
      print(items[0]);
      if (animatedListKey.currentState != null) {
        animatedListKey.currentState.insertItem(0);
        //this.animatedListKey.currentState.insertItem(this.items.length - 1);
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Reporte agregado'),
        duration: Duration(milliseconds: 500),
      ));
      setState(() {});
    }
  }

  // new added methods
  Widget buildListTile(item, index) {
    var parsedDate = DateTime.parse(item.time);
    double width = MediaQuery.of(context).size.width * 0.2;
    double height = MediaQuery.of(context).size.height * 0.2;
    return BounceInRight(
      delay: Duration(milliseconds: 200 * index),
      child: Container(
        child: Card(
          elevation: 4,
          shadowColor: Theme.of(context).primaryColorDark,
          child: ListTile(
            key: Key('item-$index'),
            isThreeLine: true,
            onLongPress: () => goToEditItemView(item),
            onTap: () => _goToViewPage(item),
            leading: Image.network(
              item.coverImage,
              fit: BoxFit.cover,
              height: height,
              width: width,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
            trailing: Container(
              key: Key('completed-icon-$index'),
              child: Column(
                children: [
                  Icon(Icons.navigate_next),
                  Text(parsedDate.day.toString() +
                      '-' +
                      parsedDate.month.toString() +
                      '-' +
                      parsedDate.year.toString()),
                ],
              ),
            ),
            title: Text(
              item.title,
              maxLines: 1,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }

  void _goToViewPage(ReportModel report) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ReportView(report: report);
    }));
  }

  void goToEditItemView(ReportModel report) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ReportFormPage(item: report);
    })).then((value) {
      print(value);
      if (value != null) {
        report.title = value[0];
        report.description = value[1];
        report.address = value[2];
        report.coverImage = value[3];
        print('nuevos valores: ');
        print(value);
        editItem(report, value[4], context);
      }
    });
  }

  void editItem(ReportModel report, String id, BuildContext context) async {
    var data = await ReportProvider.editReport(report, id);
    print('datos desde backend:');
    print(data);
    if (data != null) {
      print('modificado');
      report = data;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Reporte editado'),
        duration: Duration(milliseconds: 500),
      ));
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
