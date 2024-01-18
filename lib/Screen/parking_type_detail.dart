import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/parking_order_info.dart';
import 'package:parking_auto/controller/active_deactive_owner_controller.dart';
import 'package:parking_auto/model/listParkingType_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingTypeDetail extends StatefulWidget {
  const ParkingTypeDetail(this.item, {super.key});

  final Data item;

  @override
  State<ParkingTypeDetail> createState() => _ParkingTyypeDetail();
}

class _ParkingTyypeDetail extends State<ParkingTypeDetail> {
  ActiveDeactiveOwnerController owner = ActiveDeactiveOwnerController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Parking Type Detail'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
        actions:const [Icon(Icons.details)],
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Parking Type Information",
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
         
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Container(height: 10),
                Text("Name: ${widget.item.parkingTypeName}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Status:  ${widget.item.parkingTypeStatus}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Group:  ${widget.item.parkingTypeGroup}"),
                Text("Fee:  ${widget.item.parkingTypeFee}"),
                Text("Description:  ${widget.item.description}"),
                const SizedBox(
                  height: 5,
                ),
                const Divider(color: Colors.white70),
                const SizedBox(height: 5),

            
                const SizedBox(height: 5),
               Center(
                 // padding: const EdgeInsets.symmetric(vertical: 16),
                      child: FloatingActionButton.extended(
                        onPressed: () async{
             
                             SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove("parkingTypeId");
                              prefs.setString("parkingTypeId", widget.item.parkingTypeId.toString());
                          Get.to(const ParkingOrderInfo());
                        },
                        icon:const Icon(Icons.login),
                        label:const Text('Next'),
                      ),
                 
                ),
              
              ],
            ),
          ),
        ],
      ),
    );
  }


}
