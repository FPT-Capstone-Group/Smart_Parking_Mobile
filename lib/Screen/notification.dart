import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/notification_detail.dart';
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
          title: const Text('Notifications'),
          leading: IconButton(
            onPressed: () {
              Get.to(HomeNavBar());
            },
            icon: const Icon(Icons.home),
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
    } else if (listData!.isEmpty) {
      return const Center(child: Text("No registration"));
    }
    {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
              onTap: ()async  {
              
                final needReload = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NotificationDetail(item),
                  ),
                );
                if (needReload == true) {
                  // Reload data
                  fetchData();
                }
              },
              child: SingleChildScrollView(
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
                             
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Add some spacing between the top of the card and the title
                                    Container(height: 5),
                                    // Add a title widget
                                    SizedBox(
                                      width: 220.0,
                                      child: Text(
                                        "Message: ${item.message}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style:const  TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                    // Add some spacing between the title and the subtitle
                                    Container(height: 10),
                                    // Add a subtitle widget
                                    SizedBox(
                                      width: 220.0,
                                      child: Text(
                                        "Time: ${item.createdAt}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style:const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                    // Add some spacing between the subtitle and the text
                                    // Add a text widget to display some text
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
              ));
        },
      );
    }
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
