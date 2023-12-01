import 'package:flutter/material.dart';
import 'package:parking_auto/model/user.dart';
import 'package:profile/profile.dart';

class ProFile extends StatefulWidget  {
   const ProFile({super.key});
   static const routeNamed = '/profileScreen';
  @override
  __MyproFile createState() => __MyproFile();
}

class __MyproFile extends State<ProFile> {
// @override
//   void initState() {
//     super.initState();
//     GetUserController get = GetUserController();
//     get.getUserData(context);
//   }

  TextEditingController fullNameController = TextEditingController();
  //TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idController = TextEditingController();
  int? userId;
  
  @override
  Widget build(BuildContext context) {  
    final user = ModalRoute.of(context)!.settings.arguments as User;
    fullNameController.text = user.fullName.toString();
    phoneNumberController.text = user.username.toString();
    userId = user.userId!.toInt();
    //setState(() {});
    return Scaffold(
      // appBar: AppBar(title: Text("Profile"), actions: [
      //   TextButton(
      //       onPressed: () {
      
      //       },
      //       child: Text(
      //         'clear',
      //         style: TextStyle(color: Colors.white),
      //       ))
      // ]),
      // body: Container(
      //   margin: EdgeInsets.all(20),
      //   child: ListView(children: [ 
      //     TextFormField(
      //           controller: fullNameController,
      //           decoration: InputDecoration(
      //             enabledBorder: OutlineInputBorder(),
      //             focusedBorder: OutlineInputBorder(),
      //             labelText: 'Full Name',
      //             //hintText: 'Enter your lastName',
      //           ),
      //           keyboardType: TextInputType.text,
      //           validator: (firstNameController) {
      //             if (firstNameController == null || firstNameController.isEmpty) {
      //               return 'Can\'t be empty';
      //             }
      //             return null;
      //           },
      //         ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //   //  TextFormField(
      //   //         controller: lastNameController,
      //   //         decoration: InputDecoration(
      //   //           enabledBorder: OutlineInputBorder(),
      //   //           focusedBorder: OutlineInputBorder(),
      //   //           labelText: 'Last Name',
      //   //           //hintText: 'Enter your lastName',
      //   //         ),
      //   //         keyboardType: TextInputType.text,
      //   //         validator: (lastNameController) {
      //   //           if (lastNameController == null || lastNameController.isEmpty) {
      //   //             return 'Can\'t be empty';
      //   //           }
      //   //           return null;
      //   //         },
      //   //       ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     TextFormField(
      //           controller: phoneNumberController,
      //           decoration: InputDecoration(
      //             enabledBorder: OutlineInputBorder(),
      //             focusedBorder: OutlineInputBorder(),
      //             labelText: 'Phone number',
      //             //hintText: 'Enter your phone',
      //           ),
      //           keyboardType: TextInputType.number,
      //           validator: (phoneController) {
      //           String pattern = r'(^(?:[0])?[0-9]{10,12}$)';
      //           RegExp regExp = new RegExp(pattern);
      //           if (phoneController == null || phoneController.isEmpty) {
      //             return 'Can\'t be empty';
      //           }
      //           if (!regExp.hasMatch(phoneController)) {
      //             return 'Phone number must be number and length 10 to 12';
      //           }
      //           return null;
      //         },
      //         ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
             
      //       },
      //       child: Text('update data'),
      //     ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //   ]),
      // ),

      body: Container(
          margin: EdgeInsets.all(20),
          child:Profile(
            imageUrl: "https://images.unsplash.com/photo-1598618356794-eb1720430eb4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
            name: fullNameController.text,
            website: "shamimmiah.com",
            designation: "Project Manager | Flutter & Blockchain Developer",
            email: "cse.shamimosmanpailot@gmail.com",
            phone_number: phoneNumberController.text,
          ),
          
        ),
         

    );
  }
}