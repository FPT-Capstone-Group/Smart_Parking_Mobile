import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/User_Profile.dart';
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/Screen/create_registration.dart';
import 'package:parking_auto/Screen/notification.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/Screen/setting.dart';
import 'package:parking_auto/widget/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  static const routeNamed = '/homePageScreen';
  const HomePage({Key? key}) : super(key: key);
  @override
  _Home_Page createState() => _Home_Page();
}

class _Home_Page extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  static final String title = 'Home Page';
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer:const NavigationDrawerWidget(),
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(_Home_Page.title),
          centerTitle: true,
        actions: <Widget>[
          
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create registration',
            onPressed: () {
            Get.to(Registration());
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Notifications',
            onPressed: () {
             Get.to(NotificationPage());
            },
          ),
        ]
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.indigo,
              child: const Column(
              
            ),

                  
              ),
              
             
        
            const SizedBox(
              height: 27.0,
            ),
           
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              // FloatingActionButton(onPressed: (){
                              //     Get.to(FaceCamera());
                              // }),
                              Image.asset(
                                "assets/image/todo.png",
                                width: 64.0,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  // Get.to(Registration());
                                  Get.to(
                                    () =>const Registration(),
                                  );
                                },
                                child: const Text(
                                  "Registration",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),

                    

                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color:const Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/image/history.png",
                                width: 64.0,
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(const RegistrationHistory());
                                },
                                child: const Text(
                                  "Registration history",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/image/note.png",
                                width: 64.0,
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(const BikeOfUser());
                                },
                                child:const  Text(
                                  "List bike",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                  
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color:const Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/image/notify.png",
                                width: 64.0,
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(const NotificationPage());
                                },
                                child:const Text(
                                  "Notify",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/image/settings.png",
                                width: 64.0,
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(SettingsPage());
                                },
                                child:const Text(
                                  "Settings",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),

                     SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        color: Color.fromARGB(255, 21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/image/profile.png",
                                width: 64.0,
                              ),
                             const SizedBox(
                                height: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(UserProfile());
                                },
                                child:const Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                    ),

                    

                  ],
                ),
              ),
            )
          ],
        ))
        );
  }
}
