import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Screen1.dart';
import 'flutter_firebase_demo.dart';


class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? _natxt;
  String? _emtxt;
  String? _errortxt;
  String? _phtxt;
  String? url;
  String _fullname='';
  File? _pickedimage;
  bool _passVisible = true;

  // firebase Instance
  final firebase = FirebaseFirestore.instance;

  // create() async {
  //   if (_pickedimage != null) {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('userimages')
  //         .child(_fullname + '.jpg');
  //         await ref.putFile(_pickedimage);
  //         url = await ref.getDownloadURL();
  //   }
  //   try {
  //     await firebase
  //         .collection("User")
  //         // .doc()
  //         .doc(email.text)
  //         .set({
  //       "name": name.text,
  //       "email": email.text,
  //       "phone": phone.text,
  //       "pass": pass.text,
  //       "college": college.text,
  //       "imageurl": url
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // getitem() async {
  //   try {
  //     await firebase
  //         .collection("User")
  //         // .doc()
  //         .doc(name.text).get({"name":})
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  create() async {
    print('create call');
    try {
      await firebase
          .collection("User")
          .doc(email.text)
          .set({"name": name.text, "email": email.text, "phone": phone.text, "pass": pass.text});
    } catch (e) {
      print(e);
    }
  }

  // update() async {
  //   try {
  //     await firebase.collection("User").doc(name.text).update({
  //       "email": email.text,
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // delete() async {
  //   try {
  //     await firebase.collection("User").doc(name.text).delete();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create your account"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(children: [
              Container(
                height: 250,
                child: Image(image: AssetImage("images/signup.png"))),
              // SizedBox(
              //   height: 10,
              // ),
              TextField(
                keyboardType: TextInputType.name,
                controller: name,
                
                decoration: InputDecoration(
                    labelText: "User Name",
                    hintText: "Enter Your Name",
                    errorText: _natxt,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLength: 10,
                controller: phone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Enter Your Phone Number",
                    errorText: _phtxt,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                decoration: InputDecoration(
                    labelText: "Email Address",
                    hintText: "Enter Email Address",
                    errorText: _emtxt,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                //width: 350,
                child: TextField(
                  maxLength: 6,
                  controller: pass,
                  keyboardType: TextInputType.number,
                  obscureText: _passVisible,
                  decoration: InputDecoration(
                      labelText: "Set Password",
                      hintText: "Enter Your password",
                      errorText: _errortxt,
                      suffixIcon: IconButton(
                          icon: Icon(
                            _passVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                    onPressed: () {
                      String em = email.text.toString();
                      if (name.text.length < 3) {
                        setState(() {
                          _natxt = "Enter atleast 3 character";
                        });
                      } else {
                        setState(() {
                          _natxt = null;
                        });
                      }
                      if (phone.text.length < 10) {
                        setState(() {
                          _phtxt = "Enter Valid Phone Number";
                        });
                      } else {
                        setState(() {
                          _phtxt = null;
                        });
                      }
                      if (pass.text.length < 6) {
                        setState(() {
                          _errortxt = "Password must contain 6 numbers";
                        });
                      } else {
                        setState(() {
                          _errortxt = null;
                        });
                      }
                      if (em.length < 5 || !em.contains('@')) {
                        setState(() {
                          _emtxt = "Enter Valid email address";
                        });
                      } else {
                        setState(() {
                          _emtxt = null;
                        });
                      }
                      if (name.text.length >= 3 &&
                          phone.text.length == 10 &&
                          pass.text.length == 6) {
                        _errortxt = null;
                        _phtxt = null;
                        _natxt = null;
                        create();
                        name.clear();
                        email.clear();
                        phone.clear();
                        pass.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return flutter_firebase_demo();
                          }), (route) => false);
                      }
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ])));
  }
}
