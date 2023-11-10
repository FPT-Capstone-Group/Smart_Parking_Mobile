// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RegisterApplication extends StatefulWidget {
//   const RegisterApplication({super.key});

//   @override
//   State<RegisterApplication> createState() => _RegisterApplication();
// }

// class _RegisterApplication extends State<RegisterApplication> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   late Future<String?> token;

//  @override
//   void initState() {
//     super.initState();
//     token = _prefs.then((SharedPreferences prefs) {
//       print(prefs.getString('token'));
//       return prefs.getString('token');

//     });
//   }

//   }
// }

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_auto/Screen/home.dart';

class Registration extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Registration(),
      
    );
  }
}

class _Registration extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Registration> {
  
  final ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Registration"),
            backgroundColor: Colors.redAccent),
        body: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [

                  // SizedBox(
                  //   height: 115,
                  //   width: 115,
                  //   child: Stack(
                  //     clipBehavior: Clip.none,
                  //     fit: StackFit.expand,
                  //     children: [
                  //        CircleAvatar(
                  //             radius: 70.0,
                  //             backgroundImage: image == null
                  //             ? const AssetImage("assets/Atime.jpg") as ImageProvider
                  //             : FileImage(File(image!.path)) as ImageProvider,
                  //           ),
                  //       Positioned(
                  //           right: -16,
                  //           bottom: 0,
                  //           child: SizedBox(
                  //               height: 46,
                  //               width: 46,
                  //               child: FloatingActionButton(
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(50),
                  //                   side: BorderSide(color: Colors.white),
                  //                 ),
              
                  //                 onPressed: () async { 
                  //                   final filePicked =
                  //                         await picker.pickImage(source: ImageSource.camera);
                  //                     setState(() {
                  //                       //update UI
                  //                       image = filePicked;
                  //                     });
                  //                     print(image!.path);
                  //                   },
                  //                 // TODO: Icon not centered.
                  //                 child: Center(child: Icon(Icons.camera_alt_outlined)),
                  //               )))
                  //     ],
                  //   ),
                  // ),

               const SizedBox(height: 16),
                Divider(color: Colors.white70),
                Text(
                    'User infor',textAlign: TextAlign.left,
                  ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "Name"),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone"),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                 Divider(color: Colors.white70),
                 Text(
                    'Vehicle infor',textAlign: TextAlign.left,
                  ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "License plates"),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  //controller: phoneController,
                  decoration: InputDecoration(labelText: "Description"),
                  keyboardType: TextInputType.phone,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text("Home")),
              ],
            )
            )
            );
  }
}
  