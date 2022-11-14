import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:open_mail_app/open_mail_app.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
                child: Text("Open Mail App"),
                onPressed: () async {
                  var result = await OpenMailApp.openMailApp();

                  if (!result.didOpen && !result.canOpen) {
                    showNoMailAppsDialog(context);
                  } else if (!result.didOpen && result.canOpen) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return MailAppPickerDialog(mailApps: result.options);
                        });
                  }
                })));
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
