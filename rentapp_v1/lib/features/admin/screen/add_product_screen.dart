import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentapp_v1/common/custm_textfield.dart';
import 'package:rentapp_v1/common/custom_btn.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:rentapp_v1/constants/utils.dart';
import 'package:rentapp_v1/features/admin/services/admin_service.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  AdminService adminService = AdminService();
  String category = 'Arduino';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  List<String> productCategories = [
    'Arduino',
    'Raspberry Pi',
    'Motors',
    'Relays',
    'LCD',
    'Sensors'
  ];
  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _productNameController.dispose();
  }

  void rentproduct() {
    adminService.rentProduct(
      context: context,
      name: _productNameController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      quantity: double.parse(_quantityController.text),
      category: category,
      images: images,
    );
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          strokeCap: StrokeCap.round,
                          dashPattern: const [10, 4],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  obsCureText: false,
                  controller: _productNameController,
                  hinText: "Product Name",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  obsCureText: false,
                  controller: _descriptionController,
                  hinText: "Description",
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obsCureText: false,
                  controller: _priceController,
                  hinText: "Price",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obsCureText: false,
                  controller: _quantityController,
                  hinText: "Quantity",
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    onChanged: (String? newval) {
                      setState(() {
                        category = newval!;
                      });
                    },
                    items: productCategories.map(
                      (String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      },
                    ).toList(),
                    value: category,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  color: Colors.amberAccent,
                  text: "Rent",
                  onTap: () {
                    if (_addProductFormKey.currentState!.validate() &&
                        images.isNotEmpty) {
                      rentproduct();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
