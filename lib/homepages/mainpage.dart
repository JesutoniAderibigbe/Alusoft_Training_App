// import 'package:alusoft_app/adminpage/admin.dart';
// import 'package:alusoft_app/drawer/hidden_drawer.dart';
// import 'package:alusoft_app/homepages/home.dart';
// import 'package:alusoft_app/homepages/screen_1.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder<User?>(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 print(snapshot.data);
//                 return AdminLoginPage();
//               } else if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot != null) {
//                   return AdminLoginPage();
//                 }
//               }
//               {
//                 return AdminLoginPage();
//               }
//             }));
//   }
// }
