import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/Upate_User.dart';
import 'package:parking_auto/Screen/changePass.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/user_controller.dart';
import 'package:provider/provider.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>UserController(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Profile',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        home:const ProviderDemoScreen()
      ),);
  }
}
class ProviderDemoScreen extends StatefulWidget {
  const ProviderDemoScreen({Key? key}) : super(key: key);

  @override
  _ProviderDemoScreenState createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<ProviderDemoScreen> {
  @override
  void initState() {
   
    super.initState();
    final postModel = Provider.of<UserController>(context, listen: false);
    postModel.getPostData();
   
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<UserController>(context);
    var age;
    
    if(postModel.user?.user!.age == 0){
      age = " ";
    }else{
      age = postModel.user?.user!.age;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
  title:const Text('Profile'),
  leading: IconButton(
    onPressed: () {
      Get.to(HomeNavBar());
    },
    icon:const Icon(Icons.home),
  ),
      ),
      body: Container(
        padding:const EdgeInsets.all(20),
        child: postModel.loading?Center(
          child: Container(
          ),
        ):Center(
          child: SingleChildScrollView(
          child: Column(
            children: [
                const SizedBox(height: 90),
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: Image.asset("assets/image/profile.png",width: 64.0,),),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.green),
                      child: const Icon(
                       Icons.alternate_email,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              
              postModel.user?.user!.fullName != null ? 
              Text("Full Name: ${postModel.user?.user!.fullName}", style: Theme.of(context).textTheme.headlineSmall): 
              Text("Full Name: ", style: Theme.of(context).textTheme.headlineSmall),

              postModel.user?.user!.username != null ? 
              Text("Phone: ${postModel.user?.user!.username}", style: Theme.of(context).textTheme.headlineSmall): 
              Text("Phone: ", style: Theme.of(context).textTheme.headlineSmall),

              postModel.user?.user!.age != null ? 
              Text("Age: $age", style: Theme.of(context).textTheme.headlineSmall):
              Text("Age: ", style: Theme.of(context).textTheme.headlineSmall),

              postModel.user?.user!.address != null ? 
              Text("Address: ${postModel.user?.user!.address}", style: Theme.of(context).textTheme.headlineSmall): 
              Text("Address: ", style: Theme.of(context).textTheme.headlineSmall),

              postModel.user?.user!.gender != null ? 
              Text("Gender: ${postModel.user?.user!.gender}", style: Theme.of(context).textTheme.headlineSmall): 
              Text("Gender: ", style: Theme.of(context).textTheme.headlineSmall),

              // Text(postModel.user?.user!.username ?? "", style: Theme.of(context).textTheme.bodyText2),
              
              
              // Text(age, style: Theme.of(context).textTheme.bodyText2),

             
              //     Text(postModel.user?.user!.address ?? "", style: Theme.of(context).textTheme.bodyText2),
             
              //     Text(postModel.user?.user!.gender ?? "", style: Theme.of(context).textTheme.bodyText2),

              // Text(postModel.user?.user!.address ?? "", style: Theme.of(context).textTheme.bodyText2),
              // Text(postModel.user?.user!.gender ?? "", style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: FloatingActionButton.extended(
                                onPressed: () {
                                  Get.to(const UpdateUser());
                                },
                                icon:const Icon(Icons.edit),
                                label: const Text('Edit'),
                              ),
              ),
              const SizedBox(height: 5),
               SizedBox(
                width: 200,
                child: FloatingActionButton.extended(
                                onPressed: () {
                                  Get.to(const ChangePass());
                                },
                                icon:const Icon(Icons.change_circle_outlined),
                                label:const Text('Change Password'),
                              ),
              ),
    
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

            ],
          ),
          )
        ),
      ),
    );
  }
}