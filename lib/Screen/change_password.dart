
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/create_account_controller.dart';
import 'package:parking_auto/controller/sendOtp_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const routeNamed = '/changePasswordScreen';
  //const RegisterAccountScreen({Key? key}) : super(key: key);

  @override
  _RegisU createState() => _RegisU();
}

class _RegisU extends State<ChangePassword> {
  final registerForm = GlobalKey<FormState>();
  final login = Get.put(LoginWithPhone());

  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  SendOtpController sendOtp = SendOtpController();
  CreateAccountController createAccount = CreateAccountController();


  bool showpassword = false;
  bool otpVisibility = false;
  bool verify = false;
  bool submitButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send otp"),
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
                  createAccount.phoneController = phoneController;
                  createAccount.fullNameController = fullNameController;
                  createAccount.passwordController= passwordController;
                  createAccount.otpController = otpController;
                  createAccount.createAccount();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Already have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginWithPhone()));
                  },
                  child: Container(
                    child: const Text(
                      " Sign in",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  }

