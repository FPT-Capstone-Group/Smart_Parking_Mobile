

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/get_notifications_controller.dart';
import 'package:parking_auto/model/list_notification_model.dart';

class NotificationPage extends StatelessWidget {
  static const routeNamed = '/NotificationPageScreen';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
  title:const Text('Notifications'),
  leading: IconButton(
    onPressed: () {
      Get.to(HomeNavBar());
    },
    icon:const Icon(Icons.home),
  ),

        ),
        body: const _NotificationPage());
  }
}

class _NotificationPage extends StatefulWidget {
  const _NotificationPage({super.key});

  @override
  State<_NotificationPage> createState() => __NotificationPage();
}

class __NotificationPage extends State<_NotificationPage> {
   GetListNotiController getData = GetListNotiController();
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
      return const Center(child: Text("No data"));
    }
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(

            child: Container(
                                height: 100,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const
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
                                         
                                        const  SizedBox(
                                            height: 20,
                                          ),
                                          //  Text(
                                          //   "Notification Id:  ${item.notificationId}",
                                          //   style: const TextStyle(
                                          //       fontSize: 15,
                                          //       color: Colors.black,
                                          //       fontWeight: FontWeight.normal),
                                          // ),
                                          Text(
                                            "Message:  ${item.message}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          Text(
                                            "Notification Type: ${item.notificationType}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                           Text(
                                            "Created: ${item.createdAt}",
                                            style: const TextStyle(
                                                fontSize: 10,
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

  void fetchData() async {
    listData = null;
    if (mounted) setState(() {});
    try {
      final value = await getData.getListNoti();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }
}
