// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:parallex_listivew/varation_model.dart';

import 'atrribute_group.dart';
import 'attribute_model.dart';

class VariationItem extends StatelessWidget {
  final VariationModel item;
  final Function(int index, AttributeModel attribute)? onAttributeselected;
  const VariationItem({
    super.key,
    required this.item,
    this.onAttributeselected,
  });

  @override
  Widget build(BuildContext context) {
    print(item.attributes.map((e) => e.selectedAttribute?.toJson()));
    return AbsorbPointer(
      absorbing: !item.editable,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: item.sku,
                      decoration: const InputDecoration(hintText: "SKU"),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: item.price,
                      decoration: const InputDecoration(hintText: "Price"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: item.quantity,
                      decoration: const InputDecoration(hintText: "quantity"),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: item.category,
                      decoration: const InputDecoration(hintText: "Category"),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 20,
                children: item.attributes
                    .mapIndexed((index, selectedAttributes) => SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: selectedAttributes.attributes.isNotEmpty
                              ? DropdownButton(
                                  items: selectedAttributes.attributes
                                      .mapIndexed(
                                        (innerIndex, e) =>
                                            DropdownMenuItem<AttributeModel>(
                                          child: Text(e.value),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  value: item.attributes[index]
                                              .selectedAttribute !=
                                          null
                                      ? item.attributes[index].selectedAttribute
                                      : null,
                                  onChanged: (value) {
                                    onAttributeselected?.call(index, value!);
                                  },
                                  hint: const Text("Select attributes"),
                                )
                              : SizedBox(),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
