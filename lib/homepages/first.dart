import 'dart:convert';
import 'dart:ui';

import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:alusoft_app/backendfiles/otp.dart';
import 'package:alusoft_app/homepages/User.dart';
import 'package:alusoft_app/homepages/onboarding3.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List<String> list = <String>[
  "Front-End Web Development",
  "Back-down Web Development",
  "Full Stack Developement",
  "Cross-Platfrom Development",
];

List<String> genderGroup = ['Male', 'Female'];

class SignUpPage extends StatelessWidget {
  const SignUpPage({key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Create Account';

    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Create Account",
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.pinkAccent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (((context) => OnBoarding3()))));
            },
          ),
        ),
        backgroundColor: Colors.white,

        body: const MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyForm> {
  String _value = '';

  dynamic selectedValue;

  List categoryItemList = <List>[];

  getAllProduct() async {
    var response = await http
        .get(Uri.parse('https://alusoftportal-website.herokuapp.com/plans'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
      print(categoryItemList);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var firstname = TextEditingController();
  var surname = TextEditingController();
  var email = TextEditingController();
  var gender = TextEditingController();
  var planid = TextEditingController();

  late SingleValueDropDownController _cnt;
  late MultiValueDropDownController _cntMulti;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _cntMulti = MultiValueDropDownController();

    super.initState();
    getAllProduct();
  }

  var plans = [
    "Front-End Web Development",
    "Back-down Web Development",
    "Full Stack Developement",
    "Cross-Platfrom Development",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/bb.png'),
      )),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [Text("  CreateAccount")],
                  // ),
                  SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: firstname,
                      textCapitalization: TextCapitalization.values[0],
                      decoration: InputDecoration(
                          labelText: 'Firstname',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.values[0],
                      controller: surname,
                      decoration: InputDecoration(
                          labelText: 'Surname',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide:
                                  const BorderSide(color: Colors.pink))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: "example@abc.com",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Write a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Gender",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  RadioListTile(
                      activeColor: Colors.pink,
                      value: genderGroup[0],
                      groupValue: _value,
                      title:
                          Text("Male", style: GoogleFonts.andika(fontSize: 20)),
                      onChanged: (val) {
                        setState(() {
                          _value = "Male";
                        });
                        print(val);
                      }),
                  RadioListTile(
                      activeColor: Colors.pink,
                      value: genderGroup[1],
                      groupValue: _value,
                      title: Text("Female",
                          style: GoogleFonts.andika(fontSize: 20)),
                      onChanged: (val) {
                        print(val);
                        setState(() {
                          _value = "Female";
                        });
                        if (_value == genderGroup) {
                          print("Female");
                        }
                      }),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: gender,
                  //     textCapitalization: TextCapitalization.values[0],
                  //     decoration: InputDecoration(
                  //         labelText: 'Gender',
                  //         hintText: "Male/Female",
                  //         border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(40))),
                  //     // validator: (value) {
                  //     //   if (value != "Male" ||
                  //     //       value != "Female" ||
                  //     //       value == null ||
                  //     //       value.isEmpty) {
                  //     //     return 'Choose your gender';
                  //     //   }
                  //     //   return null;
                  //     // },
                  //   ),
                  // ),

                  SizedBox(
                    height: 40,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            labelText: 'Plan-Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0)),
                          ),

                          child: DropdownButton(
                              isExpanded: true,
                              hint: Text("Select Plan"),
                              value: selectedValue,
                              items: categoryItemList.map((category) {
                                return DropdownMenuItem(
                                    value: category['ID'],
                                    child: Row(
                                      children: [
                                        Text("ID:" + category['ID'].toString()),
                                        SizedBox(width: 10),
                                        Text(category['NAME']),
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              }),
                          // child: DropDownTextField(
                          //   singleController: _cnt,
                          //   listSpace: 20,
                          //   listPadding: ListPadding(top: 20),
                          //   enableSearch: true,
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return "Required field";
                          //     } else {
                          //       return null;
                          //     }
                          //   },
                          //   dropDownList: const [
                          //     DropDownValueModel(
                          //         name: 'Front End Web Development(ID:1)',
                          //         value: "value1"),
                          //     DropDownValueModel(
                          //         name: 'Back End Web Development',
                          //         value: "value2"),
                          //     DropDownValueModel(
                          //         name: 'Full Stack Development',
                          //         value: "value3"),
                          //     DropDownValueModel(
                          //         name: 'Cross Platform Development',
                          //         value: "value4"),
                          //     DropDownValueModel(
                          //         name: 'Cross Platform Development',
                          //         value: "value4"),
                          //   ],
                          //   listTextStyle: const TextStyle(color: Colors.red),
                          //   dropDownItemCount: 5,
                          //   onChanged: (val) {},
                          // ),
                        );
                      },

                      // decoration: InputDecoration(
                      //     labelText: 'Plan-Id',
                      //     hintText: "What plans are you choosing",
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(40))),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Choose your plans';
                      //   }
                      //   return null;
                      // },
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  // DropDownTextField(
                  //   //initialValue: "Plans",
                  //   listSpace: 20,
                  //   listPadding: ListPadding(top: 20),
                  //   enableSearch: true,
                  //   validator: (value) {
                  //     if (value == null) {
                  //       return "Required field";
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   dropDownList: const [
                  //     DropDownValueModel(
                  //         name: 'Front End Web Development(1)', value: "value1"),
                  //     DropDownValueModel(
                  //         name: 'Back End Web Development', value: "value2"),
                  //     DropDownValueModel(
                  //         name: 'Full Stack Development', value: "value3"),
                  //     DropDownValueModel(
                  //         name: 'Cross Platform Development', value: "value4"),
                  //   ],
                  //   listTextStyle: const TextStyle(color: Colors.red),
                  //   dropDownItemCount: 4,
                  //   onChanged: (val) {},
                  // ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.pink),
                        onPressed: () async {
                          final form = _formKey.currentState;

                          // if (form!.validate()) {
                          //   Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //           builder: (((context) => OTPage()))));

                          var data = {
                            'first_name': firstname.text,
                            'surname': surname.text,
                            'e_mail_address': email.text,
                            'gender': _value,
                            'plan_name': selectedValue
                          };
                          var response = await getHttp('/save-student', data);
                          print("response = ${response.statusCode} ");
                          print(response.statusCode);

                          if (response.statusCode == 200 && form!.validate()) {
                            Loader.show(context,
                                isAppbarOverlay: true,
                                overlayFromTop: 100,
                                progressIndicator: Center(
                                    child: SpinKitChasingDots(
                                  color: Colors.red,
                                  size: 70.0,
                                )),
                                themeData: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.fromSwatch()
                                        .copyWith(secondary: Colors.black38)),
                                overlayColor: Color(0x99E8EAF6));

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (((context) => OTPage()))));
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return Center(
                            //           child: CircularProgressIndicator());
                            //     });

                            Future.delayed(Duration(seconds: 8), () {
                              Loader.hide();
                            });

                            final snackBar = SnackBar(
                              duration: Duration(seconds: 1, milliseconds: 10),
                              backgroundColor: Colors.green,
                              content: const Text('Response Saved'),
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
                          } else {
                            Loader.show(context,
                                isAppbarOverlay: true,
                                overlayFromTop: 100,
                                progressIndicator: Center(
                                    child: SpinKitFadingCircle(
                                  color: Colors.red,
                                  size: 70.0,
                                )),
                                themeData: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.fromSwatch()
                                        .copyWith(secondary: Colors.black38)),
                                overlayColor: Color(0x99E8EAF6));

                            final snackBar = SnackBar(
                              duration: Duration(seconds: 14),
                              backgroundColor: Colors.red,
                              content: const Text(
                                  'Fill all details to continue.Server Error 404'),
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

                            Future.delayed(Duration(seconds: 15), () {
                              Loader.hide();
                            });
                          }
                        },
                        child: const Text('Create account'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
