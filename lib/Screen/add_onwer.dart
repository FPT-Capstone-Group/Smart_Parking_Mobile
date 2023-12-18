import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/addOwner_controller.dart';

const List<String> gender = <String>['Male', 'Female'];

class RegistrationOnwer extends StatefulWidget {
  static const routeNamed = '/registrationOwnerScreen';
  @override
  _RegistrationOnwer createState() => _RegistrationOnwer();
}

class _RegistrationOnwer extends State<RegistrationOnwer> {
  final registrationOwnerForm = GlobalKey<FormState>();
  final addOnwerController = Get.put(AddOwnerController());

  TextEditingController genderController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();

  String dropdownGender = gender.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Registration Owner'),
            leading: IconButton(
              onPressed: () {
                Get.to(HomeNavBar());
              },
              icon: const Icon(Icons.home),
            ),
            // actions: [
            //   Icon(Icons.create)
            // ],
            backgroundColor: Colors.redAccent),
        body: Form(
            key: registrationOwnerForm,
            // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            // alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 5),
                const Divider(color: Colors.white70),
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
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
                    if (plateNumberController.length < 5) {
                      return 'Too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                //Divider(color: Colors.white70),
                TextFormField(
                  controller: relationshipController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Relationship',
                    hintText: 'Enter relationship',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (relationshipController) {
                    if (relationshipController == null ||
                        relationshipController.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                ),

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

                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (registrationOwnerForm.currentState!.validate()) {
                        addOnwerController.dropGender = dropdownGender;
                        addOnwerController.fullNameController =
                            fullNameController;
                        addOnwerController.plateNumberController =
                            plateNumberController;
                        addOnwerController.relationshipController =
                            relationshipController;

                        addOnwerController.addOwner();
                      }
                    },
                    child: const Text("Submit")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeNavBar()));
                    },
                    child: const Text("Home")),
              ],
            ))));
  }
}
