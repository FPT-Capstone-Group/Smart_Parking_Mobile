
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/User_Profile.dart';
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/Screen/face_camera_registration.dart';
import 'package:parking_auto/Screen/notification.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/Screen/setting.dart';
import 'package:parking_auto/controller/login_controller.dart';
import 'package:parking_auto/controller/logout_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidget createState() => _NavigationDrawerWidget();
}
class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  final logincontroller = Get.put(LoginController());
  LogoutController logout = LogoutController();
  var fullName = "";
  LoginController loginController = Get.find();
  
 @override
  void initState() {
    super.initState();
    _setFullName();
  }

  _setFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString("fullName").toString();
      if(fullName.toString() == false){
        fullName = "";
      }
    });
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
    
              fullName: "Hi $fullName",
       
              onClicked: () {
                 Get.to(UserProfile());
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
                    text: 'Registration History',
                    icon: Icons.history,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notification_important,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'List Bike',
                    icon: Icons.list,
                    onClicked: () => selectedItem(context, 4),
                  ),
      
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
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
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

        Get.to(UserProfile());
        break;
      case 1:
       Get.to(FaceCameraRegistration());
      
        break;
      case 2:
      Get.to(RegistrationHistory());
      
        break;
      case 3:
       Get.to(NotificationPage());
     
        break;
      case 4:
       Get.to(BikeOfUser());
      
        break;
     
      case 5:
 
        Get.to(SettingsPage());
      
        break;
    }
  }
}
