import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/controller/editProfile_controller.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> gender = <String>['Male', 'Female'];
class EditProFileScreen extends StatefulWidget {
  const EditProFileScreen({super.key});
  static const routeNamed = '/editProfileScreen';
  @override
  _EditProFile createState() => _EditProFile();
}

class _EditProFile extends State<EditProFileScreen> {
  final editProfileKey = GlobalKey<FormState>();
  LoginController loginController = Get.find();
  final getUser = Get.put(LoginController());
  EditProfileController editProfileController = EditProfileController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String dropdownGender = gender.first;
  String? fullNameCurrentSavedShared;
  String? phoneCurrentSavedShared;
  bool phoneEdit = true;
  @override
  void initState() {
    super.initState();
    _loadPhoneCurrent();
  }

  _loadPhoneCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var ageUser = prefs.getString("ageUser");
      if (ageUser == null) {
        ageController.text = "";
        
      }else{
        ageController.text = ageUser.toString();
      }
       var genderUser = prefs.getString("genderUser");
      if (genderUser == "Male") {
        dropdownGender = gender.first;
      }else{
        dropdownGender = gender.last;
      }
      var address = prefs.getString("addressUser");
      if (address == null) {
        addressController.text = "";
      }else{
        addressController.text = address;
      }

      ageController.text = phoneCurrentSavedShared.toString();

      fullNameCurrentSavedShared = prefs.getString("fullName");
      if (fullNameCurrentSavedShared == null) {
        fullNameCurrentSavedShared = "";
      }
      fullNameController.text = fullNameCurrentSavedShared.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
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
            validator: (fullNameController) {
              if (fullNameController == null || fullNameController.isEmpty) {
                return 'Can\'t be empty';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
           TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              labelText: 'Age',
              hintText: 'Enter your age',
            ),
            keyboardType: TextInputType.number,
          validator: (ageController) {
                   String pattern = r'^[0-9]{1,2}$';
                RegExp regExp = new RegExp(pattern);
                  if (ageController == null ||
                      ageController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                   if (!regExp.hasMatch(ageController)) {
                  return 'Age must be number and length 1 to 2 character';
                }
                  return null;
                },
          ),
            const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              labelText: 'Full Address',
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
          const SizedBox(
            height: 10,
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

          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: raisedButtonStyle,
            onPressed: () {
              editProfileController.fullNameController = fullNameController;
              editProfileController.addressController = addressController;
              editProfileController.ageController = ageController;
              editProfileController.dropGender = dropdownGender;
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
