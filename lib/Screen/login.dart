import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/create_account.dart';
import 'package:parking_auto/Screen/forgotPassword.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithPhone extends StatefulWidget {
  static const routeNamed = '/loginScreen';
  const LoginWithPhone({super.key});

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  // dynamic argumentData = Get.arguments;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final logincontroller = Get.put(LoginController());
  var phoneRegisterCurrent;
  var phoneCurrent;
  var phoneCurrentSavedShared;
  //var fullName;
  bool showpassword = false;
  @override
  void initState() {
    super.initState();
    _loadPhoneCurrent();
  }

  _loadPhoneCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneCurrentSavedShared = prefs.getString("phoneCurrent");

      phoneRegisterCurrent = prefs.getString("phoneCurrentRegister");

      if (phoneCurrentSavedShared == null && phoneRegisterCurrent == null) {
        phoneNumberController.text = "";
      }
      if (phoneCurrentSavedShared == null && phoneRegisterCurrent != null) {
        phoneNumberController.text = phoneRegisterCurrent.toString();
      }
      if (phoneCurrentSavedShared != null && phoneRegisterCurrent == null) {
        phoneNumberController.text = phoneCurrentSavedShared.toString();
      }
      if (phoneCurrentSavedShared != null && phoneRegisterCurrent != null) {
        phoneNumberController.text = phoneRegisterCurrent.toString();
      }
    });
  }

  TextEditingController otpController = TextEditingController();

  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ClipOval(
              child: Image.asset(
                'assets/logo.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),

            // new Image.asset(
            //   'assets/logo.png',
            //   width: 100.0,
            //   height: 100.0,
            //   fit: BoxFit.cover
            // ),

                    SizedBox(
              height: 50,
            ),
                   // const Divider(),
                    SizedBox(
              height: 30,
            ),
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
               
               String pattern = r'^0[0-9]{9,10}$';
              
                RegExp regExp = RegExp(pattern);

                if (phoneController == null || phoneController.isEmpty) {
                  return 'Can\'t be empty';
                }
                if (!regExp.hasMatch(phoneController)) {
                  return 'Phone number must be number and length 9 to 10 and format 0*********';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            

            TextFormField(
              keyboardType: TextInputType.number,
              controller: passwordController,
              obscureText:
                  !passwordVisibility, //This will obscure text dynamically
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
            GestureDetector(

                  onTap: () {
                    Get.to(ForgotPass());
                  },
                  child: Container(
                    child: const Text(
                      "Forgot password",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child:  FloatingActionButton.extended(
                                onPressed: () {
                                 if (_formKey.currentState!.validate()) {
                    logincontroller.phoneNumberController =
                        phoneNumberController;
                    logincontroller.passwordController = passwordController;

                    logincontroller.loginUser();
                
                  }
                                },
                                icon: Icon(Icons.login),
                                label: Text('Login'),
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
                    Get.to(CreateAccount());
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
