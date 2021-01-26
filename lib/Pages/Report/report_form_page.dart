import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reportes/Models/report_model.dart';
import 'dart:io';
import 'package:reportes/Providers/report_provider.dart';

class ReportFormPage extends StatefulWidget {
  final ReportModel item;
  ReportFormPage({Key key, this.item}) : super(key: key);
  @override
  _ReportFormPageState createState() => _ReportFormPageState(this.item);
}

class _ReportFormPageState extends State<ReportFormPage> {
  ReportModel item;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<dynamic> controllers = [];
  File _image;
  final picker = ImagePicker();
  String savedImage;
  bool _isButtonDisabled;

  _ReportFormPageState(this.item);

  @override
  void initState() {
    super.initState();
    if (item != null) {
      titleController.text = this.item.title;
      descriptionController.text = this.item.description;
      addressController.text = this.item.description;
      savedImage = this.item.coverImage;
      _isButtonDisabled = false;
    } else {
      _isButtonDisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? 'Editar reporte' : 'Nuevo Reporte',
          key: Key('new-item-title'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  icon: Icon(Icons.title),
                  helperText: 'Ingrese un título para su reporte',
                ),
                autofocus: true,
                maxLength: 30,
                maxLines: 1,
                minLines: 1,
                autocorrect: true,
              ),
              SizedBox(
                height: 14.0,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  icon: Icon(Icons.description),
                  helperText: 'Describa de que se trata su reporte',
                ),
                maxLength: 200,
                maxLines: 5,
                minLines: 1,
                autocorrect: true,
              ),
              SizedBox(
                height: 14.0,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  icon: Icon(Icons.location_on),
                  helperText: 'Agregue una dirección de referencia',
                ),
                maxLength: 50,
                maxLines: 2,
                minLines: 1,
                autocorrect: true,
              ),
              SizedBox(
                height: 14.0,
              ),
              _showImage(),
              SizedBox(
                height: 14.0,
              ),
              _getImageButtons(),
              SizedBox(
                height: 14.0,
              ),
              RaisedButton(
                animationDuration: Duration(milliseconds: 200),
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Guardar',
                  style: TextStyle(
                      color:
                          Theme.of(context).primaryTextTheme.headline6.color),
                ),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                ),
                onPressed: () => (validateInputs() == true)
                    ? showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return showMessage();
                        })
                    : submit(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showMessage() {
    return AlertDialog(
      title: Text(
        'Alerta',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      content: Text('Ingresa los campos solicitados'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CERRAR'),
        ),
      ],
    );
  }

  bool validateInputs() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        addressController.text.isEmpty) {
      _isButtonDisabled = true;
    } else {
      _isButtonDisabled = false;
    }

    return _isButtonDisabled;
  }

  void submit() async {
    controllers.add(titleController.text);
    controllers.add(descriptionController.text);
    controllers.add(addressController.text);
    // casos
    // widget es nulo (creando reporte) con imagen nula
    // widget es nulo (crando repor) con imagen cargada
    // widget no es nulo (editando report) con imagen nula
    // widget no es nuelo (ediatndo report) con imagen cargada

    if (widget.item == null && _image == null) {
      // que siga su rumbo normal
      print('creando report sin imagen');
    } else {
      if (widget.item == null && _image != null) {
        var data = await ReportProvider.uploadImage(_image);
        print(data);
        if (data != null) {
          controllers.add(data);
          print('creando report con imagen');
        }
      } else {
        if (widget.item != null && _image == null) {
          // coja datos de controladores y su imagen por defecto
          controllers.add(widget.item.coverImage);
          controllers.add(widget.item.slug);
          print('editando report sin subir imagen');
        } else {
          if (widget.item != null && _image != null) {
            var data = await ReportProvider.uploadImage(_image);
            print(data);
            if (data != null) {
              controllers.add(data);
              controllers.add(widget.item.slug);
              print('editando report subiendo imagen');
            }
          }
        }
      }
    }
    Navigator.of(context).pop(controllers);
  }

  Widget _getImageButtons() {
    return Container(
      color: Theme.of(context).buttonColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: _pickupImage,
            child: Row(
              children: <Widget>[
                Text('Galería'),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _pickupImage,
                  tooltip: 'Buscar en la galería',
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _takeImage,
            child: Row(
              children: <Widget>[
                Text('Foto'),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _takeImage,
                  tooltip: 'Tomar una foto',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showImage() {
    double width = MediaQuery.of(context).size.width * 0.2;
    double height = MediaQuery.of(context).size.height * 0.2;
    if (_image != null) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Image.file(
            //_image,
            _image.absolute,
            fit: BoxFit.cover,
            height: height,
            width: width,
          ));
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Image.network(
          (widget.item != null)
              ? widget.item.coverImage
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJiVSnIEbqaz60oD70dQKt2-msc_RwaXLCLw&usqp=CAU',
          //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAzugvlLSMeH7WJBYl9FpvaTTeDUo-AqpUiw&usqp=CAU',
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      );
    }
  }

  _pickupImage() {
    _selectImage(ImageSource.gallery);
  }

  _takeImage() {
    _selectImage(ImageSource.camera);
  }

  Future _selectImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
