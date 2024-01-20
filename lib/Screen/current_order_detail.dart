import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:parking_auto/Screen/homee.dart';
import 'package:parking_auto/Screen/list_parking_order.dart';
import 'package:parking_auto/controller/get_current_parking_ordert_controller.dart';
import 'package:parking_auto/controller/payment_by_cash_controller.dart';
import 'package:parking_auto/controller/payment_order_parking_controller.dart';
import 'package:parking_auto/model/listParkingOrder_model.dart';
import 'package:uuid/uuid.dart';

class CurrentOrderDetail extends StatefulWidget {
  const CurrentOrderDetail(this.item, {super.key});

  final Data item;

  @override
  State<CurrentOrderDetail> createState() => _CurrentOrderDetail();
}

class _CurrentOrderDetail extends State<CurrentOrderDetail> {
  PaymentParkingOrderController getData = PaymentParkingOrderController();
  bool ParkingOrder = true;
  bool pay = false;
  GetListCurrentParkingOrderController getListOwner =
      GetListCurrentParkingOrderController();

  dynamic plateNumber;
  var token;
  var parkingOrderId;
  var paymentAmount;

  late MomoVn _momoPay;
  late PaymentResponse _momoPaymentResult;
  //late String _paymentStatus;
  bool paymentButton = false;
  bool _isLoading = false;

  //late BuildContext _context;

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
    // _paymentStatus = "";
    //  if (widget.item.expiredDate != null) {
    //   String date = widget.item.expiredDate.toString();
    //   DateTime parseDate =
    //       new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    //   var inputDate = DateTime.parse(parseDate.toString());
    //   var outputFormat = DateFormat('yyyy-MM-dd');
    //   var outputDate = outputFormat.format(inputDate);
    //   widget.item.expiredDate = outputDate;
    //  }
    if (widget.item.parkingOrderStatus == "pending") {
      pay = true;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Current Order Detail'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeNavBar());
          },
          icon: const Icon(Icons.home),
        ),
        actions: const [Icon(Icons.details)],
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 10),
                      //const Divider(color: Colors.green),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Order Information',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 204, 43, 43),
                              ),
                            ),
                            const Divider(color: Colors.green),
                            Container(height: 5),
                            Text('Status: ${widget.item.parkingOrderStatus}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[700])),
                            Text('Amount:  ${widget.item.parkingOrderAmount}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[700])),
                            Text('Expired Date: ${widget.item.expiredDate}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[700])),

                            //      Text('cards:  ${widget.item.cards}',
                            // style: TextStyle(
                            //     fontSize: 15, color: Colors.grey[700])),
                            const SizedBox(height: 10),
                            const Divider(color: Colors.green),
                            const SizedBox(height: 10),

                            //   const SizedBox(height: 10),

                            Center(
                              child: Visibility(
                                  child: FloatingActionButton.extended(
                                    onPressed: () {
                                      paymentAmount =
                                          widget.item.parkingOrderAmount;
                                      // parkingOrderId = widget.item.parkingOrderId;

                                      //  final price = widget.item.parkingOrderAmount ?? 0;
                                      // print("price: $price");
                                      _payment(
                                        amount: paymentAmount,
                                        fee: 0,
                                        description: "Smart - Parking",
                                        username: "SmartParking",
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.change_circle_outlined),
                                    label: const Text('Pay by momo'),
                                  ),
                                  visible: pay),
                            ),
                            const SizedBox(height: 10),

                            Center(
                              child: Visibility(
                                  child: FloatingActionButton.extended(
                                    onPressed: () {
                                      paymentAmount =
                                          widget.item.parkingOrderAmount;
                                      parkingOrderId =
                                          widget.item.parkingOrderId;
                                     // var transactionId = "cash";
                                      var uutransactionIdid = Uuid().v1();

                                    //  uutransactionIdid.v1(); //
                                      PaymentParkingOrderByCashController
                                          payByCash =
                                          PaymentParkingOrderByCashController();
                                      payByCash.submitPaymentByCash(
                                          amount: paymentAmount.toString(),
                                          transactionId: uutransactionIdid.toString(),
                                          parkingOrderId:
                                              parkingOrderId.toString());
                                    },
                                    icon: const Icon(
                                        Icons.change_circle_outlined),
                                    label: const Text('Pay by cash'),
                                  ),
                                  visible: pay),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 5)
                    ],
                  ),
                ),
              )),
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

      // appScheme: "",
      // merchantCode: '',
      // partnerCode: '',

      amount: amount,
      orderId: widget.item.parkingOrderId.toString(),
      fee: 0,
      description: "no",
      username: "0867698543",
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
    //_paymentStatus = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess == true) {
      //  print("resule");
      // print(_momoPaymentResult.toString());
      // print("payment respone");
      // print(_momoPaymentResult.data);
      //  print("payment message");
      //  print(_momoPaymentResult.message);
      // print("extra");

      // _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;

      print("thanh cong");
      // print("amout: ${paymentAmount}");
      // print("token: ${token}");
      // print("parkingOrderId: ${parkingOrderId}");

      final rs = await getData.submitPaymentMomo(
          // amount: widget.item.amount ?? 0,
          // registrationId: widget.item.registrationId ?? 0,

          amount: paymentAmount.toString(),
          transactionId: token,
          parkingOrderId: parkingOrderId.toString());

      await _showToast(rs);
      Get.to(const ListParkingOrder());
      // if (rs == true) {
      //   Navigator.pop(_context, true);
      //   Get.to(const BikeOfUser());
      // }

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
      token = _momoPaymentResult.token;
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
