import 'package:flutter/material.dart';
import 'package:parking_auto/widget/button_widget.dart';
import 'package:parking_auto/widget/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _Home_Page createState() => _Home_Page();
}

class _Home_Page extends State<HomePage> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<String?> token;

  @override
  void initState() {
    super.initState();
  }

  static final String title = 'Home Page';
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(_Home_Page.title),
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
