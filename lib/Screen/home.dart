import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/Screen/face_camera_registration.dart';
import 'package:parking_auto/Screen/notification.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/Screen/setting.dart';
import 'package:parking_auto/controller/get_current_user.dart';
import 'package:parking_auto/widget/navigation_drawer_widget.dart';

class HomePage extends StatefulWidget {
  static const routeNamed = '/homePageScreen';
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
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width ;
        return Scaffold(

          drawer: NavigationDrawerWidget(),
        // endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(_Home_Page.title), centerTitle: true,
        ),

          body: SingleChildScrollView(
            
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 52.0,
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing:20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            children: <Widget>[
                              // FloatingActionButton(onPressed: (){
                              //     Get.to(FaceCamera());
                              // }),
                              Image.asset("assets/image/todo.png",width: 64.0,),
                              SizedBox(
                                height: 10.0,
                              ),
                             TextButton(onPressed: () {
                             // Get.to(Registration());
                               Get.to(() => FaceCameraRegistration(), );
                                   
                                  }, child: Text(
                                    "Registration",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  ),
                              SizedBox(
                                height: 5.0,
                              ),
                            
                            ],
                            ),
                          )
                        ),
                      ),
                    ),

                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                
                                  Image.asset("assets/image/history.png",width: 64.0,),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextButton(onPressed: () {
                                     Get.to(RegistrationHistory());
                                  }, child: Text(
                                    "Registration history",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                 
                                ],
                              ),
                            )
                        ),
                      ),
                    ),

                     SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                               
                                  Image.asset("assets/image/note.png",width: 64.0,),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextButton(onPressed: () {
                                     Get.to(BikeOfUser());
                                  }, child: Text(
                                    "List bike",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  
                                ],
                              ),
                            )
                        ),
                      ),
                    ),

                     SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                             
                                  Image.asset("assets/image/profile.png",width: 64.0,),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextButton(onPressed: () {
                                   GetUserController getUser = GetUserController();
                                    getUser.getUserData();
                                   //Get.to(GetUPage());
                                  }, child: Text(
                                    "Profile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                             
                                ],
                              ),
                            )
                        ),
                      ),
                    ),

                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/image/notify.png",width: 64.0,),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextButton(onPressed: () {
                                     Get.to(NotificationPage());
                                  }, child: Text(
                                    "Notify",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                         
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Color.fromARGB(255,21, 21, 21),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                          
                                  Image.asset("assets/image/settings.png",width: 64.0,),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  TextButton(onPressed: () {
                                      Get.to(SettingsPage()); 
                                  }, child: Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                  ),
                       
                                ],
                              ),
                            )
                        ),
                        
                      ),
                      
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
                  
              

              );
        }
      }

