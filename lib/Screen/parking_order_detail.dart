import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:intl/intl.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/get_list_owner_controller.dart';
import 'package:parking_auto/model/listParkingOrder_model.dart';

class ParkingOrderDetail extends StatefulWidget {
  const ParkingOrderDetail(this.item, {super.key});

  final Data item;

  @override
  State<ParkingOrderDetail> createState() => _ParkingOrderDetail();
}

class _ParkingOrderDetail extends State<ParkingOrderDetail> {
  //bool parkingOrder =true;
  //late String _paymentStatus;
  final bool _isLoading = false;
  GetListOwnerController getListOwner = GetListOwnerController();

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

      //  if (widget.item.expiredDate != null) {
      // String date = widget.item.expiredDate.toString();
      // DateTime parseDate =
      //     new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
      // var inputDate = DateTime.parse(parseDate.toString());
      // var outputFormat = DateFormat('yyyy-MM-dd');
      // var outputDate = outputFormat.format(inputDate);
      // widget.item.expiredDate = outputDate;
    //}
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Parking Order Detail'),
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
            child: SingleChildScrollView(
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
                          'Order Information',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color:  Color.fromARGB(255, 204, 43, 43),
                          ),
                        ),
                        const Divider(color: Colors.green),
                        Container(height: 5),
                        Text('Status: ${widget.item.parkingOrderStatus}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text(
                            'Amount:  ${widget.item.parkingOrderAmount}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text('Expired Date: ${widget.item.expiredDate}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                        Text('Created At: ${widget.item.createdAt}',
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700])),
                      
                        //      Text('cards:  ${widget.item.cards}',
                        // style: TextStyle(
                        //     fontSize: 15, color: Colors.grey[700])),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.green),
                        const SizedBox(height: 10),


                      ],
                    ),
                  ),
                  Container(height: 5)
                ],
              ),
            ),
            )
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


}
