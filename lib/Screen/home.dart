import 'package:flutter/material.dart';
import 'package:parking_auto/widget/button_widget.dart';
import 'package:parking_auto/widget/navigation_drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String?> token;

 @override
  void initState() {
    super.initState();
    token = _prefs.then((SharedPreferences prefs) {
      print(prefs.getString('token'));
      return prefs.getString('token');
      
    });
  }

  

  static final String title = 'Home Page';
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(_MainPageState.title),
        ),
        body: Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: ButtonWidget(
              icon: Icons.open_in_new,
              text: 'Open Menu Bar',

              onClicked: () {
                Scaffold.of(context).openDrawer();
                // Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
          
        ),
      );
}
