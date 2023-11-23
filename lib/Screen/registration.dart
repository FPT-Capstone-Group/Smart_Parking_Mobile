import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/controller/registration_controller.dart';

class Registration extends StatelessWidget  {
  
  //final String urlImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Registration(),
      
    );
  }
}

class _Registration extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Registration> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();

  RegistrationBike registrationBike = RegistrationBike();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Registration"),
            backgroundColor: Colors.redAccent),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
            child:Column(
              children: [
               const SizedBox(height: 5),
                Divider(color: Colors.white70),
                Text(
                    'User infor',textAlign: TextAlign.left,
                  ),
                TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                keyboardType: TextInputType.number,
                validator: (fullNameController) {
                  if (fullNameController == null || fullNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 10),
                TextFormField(
                controller: plateNumberController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Plate number',
                  hintText: 'Enter your plate number',
                ),
                keyboardType: TextInputType.number,
                validator: (plateNumberController) {
                  if (plateNumberController == null || plateNumberController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if(plateNumberController.length <5){
                    return 'Too short';
                  }
                  return null;
                },
              ),
                const SizedBox(height: 10),
                 //Divider(color: Colors.white70),
                 TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Enter description',
                ),
                keyboardType: TextInputType.number,
                validator: (descriptionController) {
                  if (descriptionController == null || descriptionController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 10),
                TextFormField(
                controller: modelBikeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Model bike',
                  hintText: 'Enter model bike',
                   
                ),
                keyboardType: TextInputType.number,
                validator: (modelBikeController) {
                  if (modelBikeController == null || modelBikeController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      registrationBike.approvedByController = fullNameController;
                      registrationBike.plateNumberController = plateNumberController;
                      print(registrationBike.approvedByController);
                        print(registrationBike.plateNumberController);
                      registrationBike.registrion();
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
        )
            );
  }
}
  