import 'package:flutter/material.dart';
import 'package:parking_auto/controller/get_data_controller.dart';
import 'package:parking_auto/model/reistraion_model.dart';

class BikeHistoryLog extends StatelessWidget  {
 const BikeHistoryLog({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: const Text('Bike History Log'),
        ),
        body: const _BikeHistoryLog());
  }
  }

class _BikeHistoryLog extends StatefulWidget {
  const _BikeHistoryLog({super.key});
  @override
  __BikeHistoryLog createState() => __BikeHistoryLog();
}

class __BikeHistoryLog extends State<_BikeHistoryLog> {
  
GetDataController getData = GetDataController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: getData.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 75,
                  color: Colors.white,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //Text(snapshot.data![index].title),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(snapshot.data![index].title),
                            Text(snapshot.data![index].userId.toString()),
                            const SizedBox(width: 5),
                          ],
                        ),  
                      ],
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // By default show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}