import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/parking_type_detail.dart';
import 'package:parking_auto/controller/get_list_parking_type_controller.dart';
import 'package:parking_auto/model/listParkingType_model.dart';

class ListParkingType extends StatelessWidget {
  static const routeNamed = '/ListParkingTypeScreen';
  const ListParkingType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('List Parking Type'),
          // leading: IconButton(
          //   onPressed: () {
          //     Get.to(const HomePage());
          //   },
          //   icon: const Icon(Icons.home),
          // ),
          // actions: [Icon(Icons.list)],
        ),
        body: const _ListParkingType());
  }
}

class _ListParkingType extends StatefulWidget {
  const _ListParkingType({super.key});

  @override
  State<_ListParkingType> createState() => ___ListParkingType();
}

class ___ListParkingType extends State<_ListParkingType> {
  Uint8List base64Decode(String source) => base64.decode(source);
  late AnimationController controller;
  GetListParkingTypeController getData = GetListParkingTypeController();
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
      return const Center(child: Text("No parking type found"));
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
                  builder: (context) => ParkingTypeDetail(item),
                ),
              );
              if (needReload == true) {
                // Reload data
                fetchData();
              }
            },
            child: SingleChildScrollView(
            child:   Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(),
              ),
              child: Card(
                // Define the shape of the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                // Define how the card's content should be clipped
                clipBehavior: Clip.antiAliasWithSaveLayer,
                // Define the child widget of the card
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Add padding around the row widget
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                      

                          // Add some spacing between the image and the text
                          Container(width: 20),
                          // Add an expanded widget to take up the remaining horizontal space
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Add some spacing between the top of the card and the title
                                Container(height: 2),
                               // Add a title widget
                               Text("Name: ${item.parkingTypeName}"),
                                Container(height: 2),
                                // Add a title widget
                                Text(
                                  "Fee: ${item.parkingTypeFee}",
                                ),
                                // Add some spacing between the title and the subtitle
                                Container(height: 2),
                          
                              ],
                            ),
                          
                          ),
                        ],
                      ),
                    ),
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
      final value = await getData.fetchData();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }
}
