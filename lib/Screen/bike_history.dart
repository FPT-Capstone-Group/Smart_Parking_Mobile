import 'package:flutter/material.dart';
import 'package:parking_auto/model/registration_respone_model.dart';

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
          title: Text('Bike history log'),
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
                Text(
                  "ID: ${widget.item.registrationId}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Status: ${widget.item.registrationStatus}",
                ),
                Text(
                  "PlateNumber: ${widget.item.plateNumber}",
                ),
                Text(
                  "Price: ${widget.item.amount}" + "vnd",
                ),
                const SizedBox(height: 16),
            
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
