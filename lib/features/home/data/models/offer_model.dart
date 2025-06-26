class OfferModel {
  String ? name;
  String ? id;
  num ? price;
  String ? carType;


  OfferModel({
    this.name,
    this.id,
    this.price,
    this.carType,
  });


   OfferModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    carType = json['carType'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['price'] = price;
    data['carType'] = carType;
    return data;
  }
}