import 'package:flutter/material.dart';

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


    @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Bike history'),
          centerTitle: true,
          backgroundColor: Colors.green,
          
        ),
        
      );
}