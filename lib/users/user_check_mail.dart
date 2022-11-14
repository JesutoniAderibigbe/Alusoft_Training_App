import 'package:alusoft_app/users/user_generate_password.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';

class CheckMail extends StatefulWidget {
  const CheckMail({Key? key}) : super(key: key);

  @override
  State<CheckMail> createState() => _CheckMailState();
}

class _CheckMailState extends State<CheckMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/email.png',
                width: 100,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text("Check your mail",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Center(
                child: Text(
                    "We have sent a password recover instructions to your email.")),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          )),
                          backgroundColor: Colors.pink[100],
                          elevation: 24.0,
                          content: Text("Allow Alusoft App access to mail?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'DENY'),
                              child: const Text('DENY'),
                            ),
                            TextButton(
                                onPressed: () async {
                                  Navigator.pop(
                                    context,
                                  );
                                  var result = await OpenMailApp.openMailApp();

                                  if (!result.didOpen && !result.canOpen) {
                                    showNoMailAppsDialog(context);
                                  } else if (!result.didOpen &&
                                      result.canOpen) {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return MailAppPickerDialog(
                                              mailApps: result.options);
                                        });
                                  }
                                },
                                child: const Text('ALLOW')),
                          ],
                        ));

                print("You tapped me");
              },
              child: Center(
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                      child: Text(
                    "Open email app",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeneratePassword()));
                },
                child: Text("Skip, I'll confirm later.",
                    style: TextStyle(fontSize: 20))),
            SizedBox(height: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                    "Did not receive the email? Check your spam folder or try another email address"),
              ],
            )
          ],
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
