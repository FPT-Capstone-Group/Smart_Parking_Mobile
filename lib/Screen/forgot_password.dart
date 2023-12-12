
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/forgotPassword.controller.dart';
import 'package:parking_auto/controller/sendOtp_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  static const routeNamed = '/forgotPasswordScreen';
  //const RegisterAccountScreen({Key? key}) : super(key: key);

  @override
  _RegisU createState() => _RegisU();
}

class _RegisU extends State<ForgotPassword> {
  final registerForm = GlobalKey<FormState>();
  final login = Get.put(LoginWithPhone());

  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  SendOtpController sendOtp = SendOtpController();
  ForgotPasswordController forgotPassword = ForgotPasswordController();


  bool showpassword = false;
  bool otpVisibility = false;
  bool verify = false;
  bool submitButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
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
                  return 'Phone number must be number and length 10 to 11 and format 0********';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            
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
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
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
                height: 10,
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
             SizedBox(
              height: 10,
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
               //  sendOtp.sendOtp();
                // otpVisibility= true;
                },
                child: const SizedBox(
                  height: 25,
                    width: double.infinity,
                    child: Text(
                      "Send Otp",
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
              height: 5,
            ),
             Visibility(
              child: ElevatedButton(
                onPressed: () {
                    if (registerForm.currentState!.validate()) {
                  forgotPassword.phoneController = phoneController;
                  forgotPassword.passwordController= passwordController;
                  forgotPassword.otpController = otpController;
                  forgotPassword.forgotPassword();
                    }
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Verify",
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
              visible: verify,
            ),
         
            SizedBox(
              height: 5,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       child: const Text("Already have an account?"),
            //       padding: const EdgeInsets.symmetric(vertical: 8),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (context) => LoginWithPhone()));
            //       },
            //       child: Container(
            //         child: const Text(
            //           " Sign in",
            //           style: TextStyle(
            //               color: Colors.blue, fontWeight: FontWeight.bold),
            //         ),
            //         padding: const EdgeInsets.symmetric(vertical: 8),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
  }

