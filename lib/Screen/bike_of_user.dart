

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/bike_detail.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/controller/get_list_bike_controller.dart';
import 'package:parking_auto/model/listBike_model.dart';

class BikeOfUser extends StatelessWidget {
  static const routeNamed = '/bikeOfUserScreen';
  const BikeOfUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
  title: Text('List Bike'),
  leading: IconButton(
    onPressed: () {
      Get.to(HomePage());
    },
    icon: Icon(Icons.home),),
    actions: [
      Icon(Icons.list_alt)
    ],
        ),
        body: const _BikeOfUser());
  }
}

class _BikeOfUser extends StatefulWidget {
  const _BikeOfUser({super.key});

  @override
  State<_BikeOfUser> createState() => _BikeOfUsers();
}

class _BikeOfUsers extends State<_BikeOfUser> {
  GetListBikeController getBikes = GetListBikeController();
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
    } else if(listData!.isEmpty) { 
      return Center(child: Text("No data"));
    } {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () async {
              final needReload = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BikeDetail(item),
                ),
              );
              if (needReload == true) {
                // Reload data
                fetchData();
              }
            },
            child: Container(
                                height: 100,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          SizedBox(
                                            height: 20,
                                          ),
                                           Text(
                                            "Registration Number:  ${item.registrationNumber}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "Plate Number:  ${item.plateNumber}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "Status: ${item.status}",
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
          );
        },
      );
    }
  }

  void fetchData() async {
    listData = null;
    if (mounted) setState(() {});
    try {
      final value = await getBikes.getListBikeData();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }
}
