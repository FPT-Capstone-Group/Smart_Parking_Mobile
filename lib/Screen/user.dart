

import 'package:flutter/material.dart';
import 'package:parking_auto/controller/editProfile_controller.dart';
import 'package:parking_auto/controller/get_current_user.dart';
import 'package:parking_auto/model/getUser_model.dart';

//const List<String> gender = <String>['Male', 'Female'];

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User'),
           centerTitle: true,
        ),
        body: const _UserPage());
  }
}

class _UserPage extends StatefulWidget {
  const _UserPage({super.key});

  @override
  State<_UserPage> createState() => __UserPage();
}

class __UserPage extends State<_UserPage> {
  EditProfileController editProfileController = EditProfileController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  //String dropdownGender = gender.first;
  bool showpassword = false;
  bool fullnameVisible = false;
  bool ageVisible = false;
  bool addressVisible = false;
  bool genderVisible = false;
  bool submitButton = true;

  GetUserController getUser = GetUserController();
  List<Data>? listData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final list = listData;
    if (list == null) {
      return Container(
        color: Colors.grey[300],
        child: const Center(child: CircularProgressIndicator()),
      );
    } else {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return InkWell(
          
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bike: ${item.bikeId}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Text(
                    "Full name: ${item.fullname}",
                  ),
                   Text(
                    "Age : ${item.age}",
                  ),
                  Text(
                    "Gender: ${item.gender}",
                  ),
                   Text(
                    "Address: ${item.address}",
                  ),
                  const SizedBox(
                height: 10,
              ),
               Visibility(
              child: TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                ),
                keyboardType: TextInputType.text,
                validator: (fullNameController) {
                  if (fullNameController == null || fullNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
              visible: fullnameVisible,
            ),
             SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Address',
                  hintText: 'Enter your address',
                ),
                keyboardType: TextInputType.text,
                validator: (addressController) {
                  if (addressController == null || addressController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
              visible: addressVisible,
            ),
             SizedBox(
              height: 10,
            ),
             Visibility(
              child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Age',
                  hintText: 'Enter your address',
                ),
                keyboardType: TextInputType.text,
                validator: (ageController) {
                  if (ageController == null || ageController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
              visible: ageVisible,
            ),
             SizedBox(
              height: 10,
            ),

             Visibility(
              child: ElevatedButton(
                onPressed: () {
                
                  fullnameVisible= true;
                  ageVisible= true;
                  addressVisible = true;
                  submitButton = false;
                  
                  setState(() {
                    
                  });
    
                },
                child: const SizedBox(
                  height: 25,
                    width: double.infinity,
                    child: Text(
                      "Edit",
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
               visible: submitButton,
            ),

             SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                           editProfileController.fullNameController = fullNameController;
                            editProfileController.addressController = addressController;
                            editProfileController.ageController = ageController;
                            editProfileController.updateUser();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Update", style: TextStyle(color: Color.fromARGB(255, 118, 255, 64))),
                ),
              ),
             
                ],
              ),
              
            ),
          );
        },
      );
      
    }
  }

  void fetchData() async {
    listData = null;
    if (mounted) setState(() {});
    try {
      final value = await getUser.getUserData();
      listData = value;
    } catch (e) {
      listData = [];
    }
    if (mounted) setState(() {});
  }
}
