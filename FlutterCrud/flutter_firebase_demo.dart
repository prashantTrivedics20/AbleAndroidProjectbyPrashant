import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'SignUp.dart';
import 'home.dart';

class flutter_firebase_demo extends StatefulWidget {
  const flutter_firebase_demo({Key? key}) : super(key: key);
  @override
  State<flutter_firebase_demo> createState() => _flutter_firebase_demoState();
}

class _flutter_firebase_demoState extends State<flutter_firebase_demo> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String? _errortxtp;
  String? _errortxte;
  bool _passVisible = true;
  // firebase Instance
  final firebase = FirebaseFirestore.instance;

  login() async {
    try {
      String e = email.text.toString();
      String p = pass.text.toString();
      if (e.length < 5 || !e.contains('@')) {
        _errortxte = "Enter a Valid Email";
      } else {
        setState(() {
          _errortxte = null;
        });
      }
      if (e.length >= 5 && e.contains('@') && p.length < 6) {
        _errortxtp = "Invalid Password";
      } else {
        setState(() {
          _errortxtp = null;
        });
      }
      var a = await FirebaseFirestore.instance.collection("User").doc(e).get();
      if (a.exists && e.length >= 5 && e.contains('@') && p.length == 6) {
        Map<String, dynamic>? map = a.data();

        if (map!.containsKey('pass')) {
          if (map.containsValue(p)) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return home(
                email: email.text,
              );
            }), (route) => false);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) {
            //   return s2(uremail: e);
            // }));
          } else {
            setState(() {
              _errortxtp = "Password Not Correct";
            });
          }
          // Replace field by the field you want to check.
        }
      } else if (!a.exists &&
          e.length >= 5 &&
          e.contains('@') &&
          p.length == 6) {
        setState(() {
          _errortxte = "This Email is Not Registered";
        });
      }

      // await firebase
      //     .collection("User")
      //     .doc(name.text)
      //     .set({"name": name.text, "email": email.text});
    } catch (e) {
      print(e);
    }
    // print("Create Button Cliecked");
  }

/*
  update() async {
    print('update call');
    try {
      await firebase.collection("User").doc(name.text).update({
        "email": email.text,
      });
    } catch (e) {
      print(e);
    }
  }

  delete() async {
    try {
      await firebase.collection("User").doc(name.text).delete();
    } catch (e) {
      print(e);
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(child: Image(image: AssetImage("images/login.png"))),
            SizedBox(
              height: 30,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter Email Address",
                  errorText: _errortxte,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              maxLength: 6,
              keyboardType: TextInputType.number,
              controller: pass,
              obscureText: _passVisible,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  errorText: _errortxtp,
                  suffixIcon: IconButton(
                      icon: Icon(
                        _passVisible ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      }),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                /*
                ElevatedButton(
                    onPressed: () {
                      update();
                      name.clear();
                      email.clear();
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(fontSize: 20),
                    )),
                ElevatedButton(
                    onPressed: () {
                      delete();
                      name.clear();
                      email.clear();
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 20),
                    )),
                    */
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return signupscreen();
                        }));
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      child: Text(
                        "SignUp",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ],
            )
            // ,
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 20),
            //   // height: 300,
            //   // width: double.infinity,
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: firebase.collection("User").snapshots(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Container(
            //           height: 1000,
            //           child: ListView.builder(
            //               itemCount: snapshot.data!.docs.length,
            //               itemBuilder: (context, i) {
            //                 QueryDocumentSnapshot x = snapshot.data!.docs[i];
            //                 return Column(
            //                   children: [
            //                     ListTile(
            //                       leading: Icon(
            //                         Icons.person,
            //                         size: 40,
            //                       ),
            //                       title: Text(x['name']),
            //                       subtitle: Text(x['email']),
            //                     ),
            //                     Divider(
            //                       height: 5,
            //                     )
            //                   ],
            //                 );
            //               }),
            //         );
            //       } else {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
