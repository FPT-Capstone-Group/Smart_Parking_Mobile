import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/register_account.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:parking_auto/controller/register_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithPhone extends StatefulWidget {
  static const routeNamed = '/loginScreen';
  //const LoginWithPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final logincontroller = Get.put(LoginController());
  final registerController = Get.put(RegisterController());
  String? phoneCurrent;
  //var fullName;
  @override
  void initState() {
    super.initState();
    _loadPhoneCurrent();
  }

  _loadPhoneCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneCurrent = registerController.phoneController.text;
      if (phoneCurrent == null || phoneCurrent =='') {
        phoneCurrent = prefs.getString("phoneCurrent"); 
      }
      if (phoneCurrent == null) {
        phoneCurrent = '';
      }
      logincontroller.phoneNumberController.text = phoneCurrent.toString();
      logincontroller.passwordController.text = "";
      // fullName = prefs.getString("fullName"); 
      // if(fullName == null){
      //   fullName = " ";
      // }
    });
  }

  TextEditingController otpController = TextEditingController();

  bool passwordVisibility = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
     
      body: Form(
      key: _formKey,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
         // Text("Hello " + fullName.toString(),),
          TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelText: 'Phone number',
                hintText: 'Enter your phone',
              ),
              validator: (phoneController) {
                String pattern = r'(^(?:[0])?[0-9]{10,11}$)';
                RegExp regExp = new RegExp(pattern);
                if (phoneController == null || phoneController.isEmpty) {
                  return 'Can\'t be empty';
                }
                if (!regExp.hasMatch(phoneController)) {
                  return 'Phone number must be number and length 10 to 11';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),


          TextFormField(
            keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText:!passwordVisibility, //This will obscure text dynamically
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password',
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisibility
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisibility = !passwordVisibility;
                    });
                  },
                ),
              ),
            validator: (passwordController) {
              if (passwordController == null || passwordController.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  logincontroller.phoneNumberController = phoneNumberController;
                  logincontroller.passwordController = passwordController;
                 print("phone login controller");
                print(phoneNumberController.text);
                  logincontroller.loginUser();
                 //Get.to(RegisterAccountScreen()); 
                }
              },
              child: const Text('Submit'),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Already have no account?"),
                 // padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(RegisterAccountScreen());
                  },
                  child: Container(
                    child: const Text(
                      "Register account",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            ),
        ],
      ),
      
    ),
    


    );
  }
}
