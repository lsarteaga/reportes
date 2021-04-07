import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:reportes/Pages/Statistics/statistic_page.dart';
import 'package:reportes/Pages/Location/location_page.dart';
import 'package:reportes/Pages/Report/report_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    ReportPage(),
    LocationPage(),
    StatisticPage(),
  ];
  int _selectedIndex = 0;

  // notificaciones de firebase
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String title = 'title';
  String helper = 'helper';

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    _configFCM();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Ubicación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Estadísticas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
      ),
    );
  }

  _configFCM() {
    _firebaseMessaging.configure(
      onMessage: (Map<dynamic, dynamic> message) async {
        _goNotification(message);
      },
      onResume: (Map<dynamic, dynamic> message) async {
        _goNotification(message);
      },
      onLaunch: (Map<dynamic, dynamic> message) async {
        _goNotification(message);
      },
    );
  }

  // metodos de FCM

  _getContent(Map<dynamic, dynamic> message) {
    FCMNotification content = new FCMNotification();

    Map<dynamic, dynamic> notification = message['notification'];
    Map<dynamic, dynamic> data = message['data'];
    content.title = notification['title'];
    content.body = notification['body'];
    content.url = data['url'];

    return content;
  }

  _goNotification(Map<dynamic, dynamic> message) {
    FCMNotification content = _getContent(message);
    if (content != null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    child: Text(content.title)),
                content: Container(
                  margin: EdgeInsets.all(7.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0),
                          child: Text(content.body)),
                      content.url == null
                          ? Container()
                          : Image.network(content.url)
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    padding: EdgeInsets.zero,
                    child: Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]);
          });
    }
  }
}

class FCMNotification {
  String title;
  String body;
  String url;

  FCMNotification({this.title, this.body, this.url});
}
