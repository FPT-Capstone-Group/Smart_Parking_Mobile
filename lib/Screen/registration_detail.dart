import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/home.dart';

class RegistrationDetail extends StatelessWidget  {
 const RegistrationDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _RegistrationDetail(),
      
    );
  }
}

class _RegistrationDetail extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_RegistrationDetail> {
  

  // XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Registration Detail"),
            backgroundColor: Colors.redAccent),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
               const SizedBox(height: 16),
                Divider(color: Colors.white70),
                Text(
                    'User infor',textAlign: TextAlign.left,
                  ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "Name"),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                 Divider(color: Colors.white70),
                 Text(
                    'Vehicle infor',textAlign: TextAlign.left,
                  ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "License plates"),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.phone,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text("Home")),
              ],
            )
            )
            );
  }
}