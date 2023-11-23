// import 'package:flutter/material.dart';
// import 'package:parking_auto/controller/get_registraion_controller.dart';
// import 'package:parking_auto/model/reistraion_model.dart';

// class BikeOfUser extends StatelessWidget {
//   const BikeOfUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Bike Of User'),
//         ),
//         body: const _BikeOfUser());
//   }
// }

// class _BikeOfUser extends StatefulWidget {
//   const _BikeOfUser({super.key});

//   @override
//   State<_BikeOfUser> createState() => __BikeOfUser();
// }

// class __BikeOfUser extends State<_BikeOfUser> {
//   GetRegistraionController getData = GetRegistraionController();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Data>>(
//       future: getData.fetchData(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   height: 75,
//                   color: Colors.white,
//                   child: Card(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         //Text(snapshot.data![index].title),
//                         Row(
//                           //mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             Text('Plate number: ' + snapshot.data![index].title),
//                             TextButton(
//                               child: const Text('See'),
//                               onPressed: () {/* ... */},
//                             ),
//                             const SizedBox(width: 5),
//                           ],
//                         ),  
//                       ],
//                     ),
//                   ),
//                 );
//               });
//         } else if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         }
//         // By default show a loading spinner.
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
