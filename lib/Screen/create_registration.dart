import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/controller/addOwner_controller.dart';
import 'package:parking_auto/controller/registration_controller.dart';

const List<String> list = <String>['One Month', 'One Year'];

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
  dynamic argumentData = Get.arguments;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  bool relationship = false;
  String dropdownValue = list.first;

  RegistrationBike registrationBike = RegistrationBike();

  @override
  void initState() {
    super.initState();
    if (argumentData[0]['type'] == "addOwner") {
      relationship = true;
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Registration"), backgroundColor: Colors.redAccent),
        body:  Form(
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
                  controller: fullNameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
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
                  controller: descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Description',
                    hintText: 'Enter description',
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
                    labelText: 'Model bike',
                    hintText: 'Enter model bike',
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

                Visibility(
                  child: TextFormField(
                    controller: relationshipController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Otp',
                      hintText: 'Enter your otp number',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (otpController) {
                      if (otpController == null || otpController.isEmpty) {
                        return 'Can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  visible: relationship,
                ),

                //Divider(color: Colors.white70),
                //---------dropdownButton value------
                DropdownButton<String>(
                  value: dropdownValue,
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
                      dropdownValue = value!;
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
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (argumentData[0]['type'] == "addOwner") {
                        addOnwerController.dropValue = dropdownValue;
                        addOnwerController.plateNumberController = plateNumberController;

                        addOnwerController.addOwner();
                      } else {
                        registrationBike.dropValue = dropdownValue;
                        registrationBike.plateNumberController = plateNumberController;

                        registrationBike.registrion(context);
                      }
                      // registrationBike.dropValue = dropdownValue;
                      // registrationBike.plateNumberController = plateNumberController;

                      // registrationBike.registrion(context);
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
