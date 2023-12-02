
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/login_controller.dart';


class OtpPhone extends StatefulWidget {
  const OtpPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<OtpPhone> {
  TextEditingController phoneController = TextEditingController(text: "+84867698543");
  //TextEditingController passwordController = TextEditingController(text: "***");
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  LoginController logincontroller = LoginController();

  bool otpVisibility = false;
  bool passwordVisibility = true;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otp Phone Number"),
         centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
            //  keyboardType: TextInputType.phone,
            ),

            Visibility(child: TextField(
              controller: otpController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),visible: otpVisibility,),

            SizedBox(
              height: 10,
            ),
            // Visibility(child: TextField(
            //   obscureText: true,
            //   controller: passwordController,
            //   decoration: InputDecoration(labelText: "Password"),
            //   keyboardType: TextInputType.visiblePassword,
            // ),visible: passwordVisibility,),

            ElevatedButton(
                onPressed: () {

                  if(otpVisibility){
                    verifyOTP();
                  }
                  else {
                   
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // passwordVisibility = false;
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
      );
  }

  void verifyOTP() async {

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
    await auth.signInWithCredential(credential).then((value){
    //  AuthController.loginUser(phoneController,passwordController);
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "Phone otp successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,  
          textColor: Colors.white,
          fontSize: 16.0
      );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
    });
  }
}