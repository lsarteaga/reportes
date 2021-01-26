import 'package:flutter/material.dart';

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
            onTap: () {},
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Acerca'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
