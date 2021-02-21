import 'package:flutter/material.dart';

class FeedBackPage extends StatefulWidget {
  FeedBackPage({Key key}) : super(key: key);
  @override
  _StateFeedBackPage createState() => _StateFeedBackPage();
}

class _StateFeedBackPage extends State<FeedBackPage> {
  final formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacto'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: feedbackForm(),
          ),
        ),
      ),
    );
  }

  List<Widget> feedbackForm() {
    return [
      padded(
        child: TextFormField(
          controller: _title,
          decoration: InputDecoration(
            icon: Icon(Icons.title),
            labelText: 'Título',
          ),
        ),
      ),
      padded(
        child: TextField(
          controller: _body,
          decoration: InputDecoration(
            icon: Icon(Icons.chat),
            labelText: 'Descripción',
          ),
        ),
      ),
      padded(
        child: ListTile(
          leading: Icon(Icons.category),
          title: Text('Seleccione un tipo'),
        ),
      ),
      padded(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Sugerencia',
                style: TextStyle(fontSize: 15),
              ),
              Switch(
                value: false,
                onChanged: (value) {
                  setState(() {});
                },
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
      padded(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Error',
                style: TextStyle(fontSize: 15),
              ),
              Switch(
                value: false,
                onChanged: (value) {
                  setState(() {});
                },
                activeColor: Theme.of(context).primaryColor,
                activeTrackColor: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
      Container(
        child: button(),
      ),
    ];
  }

  Widget padded({Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

  Widget button() {
    return styleButton('Enviar', _validateForm);
  }

  Widget styleButton(String text, VoidCallback onPressed) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.indigo,
      textColor: Colors.white,
      child: Text(text),
    );
  }

  _validateForm() {}
}
