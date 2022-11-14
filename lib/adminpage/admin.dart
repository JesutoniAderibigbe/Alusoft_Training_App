import 'dart:ui';

import 'package:alusoft_app/adminpage/adminMIddleWare.dart';
import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:alusoft_app/drawer/hidden_drawer.dart';
import 'package:alusoft_app/firebase/auth_controller.dart';
import 'package:alusoft_app/homepages/screen_1.dart';
import 'package:alusoft_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ThemeData specialThemeData = ThemeData(
    brightness: Brightness.dark,

    // and so on...
  );

  TextEditingController nameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  Future signIn() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final form = _formKey.currentState;

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(child: CircularProgressIndicator());
    //     })
    if (form!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: nameControler.text.trim(),
            password: passwordControler.text.trim());
      } on FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameControler.dispose();
    passwordControler.dispose();
  }

  var _passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: specialThemeData,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            toolbarHeight: 120,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.pink,
                size: 20,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (((context) => LoginPage()))));
              },
            ),
            // title: Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text("Already have an account?"),
            //     Text(
            //       "Sign in",
            //       style: TextStyle(color: Colors.pink.shade200),
            //     ),
            //   ],
            // ),
          ),
          body: Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/bb.png'),
              )),
              padding: EdgeInsets.all(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 15.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(

                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/images/admin.png'),
                      //     ),
                      //   ),
                      // ),
                      Image.asset('assets/images/forum.png',
                          color: Colors.black, height: 100, width: 80),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   padding: EdgeInsets.all(10),
                      //   child: Text(
                      //     'Login to continue',
                      //     style: TextStyle(
                      //         fontSize: 15, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (String? value) {
                            if (value != "aderibigbejesutoni860@gmail.com") {
                              return "Enter Username";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(color: Colors.black),
                          controller: nameControler,
                          decoration: InputDecoration(
                              floatingLabelStyle:
                                  MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.error)
                                        ? Theme.of(context).errorColor
                                        : Colors.black;
                                return TextStyle(color: color);
                              }),
                              border: OutlineInputBorder(),
                              labelText: 'E-mail Address',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value != "password") {
                              return "Enter Password";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          obscureText: !_passwordVisible,
                          controller: passwordControler,
                          decoration: InputDecoration(
                              floatingLabelStyle:
                                  MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.error)
                                        ? Theme.of(context).errorColor
                                        : Colors.black;
                                return TextStyle(color: color);
                              }),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.pink),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink))),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(primary: Colors.black),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Reset Password'),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.pink),
                          child: Text('Login'),
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              signIn();
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => LoginPage())));
                            } else {
                              final snackBar = SnackBar(
                                duration:
                                    Duration(seconds: 1, milliseconds: 10),
                                backgroundColor: Colors.red,
                                content: Text('Wrong Username or Password!',
                                    style: GoogleFonts.prompt()),
                                action: SnackBarAction(
                                  textColor: Colors.black,
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                            }
                            // var data = {
                            //   'username': nameControler.text,
                            //   'password': passwordControler.text,
                            // };
                            // var response = await getHttp('/login', data);

                            // AuthController.instance.login(
                            //     nameControler.text.trim(),
                            //     passwordControler.text.trim());

                            //AuthController.instance.login(email, password)

                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //         builder: (((context) => HiddenDrawer()))));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
