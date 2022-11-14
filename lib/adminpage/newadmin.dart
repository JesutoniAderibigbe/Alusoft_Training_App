import 'dart:ui';

import 'package:alusoft_app/adminpage/adminMIddleWare.dart';
import 'package:alusoft_app/homepages/screen_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NewAdmin extends StatefulWidget {
  const NewAdmin({Key? key}) : super(key: key);

  @override
  State<NewAdmin> createState() => _NewAdminState();
}

class _NewAdminState extends State<NewAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: nameControler.text.trim(),
          password: passwordControler.text.trim());
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
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
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bb.png'),
                        fit: BoxFit.cover)),
                child: Container(
                  padding: EdgeInsets.only(top: 90, left: 20),
                  color: Color(0x99E8EAF6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.pink,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (((context) => LoginPage()))));
                        },
                      ),
                      SizedBox(height: 5),
                      RichText(
                          text: TextSpan(
                        text: "Welcome!",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )),
                      SizedBox(height: 5),
                      Text("Login as Admin ",
                          style: TextStyle(fontSize: 20, color: Colors.black))
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 220,
              child: Container(
                height: 380,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5)
                    ]),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                    borderSide:
                                        BorderSide(color: Colors.pink))),
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
                                    borderSide:
                                        BorderSide(color: Colors.pink))),
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
                      ],
                    )),
              )),
          Positioned(
              top: 535,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.orange, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          signIn();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => AdminMiddleWare())));
                        } else {
                          Loader.show(context,
                              isAppbarOverlay: true,
                              overlayFromTop: 100,
                              progressIndicator: Center(
                                  child: SpinKitFadingCircle(
                                color: Colors.red,
                                size: 70.0,
                              )),
                              themeData: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(secondary: Colors.black38)),
                              overlayColor: Color(0x99E8EAF6));

                          final snackBar = SnackBar(
                            duration: Duration(seconds: 14),
                            backgroundColor: Colors.red,
                            content: const Text('Wrong Username or Passsword!'),
                            action: SnackBarAction(
                              textColor: Colors.black,
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Future.delayed(Duration(seconds: 15), () {
                            Loader.hide();
                          });
                          // final snackBar = SnackBar(
                          //   duration: Duration(seconds: 1, milliseconds: 10),
                          //   backgroundColor: Colors.red,
                          //   content: Text('Wrong Username or Password!',
                          //       style: GoogleFonts.prompt()),
                          //   action: SnackBarAction(
                          //     textColor: Colors.black,
                          //     label: 'Undo',
                          //     onPressed: () {
                          //       // Some code to undo the change.
                          //     },
                          //   ),
                          // );
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
                ),
              ))
        ],
      ),
    );
  }
}
