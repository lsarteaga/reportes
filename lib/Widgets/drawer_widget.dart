import 'package:flutter/material.dart';
import 'package:reportes/Pages/User/user_settings_page.dart';
import 'package:reportes/Pages/Statistics/statistic_page.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("email@email.com"),
            accountName: Text("Cuenta de usuario"),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Quito.jpg/420px-Quito.jpg"),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Configuraciones'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return UserSettingsPage();
              }));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Estadísticas'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StatisticPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
