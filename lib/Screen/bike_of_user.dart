

import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/bike_detail.dart';
import 'package:parking_auto/controller/get_list_bike_controller.dart';
import 'package:parking_auto/model/listBike_model.dart';

class BikeOfUser extends StatelessWidget {
  const BikeOfUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List bike'),
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
    } else {
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
                    "Bike: ${item.bikeId}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "plateNumber: ${item.plateNumber}",
                  ),
                  Text(
                    "status: ${item.status}",
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
      final value = await getBikes.getListBikeData();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }
}
