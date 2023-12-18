import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
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
      appBar: AppBar(
        centerTitle: true,
  title: Text('Parking History Detail'),
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
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                //onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Check In Detail",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // const Divider(),
                     Container(height: 10),
                    const Divider(color: Colors.green, height: 20,),
                        
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Time:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //const Divider(),
                   Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "${widget.item.checkinTime}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Face Image:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //const Divider(),
                    Padding(
                       padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.item.checkinFaceImage != null ?
                          Image.memory(
                              base64Decode(
                                  widget.item.checkinFaceImage.toString()),
                              width: 100,
                              height: 100) : CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.orange,
                                  child: Text("No image"),
                                ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Plate Number:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                   // const Divider(),
                    Padding(
                       padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.item.checkinPlateNumberImage != null ?
                          Image.memory(
                              base64Decode(widget.item.checkinPlateNumberImage
                                  .toString()),
                              width: 100,
                              height: 100) : CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.orange,
                                  child: Text("No image"),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(width: 2),
          Expanded(
            flex: 1,
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
               // onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Check Out Detail",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                     Container(height: 10),
                    const Divider(color: Colors.green,height: 20,),
                       
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Time:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                   // const Divider(),
                   Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "${widget.item.checkoutTime}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Face Image:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.item.checkoutFaceImage !=  null ?
                          Image.memory(
                              base64Decode(
                                  widget.item.checkoutFaceImage.toString()),
                              width: 100,
                              height: 100) : CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.orange,
                                  child: Text("No image"),
                                ),
                        
                        ],
                      ),
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Text(
                        "Plate Number:",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.item.checkoutPlateNumberImage != null ?

                          Image.memory(
                              base64Decode(widget.item.checkoutPlateNumberImage
                                  .toString()),
                              width: 100,
                              height: 100) : CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.orange,
                                  child: Text("No image"),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
