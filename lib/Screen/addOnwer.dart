import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/home.dart';
import 'package:parking_auto/controller/addOwner_controller.dart';
const List<String> gender = <String>['Male', 'Female'];

class RegistrationOnwer extends StatelessWidget {
  //final String urlImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _RegistrationOnwer(),
    );
  }
}

class _RegistrationOnwer extends StatefulWidget {
  @override
  __RegistrationOnwer createState() => __RegistrationOnwer();
}

class __RegistrationOnwer extends State<_RegistrationOnwer> {
  final registrationForm = GlobalKey<FormState>();
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
            title: Text("Registration owner"), backgroundColor: Colors.redAccent),
        body:  Form(
        key: registrationForm,
           // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
           // alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 5),
                Divider(color: Colors.white70),
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
                  controller: relationshipController,
                  decoration: InputDecoration(
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

                //  TextFormField(
                //   controller: genderController,
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(),
                //     focusedBorder: OutlineInputBorder(),
                //     labelText: 'Gender',
                //     hintText: 'Enter Gender',
                //   ),
                //   keyboardType: TextInputType.text,
                //   validator: (relationshipController) {
                //     if (relationshipController == null ||
                //         relationshipController.isEmpty) {
                //       return 'Can\'t be empty';
                //     }
                //     return null;
                //   },
                // ),
               
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
                      addOnwerController.dropGender                        = dropdownGender;
                      addOnwerController.fullNameController                = fullNameController;
                      addOnwerController.plateNumberController             = plateNumberController;
                      addOnwerController.relationshipController            =  relationshipController;

                      addOnwerController.addOwner();
       
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
