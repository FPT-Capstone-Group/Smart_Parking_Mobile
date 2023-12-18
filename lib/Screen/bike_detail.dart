import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/face_camera_registration_owner.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/list_cards.dart';
import 'package:parking_auto/Screen/list_onwer.dart';
import 'package:parking_auto/Screen/parking_history_filter.dart';
import 'package:parking_auto/controller/get_list_owner_controller.dart';
import 'package:parking_auto/model/listBike_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BikeDetail extends StatefulWidget {
  const BikeDetail(this.item, {super.key});

  final Data item;

  @override
  State<BikeDetail> createState() => _BikeDetail();
}

class _BikeDetail extends State<BikeDetail> {
  //late String _paymentStatus;
  final bool _isLoading = false;
  GetListOwnerController getListOwner = GetListOwnerController();

  dynamic plateNumber;
  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bike Detail'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
        actions: const [Icon(Icons.details)],
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  //const Divider(color: Colors.green),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Bike Information',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color:  Color.fromARGB(255, 204, 43, 43),
                          ),
                        ),
                        const Divider(color: Colors.green),
                        Container(height: 5),
                        Text('PlateNumber: ${widget.item.plateNumber}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text(
                            'Registration Number:  ${widget.item.registrationNumber}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text('Status: ${widget.item.status}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text('Manufacture: ${widget.item.manufacture}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text('Model: ${widget.item.model}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text('CreatedAt:  ${widget.item.createdAt}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        //      Text('cards:  ${widget.item.cards}',
                        // style: TextStyle(
                        //     fontSize: 15, color: Colors.grey[700])),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.green),
                        const SizedBox(height: 10),

                        const SizedBox(height: 10),
                        Center(
                          child: FloatingActionButton.extended(
                            heroTag: "btn1",
                            onPressed: () {
                              Get.to(const FaceCameraImageOwner());
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Add Owner'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: FloatingActionButton.extended(
                            heroTag: "btn2",
                            onPressed: () {
                              setPlateNumber();

                              Get.to(const ListOwner());
                            },
                            icon: const Icon(Icons.list),
                            label: const Text('List Owner'),
                          ),
                        ),
                        const SizedBox(height: 10),
         
                        Center(
                          child: FloatingActionButton.extended(
                            heroTag: "btn4",
                            onPressed: () {
                              setPlateNumber();
                              Get.to(Demo());
                            },
                            icon: const Icon(Icons.history),
                            label: const Text('View History'),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Center(
                          child: FloatingActionButton.extended(
                            heroTag: "btn4",
                            onPressed: () {
                              setBikeId();
                              Get.to(const ListCard());
                            },
                            icon: const Icon(Icons.history),
                            label: const Text('List Card'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 5)
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }


  void setPlateNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("plateNumber");
    prefs.setString("plateNumber", widget.item.plateNumber.toString());
  }

  void setBikeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("bikeId");
    prefs.setString("bikeId", widget.item.bikeId.toString());
  }
}
