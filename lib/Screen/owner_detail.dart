import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/controller/active_deactive_owner_controller.dart';
import 'package:parking_auto/model/listOwner_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerDetail extends StatefulWidget {
  const OwnerDetail(this.item, {super.key});

  final Data item;

  @override
  State<OwnerDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<OwnerDetail> {
  ActiveDeactiveOwnerController owner = ActiveDeactiveOwnerController();

  Uint8List base64Decode(String source) => base64.decode(source);
  var isActive;
  bool actiVisible = false;
  bool deactiVisible = false;
  @override
  Widget build(BuildContext context) {
    if (widget.item.isActive == true) {
      isActive = "True";
    }else {
      isActive = "False";
    }
    if(widget.item.relationship!.toLowerCase() != "owner"){
      deactiVisible = true;
      actiVisible = true;
    }
    if(isActive =="True")
    {
      deactiVisible = true;
      actiVisible = false;
    }
    if(isActive == "False"){
      deactiVisible = false;
      actiVisible = true;
    }
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
  title: Text('Owner Detail'),
  leading: IconButton(
    onPressed: () {
      Get.to(HomePage());
    },
    icon: Icon(Icons.home),),
    actions: [
      Icon(Icons.details)
    ],
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
   
          const Padding(
            
             padding: const EdgeInsets.all(8.0),
            child: Text(
              "Owner Information",
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 204, 43, 43),
                          ),
                        ),
          ),
          // const Divider(),
           const SizedBox(
                  height: 20,
                ),
         // const Divider(color: Colors.green),
                        Container(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("Owner ID: ${widget.item.ownerId}"),
                // const SizedBox(
                //   height: 5,
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Container(height: 10),
                Text("Full Name: ${widget.item.fullName}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Relationship:  ${widget.item.relationship}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Gender:  ${widget.item.gender}"),
                Text("Is Active:  ${isActive}"),
                const SizedBox(
                  height: 5,
                ),
                const Divider(color: Colors.white70),
                const SizedBox(height: 5),
                Center(
                  child: widget.item.ownerFaceImage != null
                      ? Image.memory(
                          base64Decode(widget.item.ownerFaceImage.toString()),
                          width: 250,
                          height: 250)
                      : CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.orange,
                          child: Text("No image"),
                        ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Visibility(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          ownerId();
                          owner.deactiveOwner();
                        },
                        icon: Icon(Icons.login),
                        label: Text('DeActive'),
                      ),
                      visible: deactiVisible),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Visibility(
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          ownerId();
                          owner.activeOwner();
                        },
                        icon: Icon(Icons.login),
                        label: Text('Active'),
                      ),
                      visible: actiVisible),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }

  void ownerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("ownerId");
    prefs.setString("ownerId", widget.item.ownerId.toString());
  }
}
