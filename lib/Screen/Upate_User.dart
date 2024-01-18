import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/user_controller.dart';
import 'package:provider/provider.dart';

const List<String> gender = <String>['Male', 'FeMale'];

class UpdateUser extends StatelessWidget {
  const UpdateUser({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const UpdateUserScreen()),
    );
  }
}

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  _ProviderDemoScreenState createState() => _ProviderDemoScreenState();
}

class _ProviderDemoScreenState extends State<UpdateUserScreen> {
  final editProfileKey = GlobalKey<FormState>();

  UserController userController = UserController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String dropdownGender = gender.first;

  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<UserController>(context, listen: false);
    postModel.getPostData();

     
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<UserController>(context);
    // int? age = postModel.user?.user!.age;
    // String? age = postModel.user?.user!.age.toString();

   fullNameController.text = postModel.user?.user!.fullName ?? "";
   if(postModel.user?.user!.age == null || postModel.user?.user!.age == ""){
    ageController.text = "";
   }else{
    ageController.text = postModel.user?.user!.age.toString() ?? "";
   }
   // ageController.text = postModel.user?.user!.age.toString() ?? " ";
    //print(" age ${ageController.text}");
    addressController.text = postModel.user?.user!.address ?? "";
 
   
    return Scaffold(
      appBar: AppBar(
       centerTitle: true,
  title: const Text('Update Profile'),
  leading: IconButton(
    onPressed: () {
      Get.to(HomeNavBar());
    },
    icon: const Icon(Icons.home),
  ),
      ),
      body: Container(
        padding:const EdgeInsets.all(20),
        child: postModel.loading
            ? Center(
                child: Container(),
              )
            : Center(
            //  child: SingleChildScrollView(scrollDirection: Axis.vertical,
       
                child: Form(
                  key: editProfileKey,
                  // margin: EdgeInsets.all(20),
                  child: ListView(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Full Name',
                        hintText: 'Enter your fullName',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (fullNameController) {
                        if (fullNameController == null ||
                            fullNameController.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration:const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Age',
                        hintText: 'Enter your age',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (ageController) {
                        String pattern = r'^[0-9]{1,2}$';
                        RegExp regExp = new RegExp(pattern);
                        if (ageController == null || ageController.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        if (!regExp.hasMatch(ageController)) {
                          return 'Age must be number and length 1 to 2 character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: addressController,
                      decoration:const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Enter your address',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (addressController) {
                        if (addressController == null ||
                            addressController.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButton<String>(
                      value: dropdownGender,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                     
         

                        setState(() {
                          dropdownGender = value!;
                        });
                 
                      },
                      items:
                          gender.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        if (editProfileKey.currentState!.validate()) {
                          int age;
                          userController.fullNameController =
                              fullNameController;
                          userController.addressController = addressController;

                         age = int.parse(ageController.text);

                          userController.age = age;

                          userController.dropGender = dropdownGender;


                          userController.updateUser();
                        }
                      },
                      icon:const Icon(Icons.update),
                      label:const Text('Update'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
                ),
              )
              ),
      );
  //  );
  }
}
