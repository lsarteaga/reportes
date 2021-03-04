import 'package:flutter/cupertino.dart';
import 'package:group_button/group_button.dart';
import 'package:flutter/material.dart';

class FeedBackForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: feedbackForm(),
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
      GroupButton(
        isRadio: true,
        spacing: 10,
        onSelected: (index, isSelected) => print('$index button is selected'),
        buttons: ["Sugerencia", "Error"],
        selectedColor: Colors.indigo,
        selectedButtons: ["Sugerencia"],
      ),
      padded(child: button()),
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
      animationDuration: Duration(milliseconds: 200),
      onPressed: onPressed,
      color: Colors.indigo,
      textColor: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      child: Text(text),
    );
  }

  void _validateForm() {}
}
