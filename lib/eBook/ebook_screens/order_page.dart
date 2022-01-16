import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import '../../widgets/custom_appbar.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/language_convert.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/public_variables/toast.dart';
import 'package:read_on/widgets/custom_loading.dart';
import 'package:read_on/widgets/solid_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class OrderPage extends StatefulWidget {
  String amount;
  List<String> bookIdList;

  OrderPage({Key? key, required this.amount, required this.bookIdList})
      : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  bool _loading = false;
  bool _orderingBookLoading = false;
  int _count = 0;
  List<String> _divisionList = [];
  int _radioButtonValue = 1;
  double _deliveryCharge = 0;
  String _selectedDivision = "";
  dynamic formData = {};

  void _customInit(PublicController publicController) async {
    setState(() {
      _count++;
      _loading = true;
    });
    await publicController.getDivisionList().then((value) {
      for (int i = 0;
          i < publicController.divisionModel.value.data!.length;
          i++) {
        setState(() {
          _divisionList
              .add(publicController.divisionModel.value.data![i].divisionbn!);
        });
      }
    });
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    final double size = publicController.size.value;
    if (_count == 0) _customInit(publicController);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade50,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(publicController)),
        body:
            _bodyUI(size, publicController, userController, ebookApiController),
      ),
    );
  }

  Widget _bodyUI(
          double size,
          PublicController publicController,
          UserController userController,
          EbookApiController ebookApiController) =>
      Padding(
        padding: EdgeInsets.all(size * .04),
        child: _loading
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size * .4,
                                  height: size * .08,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .3,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .2,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .3,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size * .4,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: size * .45,
                                      height: size * .06,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size * .1,
                                ),
                                Container(
                                  width: size * .4,
                                  height: size * .08,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: size * .1,
                                ),
                                SizedBox(
                                  width: size,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: size * .06,
                                            height: size * .06,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: size * .02),
                                                width: size * .25,
                                                height: size * .04,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: size * .01,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: size * .02),
                                                width: size * .2,
                                                height: size * .04,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: size * .05,
                                            height: size * .05,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: size * .02),
                                            width: size * .25,
                                            height: size * .04,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size * .1,
                                ),
                                Container(
                                  width: size,
                                  height: size * .4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(size * .03),
                                  ),
                                ),
                                SizedBox(
                                  height: size * .04,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: size * .3,
                                    height: size * .1,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'প্রেরণের ঠিকানা',
                    style: Style.bodyTextStyle(
                        size * .05, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'বিভাগ',
                          style: Style.bodyTextStyle(
                              size * .04, Colors.black, FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        width: size * .5,
                        height: size * .1,
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size * .02),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1)),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'বিভাগ নির্বাচন করুন',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          items: _divisionList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: size * .04,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'বিভাগ নির্বাচন করুন';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedDivision = value.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  _customField(
                      size, 'জেলা', "জেলার নাম লিখুন", _districtController),
                  SizedBox(
                    height: size * .04,
                  ),
                  _customField(size, 'উপজেলা/থানা', "উপজেলা/থানার নাম লিখুন",
                      _postOfficeController),
                  SizedBox(
                    height: size * .04,
                  ),
                  _customField(size, 'গ্রাম/মহল্লা/রাস্তা/বাড়ি নম্বর',
                      "গ্রাম/মহল্লা/রাস্তা/বাড়ি নম্বর", _villageController),
                  SizedBox(
                    height: size * .1,
                  ),
                  Text(
                    'পেমেন্ট পদ্ধতি',
                    style: Style.bodyTextStyle(
                        size * .05, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size * .03),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size * .02, vertical: size * .04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(size * .03),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    activeColor: CColor.themeColor,
                                    value: 1,
                                    groupValue: _radioButtonValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioButtonValue = value as int;
                                      });
                                    }),
                                Expanded(
                                  child: Text(
                                    'বিকাশ, নগদ, ব্যাংক ও অন্যান্য',
                                    style: Style.bodyTextStyle(size * .04,
                                        Colors.black, FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                    activeColor: CColor.themeColor,
                                    value: 2,
                                    groupValue: _radioButtonValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _radioButtonValue = value as int;
                                      });
                                    }),
                                Text(
                                  'রিডঅন কয়েন',
                                  style: Style.bodyTextStyle(size * .04,
                                      Colors.black, FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size * .02,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size * .03),
                        side: const BorderSide(color: Colors.grey, width: 0.5)),
                    child: Container(
                      width: size * .98,
                      padding: EdgeInsets.symmetric(vertical: size * .04),
                      child: Column(
                        children: [
                          /// cart cost details
                          _costDetailPreview(
                              size, 'মোট', enToBnNumberConvert(widget.amount)),
                          _costDetailPreview(size, 'ডেলিভারি চার্জ', "০"),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: size * .05),
                            child: Divider(
                              thickness: size * .003,
                              color: Colors.grey,
                            ),
                          ),
                          _costDetailPreview(
                              size,
                              'সর্বমোট',
                              enToBnNumberConvert((double.parse(widget.amount) -
                                      _deliveryCharge)
                                  .toStringAsFixed(2))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _orderingBookLoading
                        ? const CustomLoading()
                        : SolidColorButton(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size * .02, horizontal: size * .1),
                            borderRadius: size * .025,
                            child: Text('অর্ডার করুন',
                                style: Style.buttonTextStyle(
                                    size * .04, Colors.white, FontWeight.w500)),
                            onPressed: () async {
                              // await _paySSLCommerz();
                              setState(() => _orderingBookLoading = true);
                              placeOrder(userController, ebookApiController);
                              setState(() => _orderingBookLoading = false);
                            },
                            bgColor: CColor.themeColor),
                  ),
                ],
              ),
      );

  /// place order function
  void placeOrder(UserController userController,
      EbookApiController ebookApiController) async {
    String randomNumber = const Uuid().v4();
    String orderNumber = randomNumber.substring(30);
    String shippingAddress =
        "${_villageController.text}, ${_postOfficeController.text}, ${_districtController.text}, $_selectedDivision";
    Map<String, dynamic> orderMap = {
      'user_id': userController.userId,
      'order_number': orderNumber,
      'shipping_address': shippingAddress,
      'total_price':
          (double.parse(widget.amount) - _deliveryCharge).toStringAsFixed(2),
      'book_id': widget.bookIdList
    };
    await ebookApiController.orderHardCopyBooks(orderMap);
  }

  /// ssl commerz
  Future<void> _paySSLCommerz() async {
    Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
            //Use the ipn if you have valid one, or it will fail the transaction.
            //ipn_url: "www.ipnurl.com",
            multi_card_name: '',
            currency: SSLCurrencyType.BDT,
            product_category: "Food",
            sdkType: SSLCSdkType.LIVE,
            store_id: "demotest",
            store_passwd: "qwerty",
            total_amount: 400,
            tran_id: DateTime.now().millisecondsSinceEpoch.toString()));
    sslcommerz
        .addEMITransactionInitializer(
            sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
                emi_options: 1, emi_max_list_options: 3, emi_selected_inst: 2))
        .addShipmentInfoInitializer(
            sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
                shipmentMethod: "yes",
                numOfItems: 2,
                shipmentDetails: ShipmentDetails(
                    shipAddress1:
                        "${_villageController.text}, ${_postOfficeController.text}, ${_districtController.text}, $_selectedDivision",
                    shipCity: _villageController.text,
                    shipCountry: "Bangladesh",
                    shipName: "From hub",
                    shipPostCode: '')))
        .addCustomerInfoInitializer(
            customerInfoInitializer: SSLCCustomerInfoInitializer(
                customerState: "Uttara",
                customerName: "Mak bro",
                customerEmail: "makbro@gmail.com",
                customerAddress1: "Uttara",
                customerCity: "Dhaka",
                customerPostCode: '1230',
                customerCountry: "Bangladesh",
                customerPhone: "01610000016"))
        .addProductInitializer(
            sslcProductInitializer:
                // ** ssl product initializer for general product STARTS**
                SSLCProductInitializer(
                    productName: "T-Shirt",
                    productCategory: "All",
                    general: General(
                        general: "General Purpose",
                        productProfile: "Product Profile")))
        .addAdditionalInitializer(
            sslcAdditionalInitializer:
                SSLCAdditionalInitializer(valueA: "SSL_VERIFYPEER_FALSE"));
    var result = await sslcommerz.payNow();
    if (result is PlatformException) {
      print("the response is: " +
          result.message.toString() +
          " code: " +
          result.code);
    } else {
      SSLCTransactionInfoModel model = result;
      //print('Payment Status: ${model.status}');
      //showSuccessMgs('"Transaction Status: ${model.status}"');
      if (model.status == 'VALID') {
      } else {
        showToast('Transaction failed');
      }
    }
  }

  /// app bar
  CustomAppBar _pageAppBar(PublicController publicController) => CustomAppBar(
        title: "অর্ডার করুন",
        iconData: Icons.arrow_back,
        action: const [],
        scaffoldKey: _scaffoldKey,
      );

  /// custom field
  Widget _customField(double size, String title, String hint,
          TextEditingController textEditingController) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Style.bodyTextStyle(
                  size * .04, Colors.black, FontWeight.normal),
            ),
          ),
          SizedBox(
            width: size * .5,
            height: size * .1,
            child: TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: size * .04),
                isDense: false,
                contentPadding: EdgeInsets.only(left: size * .04),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(size * .02),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
              ),
            ),
          ),
        ],
      );

  ///custom cost detail field
  Widget _costDetailPreview(double size, String title, String value) => Padding(
        padding:
            EdgeInsets.symmetric(vertical: size * .01, horizontal: size * .1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Style.bodyTextStyle(
                    size * .04, Colors.black, FontWeight.w500),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: Style.bodyTextStyle(
                        size * .04, Colors.black, FontWeight.w500),
                  ),
                  SizedBox(width: size * .04),
                  Text(
                    'টাকা',
                    style: Style.bodyTextStyle(
                        size * .04, Colors.black, FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
