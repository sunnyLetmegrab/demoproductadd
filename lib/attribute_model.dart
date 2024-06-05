class AttributeModel {
  int attributeId;
  int parent_id;

  String value;
  bool selected = false;

  AttributeModel({
    required this.attributeId,
    required this.parent_id,
    required this.value,
  });

  factory AttributeModel.fromJson(Map<String, dynamic> json) => AttributeModel(
        attributeId: json["attribute_id"],
        parent_id: json["parent_id"],
        value: json["value"] ?? json['attribute_value'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "attribute_id": attributeId,
        "name": parent_id,
        "value": value,
      };
}
