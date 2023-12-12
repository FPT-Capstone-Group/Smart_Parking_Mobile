import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/controller/cancelRegistration_controller.dart';
import 'package:parking_auto/controller/payment_controller.dart';
import 'package:parking_auto/model/registration_respone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationDetail extends StatefulWidget {
  const RegistrationDetail(this.item, {super.key});

  final Data item;

  @override
  State<RegistrationDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<RegistrationDetail> {
  CancelRegistrationController cancelRegistrationController = CancelRegistrationController();
  PaymentController getData = PaymentController();

  
  Uint8List base64Decode(String source) => base64.decode(source);
  

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  //late String _paymentStatus;
  bool paymentButton=false;
  bool _isLoading = false;
  bool cancelButton = false;

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
    var registrationStatus;
    registrationStatus = widget.item.registrationStatus.toString();
    if(registrationStatus.toString().toUpperCase() == "Verified".toUpperCase() || registrationStatus.toString().toUpperCase() == "Expired".toString().toUpperCase()  ){
        paymentButton = true;
         setState(() {});
    }
    if(registrationStatus.toString().toUpperCase() == "Created".toString().toUpperCase() || registrationStatus == "Verify".toString().toUpperCase()  ){
        cancelButton = true;
         setState(() {});
    }
   
    _context = context;
    return Scaffold(
      appBar: AppBar( title: Text('Registration detail'),
          centerTitle: true,
          backgroundColor: Colors.green,),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                  "RegistrationId: ${widget.item.registrationId}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
               ),
                Text(
                  "Status: ${widget.item.registrationStatus}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
               
                Text(
                  "Approuved By: ${widget.item.approvedBy}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "PlateNumber: ${widget.item.plateNumber}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                  "Model:  ${widget.item.model}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                  "Manufacture:  ${widget.item.manufacture}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  
                ),
                const SizedBox(
                  height: 5,
                ),
                 Text(
                  "Registration Number:  ${widget.item.registrationNumber}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Gender:  ${widget.item.gender}", style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Price: ${widget.item.amount}" + " vnd",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
               
                const SizedBox(height: 5),
                Center(child: Image.memory(base64Decode(widget.item.faceImage.toString()), width: 250, height: 250)
                ),
                const SizedBox(height: 5),  

                 Visibility(
              child: ElevatedButton(
                onPressed: () {
                  setPlateNumber();
                    cancelRegistrationController.cancelRegistration();
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Cancel ",
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
              visible: cancelButton,
              //visible: true,
            ),
              
                 Visibility(
              child: ElevatedButton(
                onPressed: () {
                  
                  final price = widget.item.amount ?? 0;
                      _payment(
                        amount: price,
                        fee: 0,
                        description: "Smart - Parking",
                        username: "SmartParking",
                      );
                  //loginWithPhone();
                },
                child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Payment ",
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
              visible: paymentButton,
              //visible: true,
            ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.grey.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }

  void _payment({
    required int amount,
    required int fee,
    required String description,
    required String? username,
  }) {
    setState(() => _isLoading = true);

    final options = MomoPaymentInfo(
      merchantName: 'Smart Parking',
      merchantNameLabel: 'Smart Parking',
      orderLabel: 'Smart Parking',
      partner: 'merchant',
      appScheme: "",
      merchantCode: 'MOMOV2U120231123',
      partnerCode: 'MOMOV2U120231123',
      amount: amount,
      orderId: widget.item.registrationId.toString(),
      fee: fee,
      description: description,
      username: username,
      // extra: "{}",
      isTestMode: true,
    );
    try {
      _momoPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
      setState(() => _isLoading = false);
    }
  }

  Future<void> _showToast(bool isSuccess) async {
    Fluttertoast.showToast(
        msg: isSuccess ? "Payment success" : "Payment failure");
  }

  void _setState() async {
    // _paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      final rs = await getData.submitPaymentMomo(
        amount: widget.item.amount ?? 0,
        registrationId: widget.item.registrationId ?? 0,
      );

      await _showToast(rs);

      if (rs == true) {
        Navigator.pop(_context, true);
        Get.to(RegistrationHistory());
      }

      // _paymentStatus += "\nTình trạng: Thành công.";
      // _paymentStatus +=
      //     "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
      // //_paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
      // _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
    } else {
      await _showToast(false);
      // _paymentStatus += "\nTình trạng: Thất bại.";
      // _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
      // _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }

    setState(() => _isLoading = false);
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
  void setPlateNumber() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("registrationId");
    prefs.setString("registrationId", widget.item.registrationId.toString());
    
  }
}
