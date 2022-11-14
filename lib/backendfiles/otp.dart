import 'package:alusoft_app/homepages/User.dart';
import 'package:alusoft_app/homepages/first.dart';
import 'package:alusoft_app/main.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPage extends StatefulWidget {
  const OTPage({Key? key}) : super(key: key);

  @override
  State<OTPage> createState() => _OTPageState();
}

class _OTPageState extends State<OTPage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    //TextEditingController emailController = TextEditingController();

    TextEditingController otp = TextEditingController();

    showNotification() async {
      setState(() {
        _counter++;
      });

      flutterLocalNotificationsPlugin.show(
          0,
          "Alusoft App",
          "Thank you for choosing Alusoft App!",
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  importance: Importance.high,
                  color: Colors.pink,
                  playSound: true,
                  icon: '@mipmap/launcher_icon')));

      print("Hey");
    }

    sendOTP() async {
      EmailAuth(sessionName: "Alusoft_App");

      var res = await EmailAuth(sessionName: "Alusoft_App")
          .sendOtp(recipientMail: email.text.trim());

      var positiveRes = 'Sent Successfully';
      var negativeRes = 'Not successful';

      if (res) {
        //   showNotification();
        print("OTP Sent");
      } else {
        print("We could not send the OTP");
      }
      var snackBar = SnackBar(
        content: Text(res ? positiveRes : negativeRes),
        backgroundColor: res ? Colors.green : Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    verifyOTP() async {
      try {
        var res = EmailAuth(sessionName: "Alusoft_App")
            .validateOtp(recipientMail: email.text, userOtp: otp.text);

        if (res) {
          showNotification();
          Loader.show(context,
              isAppbarOverlay: true,
              overlayFromTop: 100,
              progressIndicator: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitFadingCube(
                    color: Colors.pink,
                    size: 70.0,
                  ),
                  Center(
                      child: Text("We are verifying your OTP!",
                          style: GoogleFonts.inter(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.black))),
                ],
              ),
              themeData: Theme.of(context).copyWith(),
              overlayColor: Color(0x99E8EAF6));
          Future.delayed(Duration(seconds: 20), () {
            Loader.hide();
          });
          return Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (((context) => UserTable()))));
        } else {
          Loader.show(context,
              isAppbarOverlay: true,
              overlayFromTop: 100,
              progressIndicator: Center(
                  child: SpinKitFadingCube(
                color: Colors.red,
                size: 70.0,
              )),
              themeData: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch()
                      .copyWith(secondary: Colors.black38)),
              overlayColor: Color(0x99E8EAF6));

          Future.delayed(Duration(seconds: 15), () {
            final snackBar = SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: const Text('Invalid OTP'),
              action: SnackBarAction(
                textColor: Colors.black,
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Loader.hide();
          });
          print("Invalid OTP");
        }
      } catch (e) {}
    }

    var _passwordVisible = false;

    @override
    void initState() {
      // TODO: implement initState
      _passwordVisible = false;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text("Verify Email"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (((context) => SignUpPage()))));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/bb.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLength: 40,
                          controller: email,
                          decoration: InputDecoration(
                              hintText: '',
                              labelText: 'Email',
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                    child: Text("Send OTP"),
                                    onPressed: () => sendOTP()),
                              ),
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLength: 25,
                          controller: otp,
                          decoration: InputDecoration(
                              hintText: 'Input OTP',
                              labelText: 'OTP',
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
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.pink),
                          onPressed: () => verifyOTP(),
                          child: const Text('Create account'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
