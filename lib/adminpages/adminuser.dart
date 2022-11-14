import 'package:alusoft_app/drawer/hidden_drawer.dart';
import 'package:alusoft_app/get_user_Data/get_profile_picture.dart';
import 'package:alusoft_app/get_user_Data/get_user_Details.dart';
import 'package:alusoft_app/get_user_Data/get_user_email.dart';
import 'package:alusoft_app/get_user_Data/get_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<String> docIDs = [];

  Future getDocId() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                print(document.reference);
                docIDs.add(document.reference.id);
              }));
    } catch (e) {
      print("error");
    }
  }

  Future refreshList() async {
    await ApiCall();
  }

  Future ApiCall() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                print(document.reference);
                docIDs.add(document.reference.id);
              }));
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    deleteUsers(id) async {
      await FirebaseFirestore.instance.collection("users").doc(id).delete();
      print("deleted");

      Loader.show(context,
          isAppbarOverlay: true,
          overlayFromTop: 100,
          progressIndicator: Center(
              child: SpinKitChasingDots(
            color: Colors.green,
            size: 70.0,
          )),
          themeData: Theme.of(context).copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
          overlayColor: Colors.grey);

      var snackBar = SnackBar(content: Text("Deleted"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Future.delayed(Duration(seconds: 8), () {
        Loader.hide();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HiddenDrawer()));
      });

      return Text("Deleted");
    }

    return Scaffold(
        body: Center(
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        trailing: InkWell(
                            onTap: () async {
                              await deleteUsers(docIDs[index]);
                            },
                            child: Icon(Icons.delete)),
                        onLongPress: () async {
                          print("you held me");
                          await deleteUsers(docIDs[index]);
                        },
                        leading: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      backgroundColor: Colors.black,
                                      title: GetProfilePicture(
                                          documentId: docIDs[index]),
                                    ));
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: GetProfilePicture(documentId: docIDs[index]),
                          ),
                        ),
                        tileColor: Colors.pink[100],
                        title: GetUserName(
                          documentId: docIDs[index],
                        ),
                        subtitle: GetUserEmail(documentId: docIDs[index]),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    content: Builder(builder: (context) {
                                      return Stack(
                                        children: [
                                          Positioned(
                                              child: GetUserDetails(
                                                  documentId: docIDs[index])),
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Positioned.fill(
                                              top: 90,
                                              right: -10,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.black,
                                                    size: 10,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ))
                                        ],
                                      );
                                    }),
                                  ));
                        },
                      ),

                      // child: ListTile(
                      //     leading: CircleAvatar(
                      //         radius: 20,
                      //         child:
                      //             GetProfilePicture(documentId: docIDs[index])),
                      //     tileColor: Colors.pink[100],
                      //     title: GetUserName(documentId: docIDs[index]),
                      //     subtitle: GetUserEmail(documentId: docIDs[index]),
                      //     trailing: Icon(Icons.arrow_back),
                      //     onTap: () {
                      //       Stack(
                      //         children: [
                      //           Positioned(child: Builder(builder: (_) {
                      //             return AlertDialog();
                      //           }))
                      //         ],
                      //       );
                      //     }),
                    );
                  });
            }),
      ),
    ));
  }
}
