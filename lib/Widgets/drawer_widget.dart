import 'package:flutter/material.dart';
import 'package:reportes/Models/User/user_auth.dart';
import 'package:reportes/Pages/Feedback/feedback_page.dart';
import 'package:reportes/Pages/Login/signin_screen.dart';
import 'package:reportes/Pages/User/user_settings_page.dart';

class DrawerWidget extends StatelessWidget {
  UserAuth userAuth = new UserAuth();
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
            title: Text('Contacto'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FeedBackPage();
              }));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Salir'),
            onTap: () {
              userAuth.userState();
              if (userAuth.auth.currentUser.uid != null) {
                userAuth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              }
              userAuth.userState();
            },
          ),
        ],
      ),
    );
  }
}
