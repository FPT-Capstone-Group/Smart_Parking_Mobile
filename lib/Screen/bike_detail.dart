import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/face_camera_registration_owner.dart';
import 'package:parking_auto/Screen/list_onwer.dart';
import 'package:parking_auto/model/listBike_model.dart';

class BikeDetail extends StatefulWidget {
  const BikeDetail(this.item, {super.key});

  final Data item;

  @override
  State<BikeDetail> createState() => _BikeDetail();
}

class _BikeDetail extends State<BikeDetail> {
  //late String _paymentStatus;
  bool _isLoading = false;

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
        title: Text('Bike detail'),
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
                // Text(
                //   "ID: ${widget.item.bikeId}",
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 16),
                Text(
                  "Status: ${widget.item.status}",
                ),
                const SizedBox(height: 16),
                Text(
                  "PlateNumber: ${widget.item.plateNumber}",
                ),
                const SizedBox(height: 16),
                Text(
                  "Model: ${widget.item.model}",
                ),
                const SizedBox(height: 16),
                Text(
                  "Manufacture: ${widget.item.manufacture}",
                ),
                 const SizedBox(height: 16),
                // Text(
                //   "Card Id: ${widget.item.cardId}",
                // ),
                // const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Get.to(RegistrationOnwer());
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
                    Get.to(ListOnwerScreen());
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
}
