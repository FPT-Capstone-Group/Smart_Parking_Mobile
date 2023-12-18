
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/create_account_controller.dart';
import 'package:parking_auto/controller/sendOtp_controller.dart';

const List<String> gender = <String>['Male', 'Female'];
class CreateAccount extends StatefulWidget {
  static const routeNamed = '/createAccountScreen';
  const CreateAccount({super.key});

  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  final registerForm = GlobalKey<FormState>();
  final login = Get.put(LoginWithPhone());

  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String dropdownGender = gender.first;
  bool showpassword = false;
  bool otpVisibility = false;
  bool verify = false;
  bool submitButton = true;

  SendOtpController sendOtp = SendOtpController();
  CreateAccountController createAccount = CreateAccountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
         centerTitle: true,
      ),
      body: Form(
        key: registerForm,
        //margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelText: 'Phone Number',
                hintText: 'Enter your phone',
              ),
              keyboardType: TextInputType.number,
              // validate after each user interaction
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // The validator receives the text that the user has entered.
              validator: (phoneController) {
                String pattern = r'^0[0-9]{9,10}$';
                RegExp regExp = new RegExp(pattern);
                if (phoneController == null || phoneController.isEmpty) {
                  return 'Can\'t be empty';
                }
                if (!regExp.hasMatch(phoneController)) {
                  return 'Phone number must be number and length 10 to 11 and start by 0';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'FullName',
                  hintText: 'Enter your FullName',
                ),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (firstNameController) {
                  if (firstNameController == null ||
                      firstNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
               const SizedBox(
              height: 5,
            ),
            //  TextFormField(
            //     controller: ageController,
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(),
            //       focusedBorder: OutlineInputBorder(),
            //       labelText: 'Age',
            //       hintText: 'Enter your age',
            //     ),
            //     keyboardType: TextInputType.number,
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     validator: (ageController) {
            //        String pattern = r'^[0-9]{1,2}$';
            //     RegExp regExp = new RegExp(pattern);
            //       if (ageController == null ||
            //           ageController.isEmpty) {
            //         return 'Can\'t be empty';
            //       }
            //        if (!regExp.hasMatch(ageController)) {
            //       return 'Age must be number and length 1 to 2 character';
            //     }
            //       return null;
            //     },
            //   ),
            //    const SizedBox(
            //   height: 10,
            // ),
            //  TextFormField(
            //     controller: addressController,
            //     decoration: InputDecoration(
            //       enabledBorder: OutlineInputBorder(),
            //       focusedBorder: OutlineInputBorder(),
            //       labelText: 'Address',
            //       hintText: 'Enter your address',
            //     ),
            //     keyboardType: TextInputType.text,
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     validator: (firstNameController) {
            //       if (firstNameController == null ||
            //           firstNameController.isEmpty) {
            //         return 'Can\'t be empty';
            //       }
            //       return null;
            //     },
            //   ),
            //    const SizedBox(
            //   height: 5,
            // ),
            //  DropdownButton<String>(
              
            //       value: dropdownGender,
            //       icon: const Icon(Icons.arrow_downward),
            //       elevation: 16,
            //       style: const TextStyle(color: Colors.deepPurple),
            //       underline: Container(
            //         height: 2,
            //         color: Colors.deepPurpleAccent,
            //       ),
            //       onChanged: (String? value) {
            //         // This is called when the user selects an item.
            //         setState(() {
            //           dropdownGender = value!;
            //         });
            //       },
            //       items: gender.map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //     ),
                 const SizedBox(
              height: 5,),
            TextFormField(
                keyboardType: TextInputType.number,
                controller: passwordController,
                obscureText: !showpassword, //This will obscure text dynamically
                validator: (passwordController) {
                  if (passwordController == null ||
                      passwordController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      showpassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        showpassword = !showpassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
               Visibility(
              child: TextFormField(
                controller: otpController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Otp',
                  hintText: 'Enter your otp number',
                ),
                keyboardType: TextInputType.number,
                // validator: (otpController) {
                //   if (otpController == null || otpController.isEmpty) {
                //     return 'Can\'t be empty';
                //   }
                //   return null;
                // },
              ),
              visible: otpVisibility,
            ),
           const SizedBox(
              height: 5,
            ),
           Visibility(
              child: ElevatedButton(
                onPressed: () {
                  sendOtp.phoneNumberController = phoneController;
                  otpVisibility= true;
                  verify= true;
                  submitButton = false;

                  setState(() {
                    
                  });
                  sendOtp.sendOtp();
              
                },
                child: const SizedBox(
                  height: 20,
                    width: double.infinity,
                    child: Text(
                      "Send Otp",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
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
              height: 5,
            ),
             Visibility(
              child: ElevatedButton(
                onPressed: () {
                    if (registerForm.currentState!.validate()) {

                  createAccount.phoneController     = phoneController;
                  createAccount.fullNameController  = fullNameController;
                  createAccount.ageController       = ageController;
                  createAccount.addressController   =addressController;
                  createAccount.passwordController  = passwordController;
                  createAccount.otpController       = otpController;
                  createAccount.dropGender          = dropdownGender;
                  createAccount.createAccount();

                    }
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Verify",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    )),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              visible: verify,
            ),
         
          ],
        ),
      ),
    );
  }
  }

