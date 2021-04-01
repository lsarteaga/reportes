import 'package:reportes/Models/User/user_auth.dart';
import 'package:reportes/Models/User/user_data.dart';
import 'package:reportes/Pages/Login/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reportes/Pages/home_page.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignIn'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Consumer<UserAuth>(builder: (_, userAuth, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff404b5a)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 25,
                                  offset: const Offset(0, 10)),
                            ]),
                            child: TextFormField(
                              controller: emailController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Type your email here',
                                hintStyle: TextStyle(fontSize: 12),
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
                                  return 'Type your email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 21,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff404b5a)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 25,
                                  offset: const Offset(0, 10)),
                            ]),
                            child: TextFormField(
                              controller: passwordController,
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Type your password here',
                                hintStyle: TextStyle(fontSize: 12),
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
                                if (password.isEmpty) {
                                  return 'Type your password';
                                } else if (password.length < 4) {
                                  return '4 characters at least';
                                }
                                return null;
                              },
                            ),
                          ),
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
                                  color: Color(0xff268A9A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      userAuth.signIn(
                                          userData: UserData(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text),
                                          onFail: (e) {
                                            print('error: $e');
                                          },
                                          onSuccess: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()));
                                          });
                                    }
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text('Go to sign in screen')),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
