import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/controller/payment_controller.dart';

const List<String> gender = <String>['1 month', '1 year'];

class OrderRegistration extends StatefulWidget {
   const OrderRegistration({super.key});

  @override
   State<OrderRegistration> createState() => _OrderRegistration();
}

class _OrderRegistration extends State<OrderRegistration> {
  var strAmount = "400000";
  var amount;
final orderForm = GlobalKey<FormState>();

  PaymentController getData = PaymentController();

  final registerForm = GlobalKey<FormState>();

   TextEditingController registrationNumberController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController modelBikeController = TextEditingController();

  String dropdownGender = gender.first;

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  //late String _paymentStatus;
  bool paymentButton = false;
  //bool _isLoading = false;
  bool cancelButton = false;
  bool deactiveRegistration = true;
  bool reactiveRegistration = false;

  late BuildContext _context;

  @override
  void initState() {
    super.initState();

    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    //_paymentStatus = "";
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Registration Park'),
            leading: IconButton(
              onPressed: () {
                Get.to(HomeNavBar());
              },
              icon: const Icon(Icons.home),
            ),
            actions:const [Icon(Icons.create)],
            backgroundColor: Colors.redAccent),
        body: Form(
            key: orderForm,
            // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            // alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: 5),
                // const Divider(color: Colors.white70),
                // const Text(
                //   'User infor',
                //   textAlign: TextAlign.left,
                // ),
                TextFormField(
                  controller: registrationNumberController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: "Driver's license",
                    hintText: "Enter your Driver's license",
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: plateNumberController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Plate number',
                    hintText: 'Enter your plate number',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (plateNumberController) {
                    if (plateNumberController == null ||
                        plateNumberController.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (plateNumberController.length < 2) {
                      return 'Too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                //Divider(color: Colors.white70),
                TextFormField(
                  controller: manufactureController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Manufacture',
                    hintText: 'Enter manufacture',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (descriptionController) {
                    if (descriptionController == null ||
                        descriptionController.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: modelBikeController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    labelText: 'Model',
                    hintText: 'Enter model ',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (modelBikeController) {
                    if (modelBikeController == null ||
                        modelBikeController.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                DropdownButton<String>(
                  value: dropdownGender,
                  icon: const Icon(Icons.pin_drop),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      print('value:  $value');
                      if(value=="1 month"){
                        strAmount= "400000";
                        amount = 400000;
                      }else{
                        strAmount= "1500000";
                        amount = 1500000;
                      }
                      dropdownGender = value!;
                    });
                  },
                  items: gender.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Text('Amount: $strAmount vnd'),
                //---------dropdownButton value------
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    print('amount:   $amount');
                       final price = amount ?? 0;
                                  _payment(
                                    amount: price,
                                    fee: 0,
                                    description: "Smart - Parking",
                                    username: "SmartParking",
                                  );
                  },
                  child: const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Payment",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ))));
  }

  void _payment({
    required int amount,
    required int fee,
    required String description,
    required String? username,
  }) {
   // setState(() => _isLoading = true);

    final options = MomoPaymentInfo(
      merchantName: 'Smart Parking',
      merchantNameLabel: 'Smart Parking',
      orderLabel: 'Smart Parking',
      partner: 'merchant',
      appScheme: "MOMOV2U120231123",
      merchantCode: 'MOMOV2U120231123',
      partnerCode: 'MOMOV2U120231123',
      amount: amount,
      orderId: "123",
      fee: fee,
      description: description,
      username: username,
      extra: "{}",
      isTestMode: true,
    );
    try {
      _momoPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
     // setState(() => _isLoading = false);
    }
  }

  Future<void> _showToast(bool isSuccess) async {
    Fluttertoast.showToast(
        msg: isSuccess ? "Payment success" : "Payment failure");
  }

  void _setState() async {
    // _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      //  print("resule");
      // print(_momoPaymentResult.toString());
      // print("payment respone");
      // print(_momoPaymentResult.data);
      //  print("payment message");
      //  print(_momoPaymentResult.message);
      // print("extra");

      // print( _momoPaymentResult.extra!);
      // print("token");
      // print(_momoPaymentResult.token);
      //  print("phone");
      //   print(_momoPaymentResult.phoneNumber);

      // _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      // print(_paymentStatus);

      final rs = await getData.submitPaymentMomo(
        //amount: widget.item.amount ?? 0,
       //registrationId: widget.item.registrationId ?? 0,
        amount: amount,
        registrationId: 12,
        
      );

      await _showToast(rs);

      if (rs == true) {
        Navigator.pop(_context, true);
        Get.to(const RegistrationHistory());
      }

      // _paymentStatus += "\nTình trạng: Thành công.";
      // _paymentStatus +=
      //     "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      //_paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      // _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      await _showToast(false);
      // _paymentStatus += "\nTình trạng: Thất bại.";
      // _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      // _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }

    //setState(() => _isLoading = false);
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
  }

  // void setRegistrationId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove("registrationId");
  //   prefs.setString("registrationId", widget.item.registrationId.toString());
  // }
}
