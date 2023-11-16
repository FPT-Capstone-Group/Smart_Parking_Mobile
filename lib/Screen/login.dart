
import 'package:flutter/material.dart';
import 'package:parking_auto/controller/login_controller.dart';


class LoginWithPhone extends StatefulWidget  {
 
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone>  {

  // TextEditingController phoneController = TextEditingController(text: "+84867698543");
  // TextEditingController passwordController = TextEditingController(text: "***");
  TextEditingController otpController = TextEditingController();



  LoginController logincontroller = LoginController();

  bool passwordVisibility = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: logincontroller.phoneNumberController,
              decoration: InputDecoration(labelText: "Phone number"),
            //  keyboardType: TextInputType.phone,
            ),

            SizedBox(
              height: 10,
            ),
            Visibility(child: TextField(
              obscureText: true,
              controller: logincontroller.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              keyboardType: TextInputType.visiblePassword,
            ),visible: passwordVisibility,),

            ElevatedButton(
                onPressed: () {

                    logincontroller.loginUser(context);
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }

  
}