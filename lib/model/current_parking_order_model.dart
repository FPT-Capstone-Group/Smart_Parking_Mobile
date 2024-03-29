class Autogenerated {
  int? code;
  List<Data>? data;
  bool? success;

  Autogenerated({this.code, this.data, this.success});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? parkingOrderId;
  String? parkingOrderStatus;
  int? parkingOrderAmount;
  String? expiredDate;
  String? createdAt;
  String? updatedAt;
  int? bikeId;
  int? parkingTypeId;

  // Array? cards;

  Data({
    this.parkingOrderId,
    this.parkingOrderStatus,
    this.parkingOrderAmount,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.bikeId,
    this.parkingTypeId,
    //this.cards
  });

  Data.fromJson(Map<String, dynamic> json) {
    parkingOrderId = json['parkingOrderId'];
    parkingOrderStatus = json['parkingOrderStatus'];
    parkingOrderAmount = json['parkingOrderAmount'];
    expiredDate = json['expiredDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bikeId = json['bikeId'];
    parkingTypeId = json['parkingTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parkingOrderId'] = this.parkingOrderId;
    data['parkingOrderStatus'] = this.parkingOrderStatus;
    data['parkingOrderAmount'] = this.parkingOrderAmount;
    data['expiredDate'] = this.expiredDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['bikeId'] = this.bikeId;
    data['parkingTypeId'] = this.parkingTypeId;

    return data;
  }
}
