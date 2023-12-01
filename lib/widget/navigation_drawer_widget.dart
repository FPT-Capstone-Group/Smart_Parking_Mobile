
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/Screen/setting.dart';
import 'package:parking_auto/controller/get_current_user.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:parking_auto/controller/logout_controller.dart';


class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidget createState() => _NavigationDrawerWidget();
}
class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  final logincontroller = Get.put(LoginController());
  LogoutController logout = LogoutController();
  //LoginController loginController = LoginController();
  //var data = Get.arguments;

  LoginController loginController = Get.find();
  
  @override
  void initState() {
    super.initState();
    checkNull();
  }

  checkNull()  {
    setState(() {
      if(loginController.fullName == null || loginController.fullName == ""){
        loginController.fullName = " ";
      }
    });
  }

//class NavigationDrawerWidget extends StatelessWidget {
  // GetUserController getuser= GetUserController();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {

   
    // final urlImage =
    //     "C:\Users\yayuk\Downloads\Atime.png";
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
             // urlImage: urlImage,
              fullName: "Welcome " + loginController.fullName,
              //lastName: lastNameCurrent,
              onClicked: () {
                 GetUserController get = GetUserController();
                get.getUserData();
              },
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // buildSearchField(),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Profile',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Registration',
                    icon: Icons.app_registration_rounded,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'View History Log',
                    icon: Icons.history,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Add Owner',
                    icon: Icons.add,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'List Bike',
                    icon: Icons.list,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Payment',
                  //   icon: Icons.payment,
                  //   onClicked: () => selectedItem(context, 5),
                  // ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 16),
                
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 5),
                    
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String fullName,
    //required String lastName,
    // required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              // CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              // SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   lastName,
                  //   style: TextStyle(fontSize: 14, color: Colors.white),
                  // ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.face, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
      
        // Get.to(MyproFile());
        GetUserController get = GetUserController();
                get.getUserData();
        break;
      case 1:
       Get.to(FaceCamera());
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FaceCameraImage(),
        // ));
        break;
      case 2:
      Get.to(RegistrationHistory());
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => RegistrationHistory(),
        // ));
        break;
      case 3:
       Get.to(RegistrationHistory());
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => RegistrationHistory(),
        // ));
        break;
      case 4:
       Get.to(BikeOfUser());
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => BikeOfUser(),
        // ));
        break;
      case 5:
      // Get.to(BikeOfUser());
      //   // Navigator.of(context).push(MaterialPageRoute(
      //   //   builder: (context) => NotificationPage(),
      //   // ));
      //   break;
      // case 6:
      // Get.to(NotificationPage());
      //   // Navigator.of(context).push(MaterialPageRoute(
      //   //   builder: (context) => Logout(),
      //   // ));
      //   break;
      case 5:
          //logout.logout(context);
        Get.to(SettingsPage());
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => Logout(),
        // ));
        break;
    }
  }
}
