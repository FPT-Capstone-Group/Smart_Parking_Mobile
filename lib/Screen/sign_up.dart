import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/login_with_phone.dart';

class Sign_up_Page extends StatelessWidget {
  const Sign_up_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AuthController authController = AuthController();

   TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Phone',
               
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                //controller: authController.passwordController,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          ElevatedButton(
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginWithPhone(),
        ));
               // authController.loginUser();
              },
              child: Text(
                'Sign up',
              )),
              Text('If you have account, please click "Login" button'),
              TextButton(
             onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginWithPhone(),
        ));
               // authController.loginUser();
              },
              child: const Text('Login'),
            ),
        ],
      ),
    );
  }
}