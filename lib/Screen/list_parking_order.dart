import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/parking_order_detail.dart';
import 'package:parking_auto/controller/get_list_parking_order_controller.dart';
import 'package:parking_auto/model/listParkingOrder_model.dart';

class ListParkingOrder extends StatelessWidget {
  static const routeNamed = '/bikeOfUserScreen';
  const ListParkingOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('List Parking Order'),
         leading: IconButton(
    onPressed: () {
      Get.to(HomeNavBar());
    },
    icon:const Icon(Icons.home),
  ),
        ),
        body:  _ListParkingOrder());
  }
}

class _ListParkingOrder extends StatefulWidget {

  @override
  State<_ListParkingOrder> createState() => __ListParkingOrder();
}

class __ListParkingOrder extends State<_ListParkingOrder> {
  GetListParkingOrderController getOrders = GetListParkingOrderController();
  List<Data>? listData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final list = listData;
    if (list == null) {
      return Container(
        color: Colors.grey[300],
        child: const Center(child: CircularProgressIndicator()),
      );
    } else if (listData!.isEmpty) {
      return const Center(child: Text("No parking order found"));
    }
    {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () async {
              final needReload = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ParkingOrderDetail(item),
                ),
              );
              if (needReload == true) {
                // Reload data
                fetchData();
              }
            },
            child: SingleChildScrollView(
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   "${item.checkinTime}",
                        //   style: const TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   "${item.checkoutTime}",
                        //   style: const TextStyle(
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   "Registration Number:  ${item.registrationNumber}",
                        //   style: const TextStyle(
                        //       fontSize: 15,
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.normal),
                        // ),
                        Text(
                          "Created At:  ${item.createdAt}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Status: ${item.parkingOrderStatus}",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    // Image.asset(
                    //   "assets/logo.png",
                    //   height: double.infinity,

                    // )
                  ],
                ),
              ),
            ),
            )
          );
        },
      );
    }
  }

  void fetchData() async {
    listData = null;
    if (mounted) setState(() {});
    try {
      final value = await getOrders.fetchData();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }
}
