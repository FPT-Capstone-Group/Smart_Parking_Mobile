import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/controller/editProfile_controller.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProFile extends StatefulWidget  {
   const EditProFile({super.key});
   static const routeNamed = '/editProfileScreen';
  @override
  _EditProFile createState() => _EditProFile();
}

class _EditProFile extends State<EditProFile> {
  final editProfileKey = GlobalKey<FormState>();
  LoginController loginController = Get.find();
  final getUser = Get.put(LoginController());
  EditProfileController editProfileController = EditProfileController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? fullNameCurrentSavedShared;
  String? phoneCurrentSavedShared;
 @override
  void initState() {
    super.initState();
    _loadPhoneCurrent();
  }

  _loadPhoneCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var 
      phoneCurrentSavedShared = prefs.getString("phoneCurrent"); 
      if(phoneCurrentSavedShared == null){
        phoneCurrentSavedShared = "";
      }
       phoneNumberController.text = phoneCurrentSavedShared.toString();
    
    fullNameCurrentSavedShared = prefs.getString("fullName"); 
      if(fullNameCurrentSavedShared == null){
        fullNameCurrentSavedShared = "";
      }
       fullNameController.text = fullNameCurrentSavedShared.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    // fullNameController.text = loginController.fullName;
    // phoneNumberController.text = loginController.phoneNumber;

    // editProfileController.fullName.text = logincontroller.phoneNumberController.toString();
    // editProfileController.phoneNumberController.text = logincontroller.fullName.toString();

    return Scaffold(
       appBar: AppBar(title: Text("Edit Profile"), 
      ),
      body: Form(
      key: editProfileKey,
       // margin: EdgeInsets.all(20),
        child: ListView(children: [ 
          const SizedBox(
            height: 30,
          ),
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
            style: raisedButtonStyle,
            onPressed: () {
              editProfileController.fullNameController = fullNameController;
              editProfileController.phoneNumberController = phoneNumberController;

             editProfileController.updateUser();
            },
            child: Text('Update data'),
          ),
          const SizedBox(
            height: 10,
          ),
        ]
        ),
        
        
      ),
    );
  }
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    maximumSize: Size(88, 36),
  onPrimary: Colors.black87,
  primary: Colors.grey[300],
  minimumSize: Size(88, 36),
  //padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(22)),
  ),
);
}