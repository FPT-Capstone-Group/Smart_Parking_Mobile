import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/model/list_notification_model.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail(this.item, {super.key});

  final Data item;

  @override
  State<NotificationDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Notification Detail'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
        actions: [Icon(Icons.details)],
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Notification Information",
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 204, 43, 43),
              ),
            ),
          ),
          // const Divider(),
          const SizedBox(
            height: 20,
          ),
          // const Divider(color: Colors.green),
          Container(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Container(height: 10),
                Text("Message: ${widget.item.message}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Type:  ${widget.item.notificationType}"),
                const SizedBox(
                  height: 5,
                ),
                Text("Created At:  ${widget.item.createdAt}"),
               
                  const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Container(height: 10),

                
             
              ],
            ),
          ),
        ],
      ),
    );
  }

}
