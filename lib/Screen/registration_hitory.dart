import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/registration_detail.dart';
import 'package:parking_auto/controller/get_registraion_controller.dart';
import 'package:parking_auto/model/registration_respone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationHistory extends StatelessWidget {
  static const routeNamed = '/registrationHistoryScreen';
  const RegistrationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
  title: Text('Registration History'),
leading: IconButton(
    onPressed: () {
      Get.to(HomeNavBar());
    },
    icon:const Icon(Icons.home),
  ),
        ),
        body: const MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _RegistrationHistory();
}

class _RegistrationHistory extends State<MyStatefulWidget> {
  Uint8List base64Decode(String source) => base64.decode(source);
  GetRegistraionController getData = GetRegistraionController();
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
      return const Center(child: Text("No registration"));
    } {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("registrationId");
              prefs.setString("plateNumber", item.registrationId.toString());

              final needReload = await  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegistrationDetail(item),
                ),
              );
              if (needReload == true) {
                // Reload data
                fetchData();
              }
            },
            child: Container(
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
                          item.faceImage != ""
                              ?
                              // Add an image widget to display an, image
                              Image.memory(
                                  base64Decode(item.faceImage.toString()),
                                  width: 80,
                                  height: 100)
                              :const CircleAvatar(
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
                                Container(height: 5),
                                // Add a title widget
                                Text(
                                  "ID: ${item.registrationId}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Color(0xFF37474F),
                                      ),
                                ),
                                // Add some spacing between the title and the subtitle
                                Container(height: 10),
                                // Add a subtitle widget
                                Text(
                                  "Status: ${item.registrationStatus}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Colors.grey[500],
                                      ),
                                ),
                                // Add some spacing between the subtitle and the text
                                Container(height: 5),
                                // Add a text widget to display some text
                                Text(
                                  'Model: ${item.model}',
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Colors.grey[500],
                                      ),
                                ),
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
