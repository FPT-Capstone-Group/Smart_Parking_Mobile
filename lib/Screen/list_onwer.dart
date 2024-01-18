import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/owner_detail.dart';
import 'package:parking_auto/controller/get_list_owner_controller.dart';
import 'package:parking_auto/model/listOwner_model.dart';

class ListOwner extends StatelessWidget {
  static const routeNamed = '/listOwnerScreen';
  const ListOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('List Owners'),
        ),
        body: const _ListOwner());
  }
}

class _ListOwner extends StatefulWidget {
  const _ListOwner({super.key});

  @override
  State<_ListOwner> createState() => __ListOwner();
}

class __ListOwner extends State<_ListOwner> {
  Uint8List base64Decode(String source) => base64.decode(source);
  late AnimationController controller;
  GetListOwnerController getData = GetListOwnerController();
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
      return const Center(child: Text("No owner found"));
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
                  builder: (context) => OwnerDetail(item),
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
                          
                          item.ownerFaceImage != null
                              ? Image.memory(
                                  base64Decode(item.ownerFaceImage.toString()),
                                  width: 55,
                                  height: 55)
                              : const CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.orange,
                                  child: Text("No image"),
                                ),

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
                               Text("Name: ${item.fullName}"),
                                Container(height: 2),
                                // Add a title widget
                                Text(
                                  "Relationship: ${item.relationship}",
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
