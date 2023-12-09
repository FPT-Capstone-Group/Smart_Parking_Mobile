import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/registration_detail.dart';
import 'package:parking_auto/controller/get_registraion_controller.dart';
import 'package:parking_auto/model/registration_respone_model.dart';

class RegistrationHistory extends StatelessWidget {
  static const routeNamed = '/registrationHistoryScreen';
  const RegistrationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration History'),
           centerTitle: true,
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
  late AnimationController controller;
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
    } else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
            onTap: () async {
              final needReload = await Navigator.of(context).push(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID: ${item.registrationId}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   Text(
                    "Create to : ${item.createdAt}",
                    ),
                  
                  Text(
                    "Status: ${item.registrationStatus}",
                  ),
                  Text(
                    "PlateNumber: ${item.plateNumber}",
                  ),
                ],
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
