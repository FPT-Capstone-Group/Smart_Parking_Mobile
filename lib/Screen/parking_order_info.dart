import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/controller/get_parking_order_info_controller.dart';
import 'package:provider/provider.dart';


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
        home:ProviderDemoScreen()
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
    final postModel = Provider.of<GetParkingOrderInfoController>(context, listen: false);
    postModel.getPostData();
   
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<GetParkingOrderInfoController>(context);

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
               // const SizedBox(height: 90),
              /// -- IMAGE
              //  const Text(
              //             'Parking order Information',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               fontSize: 24,
              //               color:  Color.fromARGB(255, 204, 43, 43),
              //             ),
              //           ),
              //           const Divider(color: Colors.green),
              //           Container(height: 5),
              // const SizedBox(height: 10),
              

              // Text("plateNumber: ${postModel.user?.plateNumber}", style: Theme.of(context).textTheme.headline6),
             
              // const SizedBox(height: 10),
          
              // Text("parkingTypeName: ${postModel.user?.parkingTypeName}", style: Theme.of(context).textTheme.headline6),

              // const SizedBox(height: 10),
              // postModel.user?.expiredDate != null ? 
              // Text("expiredDate: ${postModel.user?.expiredDate}", style: Theme.of(context).textTheme.headline6): 
              // Text("expiredDate: ", style: Theme.of(context).textTheme.headline6),
              // const SizedBox(height: 10),
              // postModel.user?.parkingOrderAmount != null ? 
              // Text("parkingOrderAmount: ${postModel.user?.parkingOrderAmount}", style: Theme.of(context).textTheme.headline6): 
              // Text("parkingOrderAmount: ", style: Theme.of(context).textTheme.headline6),

    
              // const SizedBox(height: 20),

              Container(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Plate Number: ${postModel.user?.plateNumber}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        Text("Parking Type Name: ${postModel.user?.parkingTypeName}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        Text("Expired Date: ${postModel.user?.expiredDate}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                      
                           Text("Amount: ${postModel.user?.parkingOrderAmount} ",
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
                width: 100,
                child: FloatingActionButton.extended(
                                onPressed: () {
                                
                                },
                                icon:const Icon(Icons.edit),
                                label: Text('Create'),
                              ),
              ),
              const SizedBox(height: 10),
               SizedBox(
                width: 100,
                child: FloatingActionButton.extended(
                                onPressed: () {
                                
                                },
                                icon:const Icon(Icons.change_circle_outlined),
                                label:const Text('Cancel'),
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