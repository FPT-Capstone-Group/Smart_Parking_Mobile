import 'package:flutter/material.dart';
import 'package:parking_auto/model/user.dart';

class MyproFile extends StatefulWidget  {
   const MyproFile({super.key});
  @override
  __MyproFile createState() => __MyproFile();
}

class __MyproFile extends State<MyproFile> {
// @override
//   void initState() {
//     super.initState();
//     GetUserController get = GetUserController();
//     get.getUserData(context);
//   }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idController = TextEditingController();
  int? userId;
  
  @override
  Widget build(BuildContext context) {  
    final user = ModalRoute.of(context)!.settings.arguments as User;
    firstNameController.text = user.firstName.toString();
    lastNameController.text = user.lastName.toString();
    phoneNumberController.text = user.phoneNumber.toString();
    userId = user.userId!.toInt();
    //setState(() {});
    return Scaffold(
      appBar: AppBar(title: Text("Profile"), actions: [
        TextButton(
            onPressed: () {
      
            },
            child: Text(
              'clear',
              style: TextStyle(color: Colors.white),
            ))
      ]),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(children: [ 
          TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'First Name',
                  //hintText: 'Enter your lastName',
                ),
                keyboardType: TextInputType.text,
                validator: (firstNameController) {
                  if (firstNameController == null || firstNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
          const SizedBox(
            height: 10,
          ),
         TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Last Name',
                  //hintText: 'Enter your lastName',
                ),
                keyboardType: TextInputType.text,
                validator: (lastNameController) {
                  if (lastNameController == null || lastNameController.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'Phone number',
                  //hintText: 'Enter your phone',
                ),
                keyboardType: TextInputType.number,
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
          const SizedBox(
            height: 10,
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     print("----------profile page------------");
          //     print(user.firstName);
          //     print(user);
          //     // print('${widget.text}');
          //   },
          //   child: Text('get data'),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          ElevatedButton(
            onPressed: () {
             
            },
            child: Text('update data'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.focused))
                    return Colors.green;
                  return null; // Defer to the widget's default.
                }
              ),
            ),
            onPressed: () { },
            child: Text('delete'),
          ),
          // ElevatedButton(
          //   onPressed: () {
             
          //   },
          //   child: Text('delete data'),
          // )
        ]),
      ),
    );
  }
}