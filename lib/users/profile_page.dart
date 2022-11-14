import 'dart:io';

import 'package:alusoft_app/users/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final Uri _url = Uri.parse("https://alusofttechnologies.com");

  String? image = '';
  File? imageXFile;
  String? userImageUrl;
  String? name;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          image = snapshot.data()!["userImage"];
        });
      }
    });
  }

  File? _image;
  final _picker = ImagePicker();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
  }

  void showText(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Change Display Name!"),
            content: TextFormField(
              maxLength: 20,
              decoration: InputDecoration(labelText: "Name"),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'displayName': name});
                },
                child: Text("change"),
              )
            ],
          );
        });
  }

  void _showImageDialog(context) {
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
                        _getFromCamera(context);
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
                        _getFromGallery(context);
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

  void _getFromCamera(context) async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery(context) async {
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
        imageXFile = File(croppedImage.path);
        _updateImageInFireStore();
      });
    }
  }

  void _updateImageInFireStore() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    fStorage.Reference reference = fStorage.FirebaseStorage.instance
        .ref()
        .child("userImages")
        .child(fileName);

    fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      userImageUrl = url;
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'userImage': userImageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [Colors.white10, Colors.grey],
              // )),
              child: Container(
                height: 200.0,
                child: Row(
                  children: [
                    Stack(children: [
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          minRadius: 70,
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: imageXFile == null
                                  ? NetworkImage(image!)
                                  : Image.file(imageXFile!).image,
                            ),
                          )),
                      Positioned(
                          right: 16,
                          bottom: 40,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.camera, size: 20.0),
                            onPressed: () {
                              _showImageDialog(context);
                            },
                          ))
                    ]),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    Text(user.displayName!,
                        style: GoogleFonts.balooBhai2(fontSize: 25)),

                    GestureDetector(
                      child: Icon(Icons.update),
                      onTap: () {
                        showText(context);
                      },
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.black,
                ),
                title: Text("Courses"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Thank you for tapping me");
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.notification_add_sharp,
                  color: Colors.black,
                ),
                title: Text("Notifications"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Thank you for tapping me");
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: Text("Settings"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (((context) => UserSettingsPage()))));
                  print("Thank you for tapping me");
                },
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.add_business_outlined,
                  color: Colors.black,
                ),
                title: Text("About us"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Row(
                              children: [
                                Text("Alusoft Technologies"),
                                SizedBox(width: 5),
                                Image.asset(
                                  "assets/images/bb.png",
                                  height: 20,
                                )
                              ],
                            ),
                            content: GestureDetector(
                              child: Text(
                                  "We develop excellent and cost-effective software solutions for government businesses, corporate enterprise and personal use"),
                            ),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  _launchUrl();
                                },
                                child: Text("Read more......"),
                              )
                            ],
                          ));
                  print("Thank you for tapping me, are you ready?");
                },
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.pink),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  content: Text(
                                      "You have questions or complaints. You can reach our customer care"),
                                ));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.headset,
                          size: 60,
                        ),
                        title: Text(
                          "How can we help you?",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text("Privacy Policy"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10.0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Imprint"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10.0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("English"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 10.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
