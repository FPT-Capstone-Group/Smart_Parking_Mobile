
import 'package:flutter/material.dart';
import 'package:parking_auto/controller/changePassword_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  static const routeNamed = '/changePasswordScreen';

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final registerForm = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool showOldPassword = false;
  bool showNewPassword = false;

  ChangePasswordController changePassword = ChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
         centerTitle: true,
      ),
      body: Form(
        key: registerForm,
        //margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            TextFormField(
                keyboardType: TextInputType.number,
                controller: oldPasswordController,
                obscureText: !showOldPassword, //This will obscure text dynamically
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
                  labelText: 'Old Password',
                  hintText: 'Enter your old password',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      showOldPassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        showOldPassword = !showOldPassword;
                      });
                    },
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            
            TextFormField(
                keyboardType: TextInputType.number,
                controller: newPasswordController,
                obscureText: !showNewPassword, //This will obscure text dynamically
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
                      showNewPassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        showNewPassword = !showNewPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              
           ElevatedButton(
                onPressed: () {
                    if (registerForm.currentState!.validate()) {
                  changePassword.oldPasswordController = oldPasswordController;
                  changePassword.newPasswordController= newPasswordController;
                  changePassword.changePassword();
                    }
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Submit",
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
            const SizedBox(
              height: 5,
            ),
           
          ],
        ),
      ),
    );
  }
  }

