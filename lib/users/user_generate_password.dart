import 'package:alusoft_app/users/user_check_mail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GeneratePassword extends StatefulWidget {
  const GeneratePassword({Key? key}) : super(key: key);

  @override
  State<GeneratePassword> createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  var _passwordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
  }

  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();

  // Future updatePassword()async{
  //   try {
  //     dynamic oldPasswordVerified = await verifyCurrentPassword()
  //   } catch (e) {

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckMail()));
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
          title: Text("Back",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create new Password",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Your new password must be different from previous used password"),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  obscureText: !_passwordVisible,
                  controller: oldPassword,
                  //controller: passwordControler,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.pink)),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
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
                    labelText: 'Old Password',
                  ),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 8 || value == "") {
                      return "Can't be less than 8 characters";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  obscureText: !_passwordVisible,
                  controller: newPassword,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.pink)),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
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
                    labelText: 'New Password',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 8 || value == "") {
                      return "Can't be less than 8 characters";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  obscureText: !_passwordVisible,
                  //controller: passwordControler,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.pink)),
                    floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
                          ? Theme.of(context).errorColor
                          : Colors.black;
                      return TextStyle(color: color);
                    }),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                        child: Text(
                      "Reset Password",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// Future verifyCurrentPassword() async{
//   try {
//   dynamic  user = FirebaseAuth.instance.currentUser;

//   var authCredentail = await FirebaseAuth.instance.signInWithCredential(credential)
    
//   } catch (e) {
    
//   }
// }
