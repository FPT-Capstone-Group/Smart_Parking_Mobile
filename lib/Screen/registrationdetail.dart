import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:parking_auto/controller/payment_controller.dart';
import 'package:parking_auto/model/registration_respone_model.dart';

class RegistrationDetail extends StatefulWidget {
  const RegistrationDetail(this.item, {super.key});

  final Data item;

  @override
  State<RegistrationDetail> createState() => _RegistrationDetailState();
}

class _RegistrationDetailState extends State<RegistrationDetail> {
  PaymentController getData = PaymentController();

  static const _chars = '1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  //late String _paymentStatus;
  bool _isLoading = false;

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
    _context = context;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: ${widget.item.registrationId}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Status: ${widget.item.registrationStatus}",
                ),
                Text(
                  "PlateNumber: ${widget.item.plateNumber}",
                ),
                Text(
                  "Price: ${widget.item.amount}" + " vnd",
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final price = widget.item.amount ?? 0;
                      _payment(
                        amount: price,
                        fee: 0,
                        description: "Smart - Parking",
                        username: "SmartParking",
                      );
                    },
                    child: Text("Payment"),
                  ),
                )
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
      orderId: getRandomString(10),
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
}
