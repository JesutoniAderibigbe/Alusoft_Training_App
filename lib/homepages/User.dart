import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:alusoft_app/backendfiles/otp.dart';
import 'package:alusoft_app/homepages/first.dart';
import 'package:alusoft_app/homepages/onboarding3.dart';
import 'package:alusoft_app/homepages/screen_1.dart';
import 'package:alusoft_app/main.dart';
import 'package:alusoft_app/users/Usermiddlewares.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:open_mail_app/open_mail_app.dart';

class UserTable extends StatefulWidget {
  const UserTable({Key? key}) : super(key: key);

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  TextEditingController username = TextEditingController();
  //TextEditingController emailController = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController name = TextEditingController();

  var _passwordVisible = false;
  bool isEmailVerified = false;
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.body,
            notification.title,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    //channel.description,
                    color: Colors.pink,
                    playSound: true,
                    icon: '@mipmap/ic_launcher'
                    //   icon: ''
                    )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification == null && android == null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification!.title.toString()),
                content: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(notification.body.toString())],
                )),
              );
            });
      }
    });
  }

  showNotification() async {
    setState(() {
      _counter++;
    });

    flutterLocalNotificationsPlugin.show(
        0,
        "Alusoft App",
        "E-mail sent! Check your mail.",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.pink,
                playSound: true,
                icon: '@mipmap/launcher_icon')));
    if (NotificationDetails != null) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(""),
              content: RaisedButton(
                  child: Text("Open Mail App"),
                  onPressed: () async {
                    var result = await OpenMailApp.openMailApp();

                    if (!result.didOpen && !result.canOpen) {
                      showNoMailAppsDialog(context);
                    } else if (!result.didOpen && result.canOpen) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return MailAppPickerDialog(
                                mailApps: result.options);
                          });
                    }
                  }),
            );
          });
    }
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    print("Hey");
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future signUp() async {
    if (passwordConfirmed()) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(DateTime.now().toString() + '.jpg');

      await ref.putFile(_image!);
      imageUrl = await ref.getDownloadURL();

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: username.text.trim(), password: password.text.trim())
          .then((result) {
        return result.user!.updateDisplayName(name.text);
      });

      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
        'uid': user.uid,
        'email': username.text,
        'password': password.text,
        //'role': user,
        'displayName': user.displayName,
        'userImage': imageUrl,
      });
      setState(() {});

      verifyEmail();

      final snackBar = SnackBar(
        content: const Text('Successfully created  a login account'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Some code to undo the change.
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => LoginPage())));
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    password.dispose();
    password2.dispose();
  }

  bool passwordConfirmed() {
    if (password.text.trim() == password2.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  File? _image;
  String? imageUrl;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Please choose an option"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        _getFromCamera();
                        // get from Camera
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.camera, color: Colors.red)),
                          Text("Camera", style: TextStyle(color: Colors.pink))
                        ],
                      )),
                  SizedBox(height: 20),
                  InkWell(
                      onTap: () {
                        _getFromGallery();
                        //get from Gallery
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.image, color: Colors.red)),
                          Text("Gallery", style: TextStyle(color: Colors.pink))
                        ],
                      ))
                ],
              ));
        });
  }

  Future verifyEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      if (!(user.emailVerified)) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print("Error sending mail");
    }
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        _image = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: showNotification,
          child: Icon(Icons.add),
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          title: Text(
            "Set your details",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pink,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (((context) => SignUpPage()))));
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
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bb.png'),
          )
              // color: Colors.transparent,
              // image: DecorationImage(
              //     colorFilter: ColorFilter.mode(
              //         Colors.white.withOpacity(0.4), BlendMode.dstATop),
              //     image: AssetImage(
              //       'assets/images/bg6.png',
              //     ),
              //     opacity: 0.6,
              //     fit: BoxFit.cover),
              ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                              child: (_image == null)
                                  ? Image.asset('assets/images/bb.png',
                                      height: 120, fit: BoxFit.fill)
                                  : Image.file(
                                      _image!,
                                      fit: BoxFit.fill,
                                      height: 120,
                                    )),
                          Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: IconButton(
                                icon: Icon(FontAwesomeIcons.camera, size: 30.0),
                                onPressed: () {
                                  _showImageDialog();
                                  //  getImage();
                                },
                              )),
                        ],
                      ),

                      // Container(
                      //   width: 350,
                      //   decoration: BoxDecoration(
                      //     // image: DecorationImage(
                      //     //     image: AssetImage('assets/images/bg.png'),
                      //     //     colorFilter: ColorFilter.mode(
                      //     //         Colors.white.withOpacity(0.9), BlendMode.dstATop),
                      //     //     fit: BoxFit.cover),
                      //     borderRadius: BorderRadius.circular(22),
                      //     color: Colors.teal,
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       'Plan DB',
                      //       style: TextStyle(color: Colors.white, fontSize: 33),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 70,
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Form(
                            child: TextFormField(
                          maxLength: 40,
                          controller: username,
                          decoration: InputDecoration(
                              hintText: 'Type your verified e-mail',
                              labelText: 'Username',
                              icon: Icon(Icons.library_books),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.pink))),
                        )),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            child: TextFormField(
                          maxLength: 40,
                          controller: name,
                          decoration: InputDecoration(
                              hintText: 'Type your username',
                              labelText: 'Username',
                              icon: Icon(Icons.library_books),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.pink))),
                        )),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            child: TextFormField(
                          maxLength: 60,
                          controller: password,
                          validator: (value) {
                            if (value!.length < 8 || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              hintText: 'Minimum of 8 characters',
                              icon: Icon(Icons.description),
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
                              labelText: 'Password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.teal)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.purple))),
                        )),
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            child: TextFormField(
                          maxLength: 60,
                          controller: password2,
                          validator: (value) {
                            if (value!.length > 8 || value.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              icon: Icon(Icons.description),
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
                              labelText: 'Password',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.teal)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.purple))),
                        )),
                      ),

                      SizedBox(
                        height: 60,
                      ),
                      // // textbutton,
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              final form = _formKey.currentState;
                              if (form!.validate() && _image != null) {
                                Loader.show(context,
                                    isAppbarOverlay: true,
                                    overlayFromTop: 100,
                                    progressIndicator: Center(
                                        child: SpinKitRotatingCircle(
                                      color: Colors.green,
                                      size: 70.0,
                                    )),
                                    themeData: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(
                                                secondary: Colors.black38)),
                                    overlayColor: Colors.grey);

                                signUp();

                                showNotification();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => LoginPage())));

                                Future.delayed(Duration(seconds: 8), () {
                                  final snackBar = SnackBar(
                                    duration:
                                        Duration(seconds: 1, milliseconds: 10),
                                    backgroundColor: Colors.green,
                                    content: const Text('Account Created'),
                                    action: SnackBarAction(
                                      textColor: Colors.black,
                                      label: 'OK',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  Loader.hide();
                                });
                              } else {
                                final snackBar = SnackBar(
                                  duration:
                                      Duration(seconds: 1, milliseconds: 10),
                                  backgroundColor: Colors.red,
                                  content: const Text('Upload a picture'),
                                  action: SnackBarAction(
                                    textColor: Colors.black,
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }

                              var data = {
                                'username': username.text,
                                'password': password.text,
                              };
                              var response = await getHttp('/save-user', data);
                              print("response = ");
                              print(response);
                              // ignore:
                              // avoid_print;
                              //insertMethod();
                            },
                            child: Container(
                                width: 350,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.pinkAccent),
                                // color: Colors.purple,

                                child: Center(
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Open Mail App"),
            content: Text("No mail Apps installed"),
            actions: [
              RaisedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
