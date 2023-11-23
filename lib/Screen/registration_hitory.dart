import 'package:flutter/material.dart';
import 'package:parking_auto/controller/get_registraion_controller.dart';

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
  GetRegistraionController getData = GetRegistraionController();

    @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Registration history'),
          centerTitle: true,
          backgroundColor: Colors.green,
          
        ),
        
      );
}