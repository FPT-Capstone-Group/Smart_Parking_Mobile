import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/sendOtp_controller.dart';
import 'package:parking_auto/controller/user_controller.dart';
import 'package:provider/provider.dart';


class ForgotPass extends StatelessWidget {
  const ForgotPass({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reset Password',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ForgotPassScreen()),
    );
  }
}

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  _ProviderForgotPassScreenScreenState createState() => _ProviderForgotPassScreenScreenState();
}

class _ProviderForgotPassScreenScreenState extends State<ForgotPassScreen> {
 final registerForm = GlobalKey<FormState>();
  //final login = Get.put(LoginWithPhone());

  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  SendOtpController sendOtp = SendOtpController();
  UserController userController = UserController();


  bool showpassword = false;
  bool otpVisibility = false;
  bool verify = false;
  bool submitButton = true;
  @override
  void initState() {
    super.initState();
    // final postModel = Provider.of<UserController>(context, listen: false);
    // postModel.forgotPassword();
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"), leading: IconButton(
    onPressed: () {
      Get.to(LoginWithPhone());
    },
    icon: Icon(Icons.login),)
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
                 sendOtp.sendOtp();
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
                  userController.phoneController = phoneController;
                  userController.passwordController= passwordController;
                  userController.otpController = otpController;
                  userController.forgotPassword();
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
        
          ],
        ),
      ),
    );
  }
}
