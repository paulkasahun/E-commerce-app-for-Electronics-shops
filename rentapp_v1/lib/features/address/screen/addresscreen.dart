import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentapp_v1/common/custm_textfield.dart';
import 'package:rentapp_v1/common/custom_btn.dart';
import 'package:rentapp_v1/constants/globalvariables.dart';
import 'package:pay/pay.dart';
import 'package:rentapp_v1/constants/utils.dart';
import 'package:rentapp_v1/features/address/service/address_service.dart';
import 'package:rentapp_v1/providers/user_provider.dart';

enum Percentage {
  T,
  S,
  F,
  M,
}

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final _addressFormkey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  Percentage percentage = Percentage.T;
  final AdressService adressService = AdressService();

  @override
  void dispose() {
    super.dispose();
    streetController.dispose();
    houseController.dispose();
    townController.dispose();
    pincodeController.dispose();
  }

  String addressTobeUsed = "";
  void onGooglePayResult(res) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user.address.isEmpty) {
      adressService.saveUserAddress(context: context, address: addressTobeUsed);
    }
    //watch
    adressService.placeOrder(
      context: context,
      address: addressTobeUsed,
      userName: user.name,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressTobeUsed = "";
    bool isForm = houseController.text.isNotEmpty ||
        streetController.text.isNotEmpty ||
        townController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormkey.currentState!.validate()) {
        addressTobeUsed =
            '${houseController.text},${streetController.text},${townController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressTobeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "ERROR");
    }
  }

  @override
  void initState() {
    //watch
    paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    //  final user = context.watch<UserProvider>().user;
    double sum = 0.0;
    if (percentage == Percentage.T) {
      // double sum = 0.0;
      user.cart
          .map(
            (e) => sum += e['quantity'] * e['product']['price'] * 0.15,
          )
          .toList();
    } else if (percentage == Percentage.S) {
      user.cart
          .map(
            (e) => sum += e['quantity'] * e['product']['price'] * 0.2,
          )
          .toList();
    } else if (percentage == Percentage.F) {
      user.cart
          .map(
            (e) => sum += e['quantity'] * e['product']['price'] * 0.25,
          )
          .toList();
    } else {
      user.cart
          .map(
            (e) => sum += e['quantity'] * e['product']['price'] * 0.4,
          )
          .toList();
    }

    void showRentalFee(context) {
      showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Amount of Rental Fee for selected products",
                  style: GoogleFonts.roboto(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  '$sum ETB',
                  style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      );
    }

    var address = context.watch<UserProvider>().user.address;
    // List<int> days = [3, 7, 15, 30];
    //  String addressToBeUsed = "";
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                        top: 10,
                        bottom: 0,
                      ),
                      child: Text(
                        "Choose number of Rental days",
                        style: GoogleFonts.roboto(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      title: const Text("Three days"),
                      leading: Radio(
                        value: Percentage.T,
                        groupValue: percentage,
                        onChanged: (Percentage? val) {
                          setState(() {
                            percentage = val!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("seven days"),
                      leading: Radio(
                        value: Percentage.S,
                        groupValue: percentage,
                        onChanged: (Percentage? val) {
                          setState(() {
                            percentage = val!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("Two weeks"),
                      leading: Radio(
                        value: Percentage.F,
                        groupValue: percentage,
                        onChanged: (Percentage? val) {
                          setState(() {
                            percentage = val!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("Month"),
                      leading: Radio(
                        value: Percentage.M,
                        groupValue: percentage,
                        onChanged: (Percentage? val) {
                          setState(() {
                            percentage = val!;
                          });
                        },
                      ),
                    ),
                    CustomTextField(
                      obsCureText: false,
                      controller: houseController,
                      hinText: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        obsCureText: false,
                        controller: streetController,
                        hinText: "Area, street"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        obsCureText: false,
                        controller: townController,
                        hinText: "Town/City"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      obsCureText: false,
                      controller: pincodeController,
                      hinText: "Pin Code",
                    ),
                  ],
                ),
              ),
              GooglePayButton(
                width: double.infinity,
                onPressed: () => payPressed(address),

                // ignore: deprecated_member_use
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 50,
                type: GooglePayButtonType.pay,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                color: Colors.deepPurpleAccent,
                text: "Show Rental Fee",
                onTap: () => showRentalFee(context),
              ),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
    );
  }
}
