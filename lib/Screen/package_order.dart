import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/bike_of_user.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/parking_order_info.dart';
import 'package:parking_auto/controller/get_parking_order_info_controller.dart';
import 'package:parking_auto/controller/package_order_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> gender = <String>['1 Month', '4 Month', '1 Year'];

class PackageOrder extends StatelessWidget {
  const PackageOrder({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PackageOrderInfoController(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking Type',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ProviderPackageOrder()),
    );
  }
}

class ProviderPackageOrder extends StatefulWidget {
  const ProviderPackageOrder({Key? key}) : super(key: key);

  @override
  _ProviderPackageOrderState createState() => _ProviderPackageOrderState();
}

class _ProviderPackageOrderState extends State<ProviderPackageOrder> {
  GetParkingOrderInfoController getParkingOrderInfoController =GetParkingOrderInfoController();
  var strAmount = "400000";
  var amount;
  var parkingTypeId = 3;
  var strdate = "30";
  String dropdownPackage = gender.first;
  @override
  void initState() {
    super.initState();
    final postModel =
        Provider.of<PackageOrderInfoController>(context, listen: false);
    postModel.getPostData();
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<PackageOrderInfoController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Parking Type'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: postModel.loading
            ? Center(
                child: Container(),
              )
            : Center(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                child:  Text(
                          'Select your parking type order',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color:  Color.fromARGB(255, 204, 43, 43),
                          ),
                        ),
              ),
                    DropdownButton<String>(
                      value: dropdownPackage,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        //setState(() {
                            print('value:  $value');
                      if(value=="1 Month"){
                        setState(() {
                        strAmount= "300000";
                        strdate = "30";
                        amount = 300000;
                        parkingTypeId = 3;
                        });
                      }else if(value=="4 Month"){
                          setState(() {
                        strAmount= "1200000";
                         strdate = "120";
                        amount = 1200000;
                        parkingTypeId = 4;
                         });
                      }else if(value=="1 Year"){
                         setState(() {
                        strAmount= "3600000";
                         strdate = "365";
                        amount = 3600000;  
                        parkingTypeId = 5;

                        });
                      }
                      setState(() {
                      dropdownPackage = value!;
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
                    //---------dropdownButton value------
                    const SizedBox(height: 10),
                     const SizedBox(height: 10),
                Text('Amount: $strAmount vnd'),
                    const SizedBox(height: 10),
                Text('Expired date: $strdate days'),
                
                    const SizedBox(height: 20),

                    /// -- BUTTON
                    SizedBox(
                      width: 200,
                      child: FloatingActionButton.extended(
                        onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove("parkingTypeId");
                              prefs.setString("parkingTypeId", parkingTypeId.toString());
                          Get.to(const ParkingOrderInfo());
                        },
                        icon: const Icon(Icons.edit),
                        label: Text('Next'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 200,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Get.to(const BikeOfUser());
                        },
                        icon: const Icon(Icons.change_circle_outlined),
                        label: const Text('Cancel'),
                      ),
                    ),

                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),
                  ],
                ),
              )),
              
      ),
      

    );
  }
}
