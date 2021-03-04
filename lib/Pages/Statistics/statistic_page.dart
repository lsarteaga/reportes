import 'package:flutter/material.dart';
import 'package:reportes/Widgets/drawer_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:reportes/Models/charts/report_chart_model.dart';
import 'package:reportes/Providers/report_chart_service.dart';

class StatisticPage extends StatefulWidget {
  //StatisticPage({Key key}) : super(key: key);
  @override
  _StateStatisticPage createState() => _StateStatisticPage();
}

class _StateStatisticPage extends State<StatisticPage> {
  List<charts.Series<ReportChartModel, String>> _seriePieData;

  ReportChartModel tag1;
  ReportChartModel tag2;
  ReportChartModel tag3;
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
  }

  _generatedData() async {
    await _fetchChartData();
    var pieData = [
      tag1,
      tag2,
      tag3,
    ];
    /* var pieData = [
      new ReportChartModel(
          type: 'Sugerencia', reportValue: 20, colorVal: Color(0xff3366cc)),
      new ReportChartModel(
          type: 'Transito', reportValue: 20, colorVal: Color(0xff990099)),
      new ReportChartModel(
          type: 'Denuncia', reportValue: 60, colorVal: Color(0xff109618)),
    ]; */
    print(pieData);
    _seriePieData.add(
      charts.Series(
        data: pieData,
        domainFn: (ReportChartModel reportChartModel, _) =>
            reportChartModel.type,
        measureFn: (ReportChartModel reportChartModel, _) =>
            reportChartModel.reportValue,
        colorFn: (ReportChartModel reportChartModel, _) =>
            charts.ColorUtil.fromDartColor(reportChartModel.colorVal),
        id: 'report types',
        labelAccessorFn: (ReportChartModel row, _) => '${row.reportValue}',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriePieData = List<charts.Series<ReportChartModel, String>>();
    _generatedData();
  }

  @override
  Widget build(BuildContext context) {
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
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Cantidad de reportes segun su tipo',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: charts.PieChart(
                          _seriePieData,
                          animate: true,
                          animationDuration: Duration(seconds: 5),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                                  charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 1,
                              cellPadding:
                                  new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                /*  color:
                                    charts.MaterialPalette.purple.shadeDefault, */

                                fontSize: 18,
                              ),
                            )
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside,
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text('hola'),
            Text('hola'),
          ],
        ),
      ),
    );
  }
}
