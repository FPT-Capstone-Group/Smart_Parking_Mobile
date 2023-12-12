import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:parking_auto/controller/payment_controller.dart';
import 'package:parking_auto/model/listOwner_model.dart';

class OwnerDetail extends StatefulWidget {
  const OwnerDetail(this.item, {super.key});

  final Data item;

  @override
  State<OwnerDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<OwnerDetail> {
  PaymentController getData = PaymentController();

  Uint8List base64Decode(String source) => base64.decode(source);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text('Owner detail'),
          centerTitle: true,
          backgroundColor: Colors.green,),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Visibility(
              child:  Text(
                  "Owner ID: ${widget.item.ownerId}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
               ),
              visible: true,
            ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Full Name: ${widget.item.fullName}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                  "Relationship:  ${widget.item.relationship}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  
                ),
                const SizedBox(
                  height: 5,
                ),
                
                Text(
                  "Gender:  ${widget.item.gender}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  
                ),
                const SizedBox(
                  height: 5,
                ),
               
               
                const SizedBox(height: 5),
                Center(child: Image.memory(base64Decode(widget.item.ownerFaceImage.toString()), width: 250, height: 250)
                ),
                const SizedBox(height: 5),  

              ],
            ),
          ),
        ],
      ),
    );
  }

  
}
