import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class screen1 extends StatefulWidget {
  String? email;
  String? name;
  String? phone;
  screen1({required this.email, required this.name, required this.phone});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  String? email="";
  String? name="";
  String? phone="";
  void initState() {
    super.initState();
    setState(() {
      email = widget.email;
      name = widget.name;
      phone = widget.phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile"),backgroundColor: Color.fromARGB(155, 167, 108, 239),),
        body: Center(
          child: ListView(
            children: [
              Container(
                child: Image(image: AssetImage("images/profile.png")),
              ),
              ListTile(
                title: Text("Name"),
                subtitle: Text("$name"),
              ),
              ListTile(
                title: Text("Email Address"),
                subtitle: Text("$email"),
              ),
              ListTile(
                title: Text("Phone"),
                subtitle: Text("$phone"),
              )
            ],
          ),
        ));
  }
}
