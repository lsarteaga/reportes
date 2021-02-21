import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportes/Common/preferences.dart';
import 'package:reportes/Providers/content_provider.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final prefs = new Preferences();
    final _contentProvider = Provider.of<ContentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  'Foto de perfil',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  child: Image(
                    image: AssetImage('assets/images/default_user.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              animationDuration: Duration(milliseconds: 200),
              color: Theme.of(context).primaryColor,
              child: Text(
                'Cambiar Foto',
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.headline6.color),
              ),
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
            ),
            ListTile(
              title: Text('Nombre de usuario'),
              subtitle: Text('Usuario por defecto'),
              leading: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text('Correo electrónico'),
              subtitle: Text('correo@correo.com'),
              leading: Icon(
                Icons.email,
                color: Colors.grey,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Tema Oscuro',
                    style: TextStyle(fontSize: 15),
                  ),
                  Switch(
                    value: prefs.mode,
                    onChanged: (value) {
                      prefs.mode = value;
                      _contentProvider.darkMode = prefs.mode;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
