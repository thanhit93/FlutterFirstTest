import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit profile".toUpperCase(),
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfileScreen> {
  File avatarImageFile, backgroundImageFile;

  Future getImage(bool isHasAvatar) async {
    var result = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (isHasAvatar) {
        avatarImageFile = result;
      } else {
        backgroundImageFile = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                   child: Stack(
                     children: <Widget>[
                       Text("test", style: TextStyle(color: Colors.blue),),
                       backgroundImageFile == null ? Image.asset("images/ic_background_empty.jpg"
                       , width: double.infinity, height: 150.0, fit: BoxFit.cover,)
                           : Image.file(backgroundImageFile, width: double.infinity,
                         height: 150.0, fit: BoxFit.cover,)
                       ,
                       Container(
                         margin: EdgeInsets.only(left: 10.0, right: 10.0),
                         child: Text("test", style: TextStyle(color: Colors.blue),),
                       ),
                       Positioned(child: Material(
                         child: IconButton(
                             icon: Image.asset("images/ic_camera.png", width: 30.0, height: 30.0, fit: BoxFit.cover,),
                             onPressed: null),
                         borderRadius: BorderRadius.all(Radius.circular(40.0)),
                       ),
                       right: 10.0 , top: 10.0,),
                       // Avatar and button
                       Positioned(
                         child: Stack(
                           children: <Widget>[
                             Material(
                               child: IconButton(
                                   icon: (avatarImageFile == null) ? Image.asset("images/ic_avatar_default.png",
                                     fit: BoxFit.cover,) : Image.file(avatarImageFile, fit: BoxFit.cover,),
                                   onPressed: null, iconSize: 60.0),
                               borderRadius: BorderRadius.all(Radius.circular(40.0)),
                             )
                           ],
                         ),
                         bottom: 5.0,
                         left: MediaQuery.of(context).size.width / 2 - 60 / 2,
                       ),
                     ],
                   ),
              )],
            ),
          )
        ],
      ),
    );
  }
}
