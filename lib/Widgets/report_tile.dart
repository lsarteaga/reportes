import 'package:flutter/material.dart';
import 'package:reportes/Models/report_model.dart';
import 'package:reportes/Widgets/report_view.dart';
import 'package:reportes/Pages/Report/report_form_page.dart';
import 'package:reportes/Providers/report_provider.dart';

class ReportTile extends StatelessWidget {
  ReportModel report;
  int index;

  ReportTile(this.report, this.index);

  @override
  Widget build(BuildContext context) {
    var parsedDate = DateTime.parse(report.time);

    //print(this.index);
    print(report.id);
    print(report.description);

    double width = MediaQuery.of(context).size.width * 0.2;
    double height = MediaQuery.of(context).size.height * 0.2;
    return Container(
      child: Card(
        elevation: 4.0,
        shadowColor: Theme.of(context).primaryColorDark,
        child: ListTile(
          key: Key('item-$index'),
          isThreeLine: true,
          onLongPress: () => goToEditItemView(report, context),
          onTap: () => _goToViewPage(report, context),
          leading: Image.network(
            report.coverImage,
            fit: BoxFit.cover,
            height: height,
            width: width,
          ),
          trailing: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(Icons.navigate_next),
                SizedBox(
                  height: 6,
                ),
                Text(parsedDate.day.toString() +
                    '-' +
                    parsedDate.month.toString() +
                    '-' +
                    parsedDate.year.toString()),
              ],
            ),
          ),
          title: Text(
            report.title,
            maxLines: 1,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            report.description,
            maxLines: 2,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  void _goToViewPage(ReportModel report, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ReportView(report: report);
    }));
  }

  void goToEditItemView(ReportModel report, BuildContext context) {
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
    }
  }
}
