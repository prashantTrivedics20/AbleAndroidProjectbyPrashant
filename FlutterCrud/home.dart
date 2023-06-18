// import 'dart:html';

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';

import 'Screen1.dart';
import 'create.dart';
import 'flutter_firebase_demo.dart';

class home extends StatefulWidget {
  String email;

  home({required this.email});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final firebase = FirebaseFirestore.instance;
  void initState() {
    super.initState();
    setState(() {
      email = widget.email;
    });
  }

  String title = "";
  String bio = "";
  String? email;
  String name = "";
  String phone = "";
  String date = "";

  getname() async {
    String d = await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .get()
        .then((value) {
      return value.data()!["name"]; // Access your after your get the data
    });
    setState(() {
      name = d;
    });
  }

  getphone() async {
    String d = await FirebaseFirestore.instance
        .collection("User")
        .doc(email)
        .get()
        .then((value) {
      return value.data()!["phone"]; // Access your after your get the data
    });
    setState(() {
      phone = d;
    });
  }

  gettitle() async {
    String d = await FirebaseFirestore.instance
        .collection("Blog")
        .doc(email)
        .get()
        .then((value) {
      return value.data()!["title"]; // Access your after your get the data
    });
    setState(() {
      title = d;
    });
  }

  getbio() async {
    String d = await FirebaseFirestore.instance
        .collection("Blog")
        .doc(email)
        .get()
        .then((value) {
      return value.data()!["blog"]; // Access your after your get the data
    });
    setState(() {
      bio = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: [
              IconButton(
                  onPressed: () {
                    gettitle();
                    getbio();
                    getname();
                    getphone();
                  },
                  icon: Icon(Icons.refresh_outlined))
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Profile"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return screen1(email: email, name: name, phone: phone);
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text("Sign Out"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return flutter_firebase_demo();
                    }), (route) => false);
                  },
                )
              ],
            ),
          ),
          body: ListView(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(8.0),
                leading: InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: name.isEmpty ? Colors.white : Colors.blue,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                title: Text("$name",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$title",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: bio.isEmpty ? Colors.white : Colors.black)),
                child: Text(
                  "$bio",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return create(email: widget.email);
              }));
            },
            child: const Icon(
              Icons.create,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat),
    );
  }
}
