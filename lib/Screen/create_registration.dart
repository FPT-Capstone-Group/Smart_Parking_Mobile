import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/controller/addOwner_controller.dart';
import 'package:parking_auto/controller/registration_controller.dart';

const List<String> list = <String>['One Month', 'One Year'];
const List<String> gender = <String>['Male', 'Female'];

class Registration extends StatelessWidget {
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
  final registrationForm = GlobalKey<FormState>();
  final addOnwerController = Get.put(AddOwnerController());

  TextEditingController plateNumberController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();

  bool relationship = false;
  String dropdownFee = list.first;
  String dropdownGender = gender.first;

  RegistrationController registration = RegistrationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Registration"), backgroundColor: Colors.redAccent),
        body: Form(
            key: registrationForm,
            // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            // alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 5),
                Divider(color: Colors.white70),
                Text(
                  'User infor',
                  textAlign: TextAlign.left,
                ),
                TextFormField(
                  controller: registrationNumberController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: "Driver's license",
                    hintText: "Enter your Driver's license",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (fullNameController) {
                    if (fullNameController == null ||
                        fullNameController.isEmpty) {
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
                  keyboardType: TextInputType.text,
                  validator: (plateNumberController) {
                    if (plateNumberController == null ||
                        plateNumberController.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (plateNumberController.length < 5) {
                      return 'Too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                //Divider(color: Colors.white70),
                TextFormField(
                  controller: manufactureController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Manufacture',
                    hintText: 'Enter manufacture',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (descriptionController) {
                    if (descriptionController == null ||
                        descriptionController.isEmpty) {
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
                    labelText: 'Model',
                    hintText: 'Enter model ',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (modelBikeController) {
                    if (modelBikeController == null ||
                        modelBikeController.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                //Divider(color: Colors.white70),
                //---------dropdownButton value------
                DropdownButton<String>(
                  value: dropdownFee,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownFee = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //---------dropdownButton value------
                DropdownButton<String>(
                  value: dropdownGender,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownGender = value!;
                    });
                  },
                  items: gender.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                //---------dropdownButton value------
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      registration.dropFee                        = dropdownFee;
                      registration.dropGender                     = dropdownGender;
                      registration.plateNumberController          = plateNumberController;
                      registration.manufactureController          = manufactureController;
                      registration.modelBikeController            = modelBikeController;
                      registration.registrationNumberController    =registrationNumberController;

                      registration.create(context);
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )
                      ),
                      style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
              
                    ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                     child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Home",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )
                      ),
                      style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
              ),
              ],
            ))));
  }
}
