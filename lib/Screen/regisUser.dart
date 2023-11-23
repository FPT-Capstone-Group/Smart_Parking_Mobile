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
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
  bool loginButtonVisible = true;
  bool textVisible = false;
  bool sendOtpAgainButtonVisible = false;

  bool showpassword = false;

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
                String pattern = r'(^(?:[0])?[0-9]{10,12}$)';
                RegExp regExp = new RegExp(pattern);
                if (phoneController == null || phoneController.isEmpty) {
                  return 'Can\'t be empty';
                }
                if (!regExp.hasMatch(phoneController)) {
                  return 'Phone number must be number and length 10 to 12';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'FirstName',
                  hintText: 'Enter your firstName',
                ),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (firstNameController) {
                  if (firstNameController == null || firstNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
              visible: firstNameVisible,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'LastName',
                  hintText: 'Enter your lastName',
                ),
                keyboardType: TextInputType.text,
                validator: (lastNameController) {
                  if (lastNameController == null || lastNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
              visible: lastNameVisible,
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: !showpassword, //This will obscure text dynamically
                validator: (passwordController) {
                  if (passwordController == null || passwordController.isEmpty) {
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
              visible: passwordVisibility,
            ),
            SizedBox(
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
                validator: (otpController) {
                  if (otpController == null || otpController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
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
            SizedBox(
              height: 5,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    loginWithPhone();
                  },
                  child: Text("Send Otp Again")),
              visible: sendOtpAgainButtonVisible,
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    verifyOTP();
                  },
                  child: Text("Verify")),
              visible: verifyButtonVisible,
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
              child: ElevatedButton(
                  onPressed: () {
                    registerController.firstNameController = firstNameController;
                    registerController.lastNameController = lastNameController;
                    registerController.phoneController = phoneController;
                    registerController.passwordController = passwordController;
                    registerController.registerUser(context);
                  },
                  child: Text("Register")),
              visible: registerButtonVisible,
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

  void loginWithPhone() async {
    //auth.setSettings(appVerificationDisabledForTesting: true);
    auth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneController.text,
      // verificationCompleted: (PhoneAuthCredential credential) async {
      //   await auth.signInWithCredential(credential).then((value) {
      //   });
      // },

      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(
              msg: "The provided phone number is not valid",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
