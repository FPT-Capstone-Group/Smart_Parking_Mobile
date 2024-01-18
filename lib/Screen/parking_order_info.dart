import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/create_order_controller.dart';
import 'package:parking_auto/controller/get_parking_order_info_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ParkingOrderInfo extends StatelessWidget {
  const ParkingOrderInfo({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>GetParkingOrderInfoController(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Parking Order Info',
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
  var parkingTypeId;
  var expiredDate;
  var parkingOrderAmount;
  @override
  void initState() {
   
    super.initState();
    final postModel = Provider.of<GetParkingOrderInfoController>(context, listen: false);
    postModel.getPostData();
   
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<GetParkingOrderInfoController>(context);
    parkingTypeId = postModel.info?.parkingTypeId;
    expiredDate = postModel.info?.expiredDate;
    parkingOrderAmount = postModel.info?.parkingOrderAmount;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
  title:const Text('Parking Order Info'),
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
         

              Container(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Plate Number: ${postModel.info?.plateNumber}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                               
                        Text("Parking Type Name: ${postModel.info?.parkingTypeName}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        Text("Expired Date: ${postModel.info?.expiredDate}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                      
                           Text("Amount: ${postModel.info?.parkingOrderAmount} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: const Color(0xFF999999))),
                           
                      
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Divider(height: 1),
                  ),

              const SizedBox(height: 10),
              /// -- BUTTON
              SizedBox(
                width: 130,
                child: FloatingActionButton.extended(
                                onPressed: () async{
                                //  print("parkingTypeId: $parkingTypeId");
                                //   print("expiredDate: $expiredDate");
                                //   print("parkingOrderAmount: $parkingOrderAmount");
                                   SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("parkingTypeId", parkingTypeId);
                                    prefs.setString("expiredDate", expiredDate);
                                    prefs.setString("parkingOrderAmount", parkingOrderAmount);

                                    CreateOrderController create = CreateOrderController();
                                    create.createOrder();
                                },
                                icon:const Icon(Icons.edit),
                                label:const Text('Create Order'),
                              ),
              ),

    
               const SizedBox(height: 10),
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