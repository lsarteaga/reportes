import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reportes/Models/User/user_auth.dart';
import 'package:reportes/Models/report_model.dart';
import 'dart:io';
import 'dart:convert';
import 'package:reportes/Providers/report_provider.dart';
import 'package:group_button/group_button.dart';
import 'package:reportes/Common/constant.dart';
import 'package:reportes/Models/location_model.dart';

class ReportFormPage extends StatefulWidget {
  final ReportModel item;
  ReportFormPage({Key key, this.item}) : super(key: key);
  @override
  _ReportFormPageState createState() => _ReportFormPageState(this.item);
}

class _ReportFormPageState extends State<ReportFormPage> {
  _ReportFormPageState(this.item);
  ReportModel item;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<dynamic> controllers = [];
  File _image;
  final picker = ImagePicker();
  String savedImage;
  bool _isButtonDisabled;
  bool waiting;
  // switch buttons
  int tagButton = 0;
  String tag;
  // location
  Coordinates defaultCoordinate;
  LocationsList _list;
  List<dynamic> data;

  //variable para capturar ubicacion
  Coordinates userCoordinates;
  bool captured = false;

  var position;
  // experimento de captura de ubicacion
  var locationMessage = '';
  Position cord;

  // ID del usuario actual que usa la aplicacion
  String iduser;
  UserAuth userAuth = UserAuth();

  void getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      print('Se capturo la ubicacion');
      print(position);
      captured = true;
    }
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = '$position.latitude, $position.longitude';
    });
  }

  Future<void> loadJsonData() async {
    var jsonText =
        await rootBundle.loadString('assets/data/default_locations.json');
    setState(() => data = json.decode(jsonText));
    print(data);
    _list = LocationsList.fromJsonList(data);
    print(jsonText);
  }

  @override
  void initState() {
    this.loadJsonData();
    this.getCurrentLocation();
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
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: (10.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Capturar ubicación',
                      style: TextStyle(fontSize: 15),
                    ),
                    FlatButton(
                      onPressed: () => (captured == false)
                          ? getCurrentLocation()
                          : showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return showLocationMessage();
                              }),
                      child: Text('Ubicación'),
                      color: Colors.indigo,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: (8.0)),
                child: Text(
                  'Seleccione una categoría',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              showTagButtons(),
              SizedBox(
                height: 14.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: (10.0)),
                child: Text(
                  'Agrege una imagen',
                  style: Theme.of(context).textTheme.headline6,
                ),
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

  Widget showLocationMessage() {
    return AlertDialog(
      title: Text(
        'INFORMACION',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
      content: Text(
        'Ubicación obtenida',
        textAlign: TextAlign.center,
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget showTagButtons() {
    return GroupButton(
      isRadio: true,
      spacing: 10,
      onSelected: (index, isSelected) => {
        print('$index button is selected'),
        // se asigna el tag seleccionado al reporte
        tagButton = index,
      },
      buttons: ["Comunitario", "Tránsito", "Denuncia"],
      selectedButtons: ["Comunitario"],
      selectedColor: Colors.indigo,
    );
  }

  Widget showMessage() {
    return AlertDialog(
      title: Text(
        'Alerta',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
      ),
      content: Text(
        'Ingrese los campos solicitados',
        textAlign: TextAlign.center,
      ),
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

  void parseTag(int value) {
    switch (value) {
      case 0:
        {
          tag = Constant.TAGS[0];
        }
        break;
      case 1:
        {
          tag = Constant.TAGS[1];
        }
        break;
      case 2:
        {
          tag = Constant.TAGS[2];
        }
        break;
    }
  }

  void submit() async {
    controllers.add(titleController.text);
    controllers.add(descriptionController.text);
    controllers.add(addressController.text);
    parseTag(tagButton);
    controllers.add(tag);

    print(coordinatesToJson(_list.items[0]));
    if (position == null) {
      defaultCoordinate = _list.items[0];
      controllers.add(defaultCoordinate);
    } else {
      Coordinates userCoordinates2 = new Coordinates(
          latitude: position.latitude.toString(),
          longitude: position.longitude.toString());
      controllers.add(userCoordinates2);
    }

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
        // cambios
        waiting = true;
        //cambios
        _waitingCloudinary(waiting);
        var data = await ReportProvider.uploadImage(_image);
        print(data);
        if (data != null) {
          waiting = false;

          controllers.add(data);
          _waitingCloudinary(waiting);
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
            //cammbios
            waiting = true;
            _waitingCloudinary(waiting);
            //cambios
            var data = await ReportProvider.uploadImage(_image);
            print(data);
            if (data != null) {
              //cambios
              waiting = false;

              //cambios
              controllers.add(data);
              controllers.add(widget.item.slug);
              _waitingCloudinary(waiting);
              print('editando report subiendo imagen');
            }
          }
        }
      }
    }
    if (userAuth.auth.currentUser.uid != null) {
      iduser = userAuth.auth.currentUser.uid.toString();
      controllers.add(iduser);
    } else {
      print('el id esta nulo :(');
    }

    Navigator.of(context).pop(controllers);
  }

  //cambios
  _waitingCloudinary(bool waiting) {
    if (waiting) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Creando reporte, esto tomará unos segundos',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.green,
                    fontSize: 15),
              ),
              content: Container(
                height: MediaQuery.of(context).size.width * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          });
    } else {
      Navigator.of(context).pop(controllers);
    }
  }
  //cambios

  Widget _getImageButtons() {
    return Container(
      color: Theme.of(context).appBarTheme.color,
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
                  icon: Icon(Icons.camera),
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
          _image,
          frameBuilder: (BuildContext context, Widget child, int frame,
              bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
            );
          },
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Image.network(
          (widget.item != null)
              ? widget.item.coverImage
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJiVSnIEbqaz60oD70dQKt2-msc_RwaXLCLw&usqp=CAU',
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
