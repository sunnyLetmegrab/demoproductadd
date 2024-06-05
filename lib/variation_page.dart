import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parallex_listivew/atrribute_group.dart';
import 'package:parallex_listivew/main.dart';
import 'package:parallex_listivew/varation_item.dart';
import 'package:parallex_listivew/varation_model.dart';
import 'package:collection/collection.dart';

import 'attribute_model.dart';
import 'product_model.dart';

class VariationAddPage extends StatefulWidget {
  final int variationId;
  final int productId;
  VariationAddPage(
      {required this.variationId, required this.productId, super.key});

  @override
  State<VariationAddPage> createState() => _VariationAddPageState();
}

class _VariationAddPageState extends State<VariationAddPage> {
  var listOfattributes = <AttributeGroup>[];
  var prevSelectedAttributes = <String>[];
  var varationList = <VariationModel>[];
  var addedProducts = <ProductModel>[];
  @override
  void initState() {
    super.initState();
    Future.wait([
      getAttributes(),
      getProductFormId(),
      getaddedProduct(),
    ]).then((value) {
      for (int i = 0; i < listOfattributes.length; i++) {
        var item = listOfattributes[i];
        listOfattributes[i].selected =
            prevSelectedAttributes.contains(item.parent_name);
      }

      addedProducts.forEach((element) {
        var allAttributes = [...selectedAttribute];

        allAttributes.forEach((groupItem) {
          var currentGroup = element.attributes
              .firstWhereOrNull((i) => i.parent_id == groupItem.parent_id);
          if (currentGroup != null) {
            groupItem.selectedAttribute = groupItem.attributes.firstWhereOrNull(
                (j) => j.attributeId == currentGroup?.attributeId);
          }
          print(groupItem.selectedAttribute?.toJson());
        });
        print(allAttributes.map((e) => e.selectedAttribute?.toJson()));
        varationList.add(
          VariationModel(attributes: allAttributes)
            ..editable = false
            ..category.text = "1"
            ..price.text = element.price.toString()
            ..quantity.text = element.quantity.toString()
            ..sku.text = element.sku,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    addedProducts.forEach((e) {});
    return Scaffold(
      appBar: AppBar(
        title: const Text("Variant Add Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              horizontalTitleGap: 0,
              minLeadingWidth: 0,
              title: Text("Select Attribute"),
              subtitle: Text(
                  "Below attributes selection shows that it will create variant based on selected attribute"),
            ),
            Divider(),
            Wrap(
              spacing: 20,
              children: listOfattributes
                  .mapIndexed(
                    (index, item) => RawChip(
                      label: Text(
                        item.parent_name,
                        style: TextStyle(
                            color: listOfattributes[index].selected
                                ? Colors.white
                                : Colors.black87),
                      ),
                      backgroundColor: listOfattributes[index].selected
                          ? Colors.black.withOpacity(.7)
                          : Colors.white,
                      onPressed: () {
                        if (prevSelectedAttributes.contains(item.parent_name)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Can not remove previously added product attribute.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          listOfattributes[index].selected =
                              !listOfattributes[index].selected;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    var list = listOfattributes
                        .where((element) => element.selected)
                        .toList();
                    varationList.add(VariationModel(attributes: list));
                  });
                },
                label: Text("Add variant"),
              ),
            ),
            Text(
              "Enter variant details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: varationList.length,
              itemBuilder: (context, index) {
                var item = varationList.elementAt(index);
                return VariationItem(
                  item: item,
                  onAttributeselected: (i, attribute) {
                    setState(() {
                      varationList[index].attributes[i].selectedAttribute =
                          attribute;
                    });
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  List<AttributeGroup> get selectedAttribute =>
      listOfattributes.where((element) => element.selected).toList();

  Future<void> getAttributes() async {
    var response = await dio.get('user/getAttributes');
    setState(() {
      listOfattributes = (response.data['data'] as List)
          .map((e) => AttributeGroup.fromMap(e))
          .toList();
    });
  }

  Future<void> getProductFormId() async {
    var response =
        await dio.get("user/getAttributeByProduct/${widget.variationId}");
    print(response);
    if (response.statusCode == 200) {
      setState(() {
        prevSelectedAttributes = (response.data['data'] as List)
            .map((e) => e["attribute_name"].toString())
            .toList();
      });
    }
  }

  Future<void> getaddedProduct() async {
    var response = await dio.get("user/getProductVaration/${widget.productId}");
    if (response.statusCode == 200) {
      addedProducts = (response.data['data'] as List)
          .map((e) => ProductModel.fromMap(e))
          .toList();
    }
  }

  Future<void> addProductVarationInBulk() async {
    var request = {
      "product_id": widget.productId,
      "variants": varationList.where((element) => element.editable).map((e) => {
            "price": e.price.text,
            "quantity": e.quantity.text,
            "sku": e.sku.text,
            "category_id": 1,
            "attributes": selectedAttribute
                .map((e) => <String, dynamic>{
                      "attribute_id": e.selectedAttribute!.attributeId,
                      "attribute_parent": e.selectedAttribute!.parent_id
                    })
                .toList(),
          }),
    };
    print(request);
    // var response = await dio.post('user/addVariantInbulk', data: request);
  }

  List<AttributeGroup> setSelectedAttributes(
      List<AttributeGroup> attributes, List<AttributeModel> values) {
    var allAttributes = <AttributeModel>[];
    attributes.forEach((element) {
      print(element.parent_name);
      allAttributes.addAll(element.attributes);
    });
    // for (int i = 0; i < allAttributes.length; i++) {
    //   print(allAttributes[i].toJson());
    // }
    return attributes;
  }
}
