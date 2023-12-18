import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/sendOtp_controller.dart';
import 'package:parking_auto/controller/user_controller.dart';
import 'package:provider/provider.dart';

class ChangePass extends StatelessWidget {
  const ChangePass({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Change Password',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ChangePassPassScreen()),
    );
  }
}

class ChangePassPassScreen extends StatefulWidget {
    const ChangePassPassScreen({Key? key}) : super(key: key);

   @override
  State<ChangePassPassScreen> createState() => _ProviderChangePassPassScreenState();
}

class _ProviderChangePassPassScreenState extends State<ChangePassPassScreen> {
  final registerForm = GlobalKey<FormState>();
  //final login = Get.put(LoginWithPhone());

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool showOldPassword = false;
  bool showNewPassword = false;

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
        centerTitle: true,
        title: const Text('Change Password'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
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
              obscureText:
                  !showOldPassword, //This will obscure text dynamically
              validator: (passwordController) {
                if (passwordController == null || passwordController.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
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
              obscureText:
                  !showNewPassword, //This will obscure text dynamically
              validator: (passwordController) {
                if (passwordController == null || passwordController.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
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
            FloatingActionButton.extended(
              onPressed: () {
                if (registerForm.currentState!.validate()) {
                  userController.oldPasswordController = oldPasswordController;
                  userController.newPasswordController = newPasswordController;
                  userController.changePassword();
                }
              },
              icon: const Icon(Icons.send),
              label: const Text('Submit'),
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
