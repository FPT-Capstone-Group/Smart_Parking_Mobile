import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/addOwner_controller.dart';
import 'package:parking_auto/controller/registration_controller.dart';

//const List<String> list = <String>['One Month', 'One Year'];
const List<String> gender = <String>['Male', 'Female'];

class Registration extends StatefulWidget {
  const Registration({super.key});
  //final String urlImage;

  @override
  State<Registration> createState() => _Registration();
}

class _Registration extends State<Registration> {
  final registrationForm = GlobalKey<FormState>();
  final addOnwerController = Get.put(AddOwnerController());

  TextEditingController plateNumberController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();

  bool relationship = false;
  //String dropdownFee = list.first;
  String dropdownGender = gender.first;

  RegistrationController registration = RegistrationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Registration'),
            leading: IconButton(
              onPressed: () {
                Get.to(HomeNavBar());
              },
              icon: const Icon(Icons.home),
            ),
            actions:const [Icon(Icons.create)],
            backgroundColor: Colors.redAccent),
        body: Form(
            key: registrationForm,
            // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            // alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 5),
                const Divider(color: Colors.white70),
                const Text(
                  'Bike infor',
                  textAlign: TextAlign.left,
                ),
                TextFormField(
                  controller: registrationNumberController,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                    if (plateNumberController.length < 6) {
                      return 'Too short';
                    }
                    if (plateNumberController.length >10) {
                      return 'Too long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                //Divider(color: Colors.white70),
                TextFormField(
                  controller: manufactureController,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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

                // DropdownButton<String>(
                //   value: dropdownGender,
                //   icon: const Icon(Icons.arrow_downward),
                //   elevation: 16,
                //   style: const TextStyle(color: Colors.deepPurple),
                //   underline: Container(
                //     height: 2,
                //     color: Colors.deepPurpleAccent,
                //   ),
                //   onChanged: (String? value) {
                //     // This is called when the user selects an item.
                //     setState(() {
                //       dropdownGender = value!;
                //     });
                //   },
                //   items: gender.map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                //---------dropdownButton value------
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                       if (registrationForm.currentState!.validate()) {
                   // registration.dropGender = dropdownGender;
                    registration.plateNumberController = plateNumberController;
                    registration.manufactureController = manufactureController;
                    registration.modelBikeController = modelBikeController;
                    registration.registrationNumberController =
                        registrationNumberController;

                    registration.create(context);
                       }
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
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
