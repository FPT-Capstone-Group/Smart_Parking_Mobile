import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/controller/editProfile_controller.dart';
import 'package:parking_auto/controller/get_current_user.dart';


class MyProFile extends StatefulWidget  {
   const MyProFile({super.key});
   static const routeNamed = '/myProfileScreen';
  @override
  _MyProFile createState() => _MyProFile();
}

class _MyProFile extends State<MyProFile> {
  final getUserController = Get.put(GetUserController());
  //GetUserController user = Get.find();
  EditProfileController editProfileController = EditProfileController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final getUserController = Get.put(GetUserController());
    // fullNameController.text = loginController.fullName;
    // phoneNumberController.text = loginController.phoneNumber;

    // editProfileController.fullName.text = logincontroller.phoneNumberController.toString();
    // editProfileController.phoneNumberController.text = logincontroller.fullName.toString();

    return Scaffold(
       appBar: AppBar(title: Text("Edit Profile"), 
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: [ 
          TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Full Name',
                  hintText: 'Enter your fullName',
                ),
                keyboardType: TextInputType.text,
                validator: (firstNameController) {
                  if (firstNameController == null || firstNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
          const SizedBox(
            height: 10,
          ),
       
          const SizedBox(
            height: 10,
          ),
          TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Phone number',
                  //hintText: 'Enter your phone',
                ),
                keyboardType: TextInputType.number,
                validator: (phoneController) {
                String pattern = r'(^(?:[0])?[0-9]{10,12}$)';
                RegExp regExp = new RegExp(pattern);
                if (phoneController == null || phoneController.isEmpty) {
                  return 'Can\'t be empty';
                }
                if (!regExp.hasMatch(phoneController)) {
                  return 'Phone number must be number and length 10 to 12';
                }
                return null;
              },
              ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              editProfileController.fullNameController = fullNameController;
              editProfileController.phoneNumberController = phoneNumberController;
             print("fullname");
              print(fullNameController);
             editProfileController.updateUser();
            },
            child: Text('update data'),
          ),
          const SizedBox(
            height: 10,
          ),
        ])
        ,
      ),
    );
  }
}