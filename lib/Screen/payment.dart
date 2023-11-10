// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
 //import 'package:momo_vn/momo_vn.dart';

// class MyMomoPayment extends StatefulWidget {
//   @override 
//   _MyMomoPayment createState() => _MyMomoPayment();
// }

// class _MyMomoPayment extends State<MyMomoPayment> {
//   late MomoVn _momoPay;
//   late PaymentResponse _momoPaymentResult;
//   // ignore: non_constant_identifier_names
//   late String _paymentStatus;
//   @override
//   void initState() {
//     super.initState();
//     _momoPay = MomoVn();
//     _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _paymentStatus = "";
//     initPlatformState();
//   }
//   Future<void> initPlatformState() async {
//     if (!mounted) return;
//       setState(() {
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('THANH TOÁN QUA ỨNG DỤNG MOMO'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               Column(
//                 children: [
//                   TextButton(
//                     // color: Colors.blue,
//                     // textColor: Colors.white,
//                     // disabledColor: Colors.grey,
//                     // disabledTextColor: Colors.black,
//                     // padding: EdgeInsets.all(8.0),
//                     // splashColor: Colors.blueAccent,
//                     child: Text('DEMO PAYMENT WITH MOMO.VN'),
//                     onPressed: () async {
//                       MomoPaymentInfo options = MomoPaymentInfo(
//                           merchantName: "TTN",
//                           appScheme: "MOxx",
//                           merchantCode: 'MOxx',
//                           partnerCode: 'Mxx',
//                           amount: 9999,
//                           orderId: '12321312',
//                           orderLabel: 'Gói combo',
//                           merchantNameLabel: "HLGD",
//                           fee: 10,
//                           description: 'Thanh toán combo',
//                           username: '01234567890',
//                           partner: 'merchant',
//                           extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
//                           isTestMode: true
//                       );
//                       try {
//                         _momoPay.open(options);
//                       } catch (e) {
//                         debugPrint(e.toString());
//                       }
//                     },
//                   ),
//                 ],
//               ),
//               Text(_paymentStatus.isEmpty ? "CHƯA THANH TOÁN" : _paymentStatus)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     _momoPay.clear();
//   }
//   void _setState() {
//     _paymentStatus = 'Đã chuyển thanh toán';
//     if (_momoPaymentResult.isSuccess == true) {
//       _paymentStatus += "\nTình trạng: Thành công.";
//       _paymentStatus += "\nSố điện thoại: " + _momoPaymentResult.phoneNumber.toString();
//       _paymentStatus += "\nExtra: " + _momoPaymentResult.extra!;
//       _paymentStatus += "\nToken: " + _momoPaymentResult.token.toString();
//     }
//     else {
//       _paymentStatus += "\nTình trạng: Thất bại.";
//       _paymentStatus += "\nExtra: " + _momoPaymentResult.extra.toString();
//       _paymentStatus += "\nMã lỗi: " + _momoPaymentResult.status.toString();
//     }
//   }
//   void _handlePaymentSuccess(PaymentResponse response) {
//     setState(() {
//       _momoPaymentResult = response;
//       _setState();
//     });
//     Fluttertoast.showToast(msg: "THÀNH CÔNG: " + response.phoneNumber.toString(), toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handlePaymentError(PaymentResponse response) {
//     setState(() {
//       _momoPaymentResult = response;
//       _setState();
//     });
//     Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString(), toastLength: Toast.LENGTH_SHORT);
//   }
// }

import 'package:flutter/material.dart';

class MyMomoPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Notification'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
      );
}