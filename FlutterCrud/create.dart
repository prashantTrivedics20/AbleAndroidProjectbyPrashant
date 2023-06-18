import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home.dart';

class create extends StatefulWidget {
  final String email;

  create({required this.email});
  //const create({Key? key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  TextEditingController title = TextEditingController();
  TextEditingController blog = TextEditingController();
  final firebase = FirebaseFirestore.instance;

  create() async {
    print('create call');
    try {
      await firebase
          .collection("Blog")
          .doc(widget.email)
          .set({"title": title.text, "blog": blog.text});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text("New Post")),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(children: [
                SizedBox(
                  height: 60,
                ),
                Text("Write a title for your text",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: title,
                  decoration: InputDecoration(
                      hintText: "Enter here...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 30),
                Text("Write", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 400,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: blog,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "start writing your post here",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                )
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                create();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return home(email: widget.email,);
                }));
              },
              child: Text("Post"),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat));
  }
}
