import 'package:flutter/material.dart';
import 'package:reportes/Models/report_model.dart';

class ReportView extends StatelessWidget {
  final ReportModel report;
  ReportView({Key key, this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parsedDate = DateTime.parse(report.time);
    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                  report.coverImage,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ListTile(
                title: Text(
                  'Datos del reporte',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              ListTile(
                leading: Icon(
                  Icons.title,
                  color: Colors.grey,
                ),
                title: Text('Título'),
                subtitle: Text(
                  report.title,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Colors.grey,
                ),
                title: Text('Descripción'),
                subtitle: Text(
                  report.description,
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.location_city,
                  color: Colors.grey,
                ),
                title: Text('Dirección'),
                subtitle: Text(
                  report.address,
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.date_range,
                  color: Colors.grey,
                ),
                title: Text('Fecha de creación'),
                subtitle: Text(
                  parsedDate.day.toString() +
                      '-' +
                      parsedDate.month.toString() +
                      '-' +
                      parsedDate.year.toString(),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
