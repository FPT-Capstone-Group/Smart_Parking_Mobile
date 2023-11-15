// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:parking_auto/controller/registration_controller.dart';
// import 'package:parking_auto/controller/user_controller.dart';

// class Profile extends StatelessWidget {
//  UserController userController = Get.put(UserController());
//   TextEditingController userIdController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('API Update & Delete'), actions: [
//         TextButton(
//             onPressed: () {
//               userController.nameController.clear();
//               userController.emailController.clear();
//               userController.genderController.clear();
//               userController.statusController.clear();
//             },
//             child: Text(
//               'clear',
//               style: TextStyle(color: Colors.white),
//             ))
//       ]),
//       body: Container(
//         margin: EdgeInsets.all(20),
//         child: ListView(children: [
//           TextField(
//             controller: userController.,
//             decoration: InputDecoration(hintText: 'name'),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: userController.emailController,
//             decoration: InputDecoration(hintText: 'email'),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: userController.genderController,
//             decoration: InputDecoration(hintText: 'gender'),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: userController.statusController,
//             decoration: InputDecoration(hintText: 'status'),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: userIdController,
//             decoration: InputDecoration(hintText: 'user id'),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               userController.fetchUserData(userIdController.text);
//             },
//             child: Text('get data'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               userController.updateUserData(userIdController.text);
//             },
//             child: Text('update data'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               userController.deleteUserData(userIdController.text);
//             },
//             child: Text('delete data'),
//           )
//         ]),
//       ),
//     );
//   }
// }