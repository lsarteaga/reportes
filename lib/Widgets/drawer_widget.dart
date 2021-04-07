import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportes/Models/User/user_auth.dart';
import 'package:reportes/Pages/Feedback/feedback_page.dart';
import 'package:reportes/Pages/Login/signin_screen.dart';
import 'package:reportes/Pages/User/user_settings_page.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  UserAuth userAuth;
  @override
  void initState() {
    super.initState();
    userAuth = new UserAuth();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<UserAuth>(
      builder: (_, userAuth, __) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Column(
                  children: [
                    Flexible(
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/default_user.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Text(
                      (userAuth.user == null)
                          ? userAuth.auth.currentUser.uid
                          : userAuth.user.name,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      (userAuth.user == null)
                          ? userAuth.auth.currentUser.email
                          : userAuth.user.email,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                )),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text("Perfil"),
              onTap: () {
                /*  Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSettingsPage())); */
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return UserSettingsPage();
                }));
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text("Contacto"),
              onTap: () {
                /* Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedBackPage())); */
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FeedBackPage();
                }));
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Salir"),
              onTap: () {
                userAuth.userState();
                if (userAuth.auth.currentUser.uid != null) {
                  userAuth.signOut();
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                }
                userAuth.userState();
              },
            ),
          ],
        );
      },
    ));
  }
}
