import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserDetails extends StatelessWidget {
  final String documentId;

  GetUserDetails({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              leading: Image.network(
                "${data['userImage']}",
              ),
              title: Row(
                children: [
                  Text(
                    "NAME: ${data['displayName']}",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "ID: ${data['uid']}                                 EMAIL: ${data['email']}",
                    style: TextStyle(color: Colors.black)),
              ),
              // trailing: Text("EMAIL: ${data['email']}"),
            );
            // return Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text("NAME: ${data['displayName']}"),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text("EMAIL: ${data['email']}"),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text("GENERATED ID: ${data['uid']}"),
            //       )
            //     ],
            //   ),
            // );
          }
          return Text("Loading...");
        });
  }
}
