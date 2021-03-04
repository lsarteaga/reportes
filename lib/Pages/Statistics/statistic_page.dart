import 'package:flutter/material.dart';
import 'package:reportes/Widgets/drawer_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:reportes/Models/charts/report_chart_model.dart';
import 'package:reportes/Providers/report_chart_service.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key}) : super(key: key);
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  //List<charts.Series<PieData, String>> _pieData;
  List<charts.Series<ReportChartModel, String>> _pieData;
  ReportChartModel tag1;
  ReportChartModel tag2;
  ReportChartModel tag3;
  bool activation = false;

  @override
  void initState() {
    super.initState();
    _pieData = List<charts.Series<ReportChartModel, String>>();
  }

  _fetchChartData() async {
    var aux1 = await ReportChartService.getJsonReport('first');
    tag1 = ReportChartModel.fromJson(aux1);
    tag1.colorVal = Color(0xff3366cc);
    aux1 = await ReportChartService.getJsonReport('second');
    tag2 = ReportChartModel.fromJson(aux1);
    tag2.colorVal = Color(0xff990099);
    aux1 = await ReportChartService.getJsonReport('third');
    tag3 = ReportChartModel.fromJson(aux1);
    tag3.colorVal = Color(0xff109618);
    print(tag1.reportValue);
    print(tag2.reportValue);
    print(tag3.reportValue);
    activation = true;
    setState(() {});
  }

  generateData() {
    var piedata = [
      new ReportChartModel(
          type: tag1.type,
          reportValue: tag1.reportValue,
          colorVal: tag1.colorVal),
      new ReportChartModel(
          type: tag2.type,
          reportValue: tag2.reportValue,
          colorVal: tag2.colorVal),
      new ReportChartModel(
          type: tag3.type,
          reportValue: tag3.reportValue,
          colorVal: tag3.colorVal),
    ];

    _pieData.add(
      charts.Series(
        domainFn: (ReportChartModel data, _) => data.type,
        measureFn: (ReportChartModel data, _) => data.reportValue,
        id: 'Time spent',
        data: piedata,
        colorFn: (ReportChartModel reportChartModel, _) =>
            charts.ColorUtil.fromDartColor(reportChartModel.colorVal),
        labelAccessorFn: (ReportChartModel row, _) => '${row.reportValue}',
      ),
    );
    return _pieData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Estadísticas'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.show_chart),
              onPressed: () {
                if (activation == false) {
                  _fetchChartData();
                }
              },
            )
          ],
        ),
        drawer: DrawerWidget(),
        body: (activation == true)
            ? Center(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Cantidad de reportes segun su tipo',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: charts.PieChart(
                        generateData(),
                        behaviors: [
                          new charts.DatumLegend(
                            outsideJustification:
                                charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 3,
                            cellPadding:
                                new EdgeInsets.only(right: 4.0, bottom: 4.0),
                            entryTextStyle: charts.TextStyleSpec(
                              fontSize: 18,
                            ),
                          )
                        ],
                        animate: true,
                        animationDuration: Duration(seconds: 5),
                        defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 100,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: Text('Carga los datos'),
              ));
  }
}
