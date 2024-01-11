import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/addOwner_controller.dart';
import 'package:parking_auto/controller/registration_controller.dart';


class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});
  //final String urlImage;

  @override
  State<CreateOrder> createState() => _CreateOrder();
}

class _CreateOrder extends State<CreateOrder> {
  final registrationForm = GlobalKey<FormState>();
  final addOnwerController = Get.put(AddOwnerController());

  TextEditingController plateNumberController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();

  bool relationship = false;


  RegistrationController registration = RegistrationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Create Order'),
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
                  'User infor',
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
                    if (plateNumberController.length < 2) {
                      return 'Too short';
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

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                  
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
