import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:parking_auto/controller/payment_controller.dart';
import 'package:parking_auto/model/parking_session_model.dart';

class ParkingHistoryDetail extends StatefulWidget {
  const ParkingHistoryDetail(this.item, {super.key});

  final Data item;

  @override
  State<ParkingHistoryDetail> createState() => _ParkingHistoryDetail();
}

class _ParkingHistoryDetail extends State<ParkingHistoryDetail> {
  PaymentController getData = PaymentController();

  Uint8List base64Decode(String source) => base64.decode(source);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar( title: Text('Parking History Detail'),
          centerTitle: true,
          backgroundColor: Colors.green,),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PlateNumber: ${widget.item.plateNumber}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
               ),
              
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Check In Time: ${widget.item.checkinTime}"
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                  "Check Out Time:  ${widget.item.checkoutTime}"
                  ),
                  
                const SizedBox(
                  height: 5,
                ),
                //face image
                Text(
                  "check In FaceImage: "),
                  
                const SizedBox(height: 5),
                Center(child: Image.memory(base64Decode(widget.item.checkinFaceImage.toString()), width: 150, height: 150)
                ),
                const SizedBox(height: 5),
                  Text(
                  "check Out FaceImage: "),
                  
                const SizedBox(height: 5),
                Center(child: Image.memory(base64Decode(widget.item.checkoutFaceImage.toString()), width: 150, height: 150)
                ),
                const SizedBox(height: 10),
                //pleate number image
                Text(
                  "Check In Plate Image: "),
                  
                const SizedBox(height: 5),
                Center(child: Image.memory(base64Decode(widget.item.checkinPlateNumberImage.toString()), width: 50, height: 50)
                ),
                const SizedBox(height: 5),
                  Text(
                  "Check Out Plate Image: "),
                  
                const SizedBox(height: 5),
                Center(child: Image.memory(base64Decode(widget.item.checkoutPlateNumberImage.toString()), width: 50, height: 50)
                ),
           
             
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}
