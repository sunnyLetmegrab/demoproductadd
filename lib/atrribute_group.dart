// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:parallex_listivew/attribute_model.dart';

class AttributeGroup {
  bool selected = false;
  String parent_name;
  int parent_id;
  List<AttributeModel> attributes;
  AttributeModel? selectedAttribute;
  AttributeGroup({
    required this.parent_name,
    required this.attributes,
    required this.parent_id,
  });
  //

  AttributeGroup copyWith({
    bool? selected,
    String? name,
    int? parent_id,
    List<AttributeModel>? attributes,
    AttributeModel? selectedAttribute,
  }) {
    return AttributeGroup(
      parent_name: name ?? this.parent_name,
      parent_id: parent_id ?? this.parent_id,
      attributes: attributes ?? this.attributes,
    )..selectedAttribute = selectedAttribute;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selected': selected,
      'parent_name': parent_name,
      'parent_id': parent_id,
      'values': attributes.map((x) => x.toJson()).toList(),
    };
  }

  factory AttributeGroup.fromMap(Map<String, dynamic> map) {
    return AttributeGroup(
      parent_name: map['parent_name'] as String,
      parent_id: map['parent_id'] as int,
      attributes: List<AttributeModel>.from(
        (map['values'] as List).map<AttributeModel>(
          (x) => AttributeModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AttributeGroup.fromJson(String source) =>
      AttributeGroup.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AttributeGroup(selected: $selected, parent_name: $parent_name, values: $attributes)';

  @override
  bool operator ==(covariant AttributeGroup other) {
    if (identical(this, other)) return true;

    return other.selected == selected &&
        other.parent_name == parent_name &&
        listEquals(other.attributes, attributes);
  }

  @override
  int get hashCode =>
      selected.hashCode ^ parent_name.hashCode ^ attributes.hashCode;
}
