import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parallex_listivew/atrribute_group.dart';
import 'package:parallex_listivew/main.dart';
import 'package:parallex_listivew/variation_page.dart';
import 'package:dio/dio.dart';

class AddproductPage extends StatefulWidget {
  const AddproductPage({super.key});

  @override
  State<AddproductPage> createState() => _AddproductPageState();
}

class _AddproductPageState extends State<AddproductPage> {
  var t1 = TextEditingController(),
      t2 = TextEditingController(),
      t3 = TextEditingController(),
      t4 = TextEditingController(),
      t5 = TextEditingController(),
      t6 = TextEditingController(),
      t7 = TextEditingController(),
      t8 = TextEditingController(),
      t9 = TextEditingController();

  var hasVariant = false;

  var attributesGroups = <AttributeGroup>[];
  var selectedAttribute = <AttributeGroup>[];

  var globalKey = GlobalKey();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Has Variant'),
              value: hasVariant,
              onChanged: (value) {
                setState(() {
                  hasVariant = !hasVariant;
                });
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: [
                  TextFormField(
                    controller: t1,
                    decoration: const InputDecoration(hintText: "Product name"),
                  ),
                  TextFormField(
                    controller: t2,
                    decoration:
                        const InputDecoration(hintText: "Product description"),
                  ),
                  TextFormField(
                    controller: t3,
                    decoration: const InputDecoration(hintText: "SKU"),
                  ),
                  TextFormField(
                    controller: t4,
                    decoration: const InputDecoration(hintText: "Price"),
                  ),
                  TextFormField(
                    controller: t5,
                    decoration: const InputDecoration(hintText: "quantity"),
                  ),
                  TextFormField(
                    controller: t6,
                    decoration: const InputDecoration(hintText: "Category"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Attributes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Wrap(
                      spacing: 10,
                      children: attributesGroups.indexed
                          .map(
                            (e) => RawChip(
                              label: Text(e.$2.parent_name),
                              backgroundColor: selectedAttribute.contains(e.$2)
                                  ? Colors.black.withOpacity(.3)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  if (selectedAttribute.contains(e.$2)) {
                                    selectedAttribute.remove(e.$2);
                                  } else {
                                    selectedAttribute.add(e.$2);
                                  }
                                });
                              },
                            ),
                          )
                          .toList()),
                  Column(
                    children: selectedAttribute.indexed
                        .map(
                          (attributes) => DropdownButtonFormField(
                            items: attributes.$2.attributes
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.value),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            value: selectedAttribute[attributes.$1]
                                .selectedAttribute,
                            onChanged: (value) {
                              setState(() {
                                selectedAttribute[attributes.$1]
                                    .selectedAttribute = value;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      saveProduct();
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getAttributes() async {
    var response = await dio.get('user/getAttributes');
    setState(() {
      attributesGroups = (response.data['data'] as List)
          .map((e) => AttributeGroup.fromMap(e))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAttributes();
  }

  saveProduct() async {
    var data = {
      "name": t1.text,
      "description": t2.text,
      "price": t4.text,
      "quantity": t5.text,
      "sku": t3.text,
      "category_id": 1,
      "attributes": selectedAttribute
          .map((e) => <String, dynamic>{
                "attribute_id": e.selectedAttribute!.attributeId,
                "attribute_parent": e.selectedAttribute!.parent_id
              })
          .toList(),
    };
    var respone = await dio.post('user/addVariants', data: data);
    if (respone.statusCode == 200) {
      formKey.currentState!.reset();
      if (hasVariant) {
        var variationId = respone.data["created_variation_id"];
        var productId = respone.data["created_product_id"];
        Navigator.of(globalKey.currentContext!).push(
          MaterialPageRoute(
            builder: (context) => VariationAddPage(
              variationId: variationId,
              productId: productId,
            ),
          ),
        );
      } else {
        showDialog(
          context: globalKey.currentContext!,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Message"),
              content: const Column(
                children: [
                  Text("Product added successfully"),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(globalKey.currentContext!).pop();
                  },
                  child: const Text("Close"),
                )
              ],
            );
          },
        ).then((value) {});
      }
    }
  }
}
