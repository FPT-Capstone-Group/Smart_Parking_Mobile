import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parking_auto/Screen/login.dart';
import 'package:parking_auto/controller/register_controller.dart';

class RegisU extends StatefulWidget {
  const RegisU({Key? key}) : super(key: key);

  @override
  _RegisU createState() => _RegisU();
}

class _RegisU extends State<RegisU> {
  var countryCode = "+84";
  //TextEditingController phoneController = TextEditingController(text: "+84867698543");
  TextEditingController phoneController =
      TextEditingController(text: "0867698543");
  TextEditingController firstController =
      TextEditingController(text: "First Name");
  TextEditingController lastController =
      TextEditingController(text: "Last Name");
  TextEditingController passwordController = TextEditingController(text: "***");

  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  RegisterController registerController = RegisterController();

  bool otpVisibility = false;
  bool passwordVisibility = false;
  bool firstNameVisible = false;
  bool lastNameVisible = false;
  bool sendOtpButtonVisible = true;
  bool verifyButtonVisible = false;
  bool registerButtonVisible = false;
  bool loginButtonVisible = false;
  bool textVisible = false;
  bool sendOtpAgainButtonVisible = false;

  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.number,
            ),
            Visibility(
              child: TextField(
                controller: firstController,
                decoration: InputDecoration(labelText: "FirstName"),
                keyboardType: TextInputType.text,
              ),
              visible: firstNameVisible,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextField(
                controller: lastController,
                decoration: InputDecoration(labelText: "LastName"),
                keyboardType: TextInputType.text,
              ),
              visible: lastNameVisible,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.text,
              ),
              visible: passwordVisibility,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(),
                keyboardType: TextInputType.number,
              ),
              visible: otpVisibility,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    loginWithPhone();
                  },
                  child: Text("send Otp")),
              visible: sendOtpButtonVisible,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    loginWithPhone();
                  },
                  child: Text("Send Otp Again")),
              visible: sendOtpAgainButtonVisible,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    verifyOTP();
                  },
                  child: Text("Verify")),
              visible: verifyButtonVisible,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    registerController.firstNameController = firstController;
                    registerController.lastNameController = lastController;
                    registerController.phoneController = phoneController;
                    registerController.passwordController = passwordController;

                    registerController.registerUser(context);
                  },
                  child: Text("Register")),
              visible: registerButtonVisible,
            ),
            Visibility(
              child: Text('Click "Login" button if you have account'),
              visible: registerButtonVisible,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginWithPhone()));
                  },
                  child: Text("Login")),
              visible: loginButtonVisible,
            ),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
          print("coutry code:" +
              countryCode +
              ", " +
              "phone number:" +
              phoneController.text);
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // passwordVisibility = false;
        otpVisibility = true;
        sendOtpButtonVisible = false;
        verifyButtonVisible = true;
        sendOtpAgainButtonVisible = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      otpVisibility = false;
      passwordVisibility = true;
      firstNameVisible = true;
      lastNameVisible = true;
      sendOtpButtonVisible = false;
      sendOtpAgainButtonVisible = false;
      verifyButtonVisible = false;
      registerButtonVisible = true;
      loginButtonVisible = true;
      textVisible = true;
      setState(() {});

      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithPhone()));
      print("You are logged in successfully");
      Fluttertoast.showToast(
          msg: "Phone otp successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
