
import 'package:flutter/material.dart';
import 'package:parking_auto/Screen/face_camera.dart';
import 'package:parking_auto/Screen/logout.dart';
import 'package:parking_auto/Screen/notification.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/controller/get_current_user.dart';


class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidget createState() => _NavigationDrawerWidget();
}
class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  var firstNameCurrent ="aa";
  var lastNameCurrent ="aa";
  // @override
  // void initState() {
  //   super.initState();
  //   _loadData();
  // }

  // _loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     firstNameCurrent = prefs.getString('firstName');
  //     if (firstNameCurrent == null) {
  //       firstNameCurrent = ' ';
  //     }
  //     lastNameCurrent = prefs.getString('lastName');
  //     if (lastNameCurrent == null) {
  //       lastNameCurrent = ' ';
  //     }
  //   });
  // }

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
              firstName: firstNameCurrent,
              lastName: lastNameCurrent,
              onClicked: () {
                 GetUserController get = GetUserController();
                get.getUserData(context);
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
                    text: 'Profile  ',
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
                    text: 'Payment',
                    icon: Icons.payment,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 6),
                    
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
    required String firstName,
    required String lastName,
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
                    firstName,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastName,
                    style: TextStyle(fontSize: 14, color: Colors.white),
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
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => MyproFile(),
      //   ));
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => MyproFile(),
        // ));
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FaceCameraImage(),
        // ));
        GetUserController get = GetUserController();
                get.getUserData(context);
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FaceCameraImage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegistrationHistory(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegistrationHistory(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegistrationHistory(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationPage(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Logout(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Logout(),
        ));
        break;
    }
  }
}
