import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/otp_phone.dart';
import 'package:parking_auto/controller/register_controller.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUser createState() => _RegisterUser();
}

class _RegisterUser extends State<RegisterUser> {
  @override
  Widget build(BuildContext context) {
    RegisterController registerController = RegisterController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                controller: registerController.firstNameController,
                decoration: InputDecoration(
                  hintText: 'firstName',
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
                controller: registerController.lastNameController,
                decoration: InputDecoration(
                  hintText: 'lastName',
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
                controller: registerController.phoneController,
                decoration: InputDecoration(
                  hintText: 'phone',
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
                controller: registerController.passwordController,
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
                registerController.registerUser(context);
              },
              child: Text(
                'Sign up',
              )),
          Text('If you have account, please click "Login" button'),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpPhone(),
              ));
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  
}
