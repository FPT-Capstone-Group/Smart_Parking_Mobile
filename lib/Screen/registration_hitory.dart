import 'package:flutter/material.dart';
import 'package:parking_auto/controller/get_data_controller.dart';
import 'package:parking_auto/model/reistraion_model.dart';

class RegistrationHistory extends StatelessWidget {
  const RegistrationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration History'),
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
                            TextButton(
                              child: const Text('Detail'),
                              onPressed: () {/* ... */},
                            ),
                            const SizedBox(width: 5),
                            TextButton(
                              child: const Text('Delete'),
                              onPressed: () {/* ... */},
                            ),
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
