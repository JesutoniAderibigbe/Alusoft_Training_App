import 'dart:ui';

import 'package:alusoft_app/adminpage/admin.dart';
import 'package:alusoft_app/adminpage/adminMIddleWare.dart';
import 'package:alusoft_app/backendfiles/signup.dart';
import 'package:alusoft_app/homepages/first.dart';
import 'package:alusoft_app/homepages/onboarding3.dart';
import 'package:alusoft_app/homepages/pagebuilder.dart';
import 'package:alusoft_app/users/Usermiddlewares.dart';
import 'package:alusoft_app/users/explorepage.dart';
import 'package:alusoft_app/users/userhomepage.dart';
import 'package:animated_background/animated_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  ParticleOptions particles = const ParticleOptions(
      baseColor: Colors.pink,
      spawnOpacity: 0.0,
      opacityChangeRate: 0.25,
      minOpacity: 0.1,
      maxOpacity: 0.4,
      particleCount: 70,
      spawnMaxRadius: 15.0,
      spawnMaxSpeed: 100.0,
      spawnMinSpeed: 30,
      spawnMinRadius: 7.0);

  TextEditingController nameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future signIn() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final form = _formKey.currentState;

    if (form!.validate()) {
      try {
        Loader.show(context,
            isAppbarOverlay: true,
            overlayFromTop: 100,
            progressIndicator: Center(
                child: SpinKitCircle(
              color: Colors.black,
              size: 70.0,
            )),
            themeData: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Colors.black38)),
            overlayColor: Colors.grey);

        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: nameControler.text.trim(),
            password: passwordControler.text.trim());

        // ignore: use_build_context_synchronously

        Future.delayed(Duration(seconds: 8), () {
          Loader.hide();
        });
      } on FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {}
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
        extendBodyBehindAppBar: true,
        extendBody: true,
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
                  MaterialPageRoute(builder: (((context) => PageBuilder()))));
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
        body: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(options: particles),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/bb.png'),
            )),
            padding: EdgeInsets.all(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Welcome Back!!!',
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                            ),
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Login to continue',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (String? value) {
                            if (value == null || value == "") {
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
                              labelText: 'Username',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length < 8 || value == "") {
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
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (((context) => Password()))));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Forgot password?'),
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMiddleWares()));
                            signIn();
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Text('New User?'),
                          TextButton(
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Here',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ));
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      SizedBox(height: 80),
                      Row(
                        children: [
                          Text(
                            'An Admin?',
                          ),
                          TextButton(
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Here',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.pinkAccent,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (((context) =>
                                          AdminMiddleWare()))));
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
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
