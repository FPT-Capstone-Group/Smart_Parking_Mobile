import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/face_camera_registration_owner.dart';
import 'package:parking_auto/Screen/list_onwer.dart';
import 'package:parking_auto/Screen/parking_history.dart';
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
  bool _isLoading = false;
  GetListOwnerController getListOwner = GetListOwnerController();

  var plateNumber;
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
        title: Text('Bike Detail'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Visibility(
              child:  Text(
                  "Owner ID: ${widget.item.bikeId}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
               ),
              visible: true,
            ),
                const SizedBox(height: 16),
                Text(
                  "Status: ${widget.item.status}", style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "PlateNumber: ${widget.item.plateNumber}", style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Model: ${widget.item.model}", style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Manufacture: ${widget.item.manufacture}", style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                 const SizedBox(height: 16),
              
                ElevatedButton(
                  onPressed: () {

                    Get.to(FaceCameraImageOwner());
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Add Owner ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                   setPlateNumber();
                    Get.to(ListOwner());
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "List Owner ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                 const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                   setPlateNumber();
                    Get.to(ParkingHistory());
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "View Parking History",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: const Color.fromARGB(255, 134, 81, 81).withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }

  void _setState() async {
    setState(() => _isLoading = false);
  }
  void setPlateNumber() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("plateNumber");
    prefs.setString("plateNumber", widget.item.plateNumber.toString());
    
  }
}
