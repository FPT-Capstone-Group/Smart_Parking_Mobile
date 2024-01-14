import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/registration_hitory.dart';
import 'package:parking_auto/controller/payment_controller.dart';
import 'package:parking_auto/controller/update_registration_controller.dart';
import 'package:parking_auto/model/registration_respone_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationDetail extends StatefulWidget {
  const RegistrationDetail(this.item, {super.key});

  final Data item;

  @override
  State<RegistrationDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<RegistrationDetail> {
  UpdateRegistrationController updateRegistration =
      UpdateRegistrationController();
  PaymentController getData = PaymentController();

  Uint8List base64Decode(String source) => base64.decode(source);

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  //late String _paymentStatus;
  bool paymentButton = true;
  bool _isLoading = false;
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
    // String registrationStatus;
    // registrationStatus = widget.item.registrationStatus.toString();
    // if (registrationStatus.toString().toUpperCase() ==
    //         "Verified".toUpperCase() ||
    //     registrationStatus.toString().toUpperCase() ==
    //         "Expired".toString().toUpperCase()) {
    //   paymentButton = true;
    //   setState(() {});
    // }
    // if (widget.item.expiredDate != null) {
    //   String date = widget.item.expiredDate.toString();
    //   DateTime parseDate =
    //       new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    //   var inputDate = DateTime.parse(parseDate.toString());
    //   var outputFormat = DateFormat('yyyy-MM-dd');
    //   var outputDate = outputFormat.format(inputDate);
    //   widget.item.expiredDate = outputDate;
    // }

    // if (registrationStatus.toString().toUpperCase() ==
    //         "Created".toString().toUpperCase() ||
    //     registrationStatus == "Verify".toString().toUpperCase()) {
    //   cancelButton = true;
    //   setState(() {});
    // }
    //String expired ;

    _context = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registration Detaiil'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   padding: const EdgeInsets.all(15),
                  //   child: widget.item.faceImage != ""
                  //       ? Image.memory(
                  //           base64Decode(widget.item.faceImage.toString()),
                  //           width: 150,
                  //           height: 150,
                  //           //fit: BoxFit.cover,
                  //         )
                  //       : const CircleAvatar(
                  //           radius: 100.0,
                  //           backgroundColor: Colors.orange,
                  //           child: Text("No image"),
                  //         ),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Plate Number: ${widget.item.plateNumber}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: const Color(0xFF37474F))),
                        Text("Status: ${widget.item.registrationStatus}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        Text("Approved By: ${widget.item.approvedBy}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        widget.item.expiredDate == null
                            ? Text("Expired Date: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: const Color(0xFF999999)))
                            : Text("Expired Date: ${widget.item.expiredDate}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: const Color(0xFF999999))),
                        Text("Manufacture: ${widget.item.manufacture}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        // Text("Amount: ${widget.item.amount} vnd",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleMedium!
                        //         .copyWith(color: const Color(0xFF999999))),
                        Text("Model: ${widget.item.model}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF999999))),
                        Text("Create At: ${widget.item.createdAt}",
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
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Text("Tonight's availability", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Color(0xFF37474F))),
                        Container(height: 5),
                        Row(
                          children: [
                            Visibility(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                ),
                                child: const Text("Cancel",
                                    style: const TextStyle(
                                        color: const Color(0xFF666666))),
                                onPressed: () {
                                  setRegistrationId();
                                  updateRegistration.cancelRegistration();
                                },
                              ),
                              visible: cancelButton,
                              //   //visible: true,
                            ),
                            Visibility(
                              child: ElevatedButton(
                                onPressed: () {
                                  final price = widget.item.amount ?? 1000;
                                  _payment(
                                    amount: price,
                                    fee: 0,
                                    description: "Smart - Parking",
                                    username: "SmartParking",
                                  );
                                  //loginWithPhone();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)),
                                ),
                                child: const Text("Payment",
                                    style: const TextStyle(
                                        color: const Color(0xFF666666))),
                              ),
                              visible: paymentButton,
                              //   //visible: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  /* Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      style: TextButton.styleFrom(primary: Colors.transparent),
                      child: Text("RESERVE", style: TextStyle(color: MyColorsSample.primary),),
                      onPressed: (){},
                    ),
                  ),
                  Container(height: 5)*/
                ],
              ),
            ),
            )
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
      appScheme: "MOMOV2U120231123",
      merchantCode: 'MOMOV2U120231123',
      partnerCode: 'MOMOV2U120231123',
      amount: amount,
      orderId: widget.item.registrationId.toString(),
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
        amount: widget.item.amount ?? 0,
        registrationId: widget.item.registrationId ?? 0,
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

  void setRegistrationId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("registrationId");
    prefs.setString("registrationId", widget.item.registrationId.toString());
  }
}
