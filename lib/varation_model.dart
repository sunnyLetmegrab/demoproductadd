// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'atrribute_group.dart';

class VariationModel {
  TextEditingController sku = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController category = TextEditingController();
  List<AttributeGroup> attributes;
  bool editable=true;
  VariationModel({
    required this.attributes,
  });

  @override
  String toString() {
    return 'VariationModel(sku: $sku, price: $price, quantity: $quantity, category: $category, attributes: $attributes)';
  }

  @override
  bool operator ==(covariant VariationModel other) {
    if (identical(this, other)) return true;

    return other.sku == sku &&
        other.price == price &&
        other.quantity == quantity &&
        other.category == category &&
        listEquals(other.attributes, attributes);
  }

  @override
  int get hashCode {
    return sku.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        attributes.hashCode;
  }
}
