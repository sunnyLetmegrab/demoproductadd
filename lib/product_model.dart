import 'package:parallex_listivew/attribute_model.dart';

class ProductModel {
  final int variationId;
  final String sku;
  final double price;
  final int quantity;
  final List<AttributeModel> attributes;

  ProductModel({
    required this.variationId,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.attributes,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        variationId: json["variation_id"],
        sku: json["sku"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        attributes: List<AttributeModel>.from(
            json["attributes"].map((x) => AttributeModel.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "variation_id": variationId,
        "sku": sku,
        "price": price,
        "quantity": quantity,
        "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
      };
}
