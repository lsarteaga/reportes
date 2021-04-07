import 'package:reportes/Models/User/user_auth.dart';
import 'package:reportes/Models/User/user_data.dart';
import 'package:reportes/Pages/Login/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaKey = GlobalKey<ScaffoldState>();
  final UserData user = UserData();
  UserAuth userAuth = new UserAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaKey,
      appBar: AppBar(
        title: Text('Nueva Cuenta'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Consumer<UserAuth>(
            builder: (_, userAuth, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: FractionalOffset.center,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Nombre de usuario',
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff404b5a)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: (Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: 'Ingrese su usuario aqui',
                                  hintStyle: TextStyle(fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.all(16),
                                  fillColor: Colors.white,
                                ),
                                validator: (name) {
                                  if (name.isEmpty) {
                                    return 'Ingrese su usuario';
                                  }
                                  return null;
                                },
                                onSaved: (name) => user.name = name,
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Correo electrónico',
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff404b5a)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: (Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: 'Ingrese su correo aqui',
                                  hintStyle: TextStyle(fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.all(16),
                                  fillColor: Colors.white,
                                ),
                                validator: (email) {
                                  if (email.isEmpty) {
                                    return 'Ingrese su correo';
                                  }
                                  return null;
                                },
                                onSaved: (email) => user.email = email,
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Contraseña',
                                style: TextStyle(
                                    fontSize: 21, color: Color(0xff404b5a)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: (Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 25,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Ingrese su contraseña aqui',
                                  hintStyle: TextStyle(fontSize: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.all(16),
                                  fillColor: Colors.white,
                                ),
                                validator: (password) {
                                  if (password.isEmpty || password.length < 6) {
                                    return 'Ingrese una contraseña';
                                  }
                                  return null;
                                },
                                onSaved: (password) => user.password = password,
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Align(
                              alignment: Alignment.center,
                              child: ButtonTheme(
                                minWidth: 150,
                                height: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                      }
                                      userAuth.signUp(
                                          userData: user,
                                          onSuccess: () {
                                            userAuth.signOut();
                                            formKey.currentState.reset();
                                            scaKey.currentState
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              content: Text(
                                                'Registro exitóso',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              duration: Duration(seconds: 10),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                                },
                                              ),
                                            ));
                                          },
                                          onFail: (e) {
                                            print('An error occurred: $e');
                                          });
                                    },
                                    child: Text(
                                      'Registrarse',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
