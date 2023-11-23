import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/regisUser.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  String? phoneCurrent;
  @override
  void initState() {
    super.initState();
    _loadPhoneCurrent();
  }

  _loadPhoneCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneCurrent = prefs.getString('phoneCurrent');
      if (phoneCurrent == null) {
        phoneCurrent = '';
      }
      logincontroller.phoneNumberController.text = phoneCurrent.toString();
    });
  }

  TextEditingController otpController = TextEditingController();
  LoginController logincontroller = LoginController();
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: logincontroller.phoneNumberController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelText: 'Phone number',
                hintText: 'Enter your phone',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: logincontroller.passwordController,
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
            ),
            ElevatedButton(
                onPressed: () {
                  //logincontroller.phoneNumberController = phoneCurrent;
                  logincontroller.loginUser(context);
                },
                child: Text("Login")),
            Text('If you have account, please click "Login" button'),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisU(),
                ));
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
