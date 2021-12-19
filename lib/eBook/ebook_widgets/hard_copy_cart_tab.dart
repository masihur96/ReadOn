import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/cart_model.dart';
import 'package:read_on/eBook/ebook_widgets/cart_card.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/language_convert.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/custom_loading.dart';
import 'package:read_on/widgets/solid_button.dart';

class HardCopyCartTab extends StatefulWidget {
  @override
  _HardCopyCartTabState createState() => _HardCopyCartTabState();
}

class _HardCopyCartTabState extends State<HardCopyCartTab> {

  int _count = 0;
  bool _loading = false;
  List<CartData> _cartList = [];
  int numberOfBooks = 1;
  double totalAmount = 0;
  double promoCodeDiscount = 0;
  bool _workingLoading = false;
  final TextEditingController _promoCodeController = TextEditingController();

  void _customInit(UserController userController, EbookApiController ebookApiController) async {
    _count ++;
    setState(() => _loading = true);
    await ebookApiController.getHardCopyCartList(userController).then((value) {
      setState((){
        _cartList = ebookApiController.cartModel.value.data!;
        _loading = false;
      });
      for(int i=0; i<_cartList.length; i++){
        setState(() => totalAmount += double.parse(_cartList[i].cartSubTotalPrice!));
      }
    });

    // ignore: avoid_print
    print('ebook cart list length = ${ebookApiController.cartModel.value.data!.length}');
  }


  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final UserController userController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    if(_count == 0) _customInit(userController, ebookApiController);
    double size = publicController.size.value;
    return Scaffold(
      body: Stack(
        children: [
          _bodyUI(size, ebookApiController),
          Visibility(
            visible: _workingLoading? true: false,
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black38,
              child: const CustomLoading(),
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyUI(double size, EbookApiController ebookApiController) => SingleChildScrollView(
    child: _cartList.isEmpty? const SizedBox() : Column(
      children: [
        ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) => CartCard(
                bookImage:
                "${ebookApiController
                    .domainName}/public//frontend/images/book_thumbnail/${ebookApiController.cartModel.value.data![index].cartbook![0].bookThumbnail}",
                bookName: ebookApiController.cartModel.value.data![index].cartbook![0].name!,
                writerName: 'হুমায়ুন আহমেদ',
                amount: enToBnNumberConvert(ebookApiController.cartModel.value.data![index].cartSubTotalPrice!),
                bookCopyType: 'হার্ডকপি',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            setState(() {
                              if(numberOfBooks>1) numberOfBooks--;
                            });
                          });
                        },
                        child: const Icon(
                          Icons.remove_circle_outline,
                          color: CColor.themeColor,
                        ),
                      ),
                      SizedBox(width: size*.03,),
                      Text(
                        numberOfBooks.toString(),
                        style: Style.bodyTextStyle(
                            size * .04, Colors.black, FontWeight.w500),
                      ),
                      SizedBox(width: size*.03,),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            numberOfBooks++;
                          });
                          setState(() {
                            _workingLoading = true;
                          });
                          Map cartUpdateMap = {
                            "id" : ebookApiController.cartModel.value.data![index].cartId,
                            "quantity" : numberOfBooks.toString(),
                            "sub_total_price" : (double.parse(ebookApiController.cartModel.value.data![index].cartbook![0].sellingPriceHardcopy!) * numberOfBooks).toString()
                          };
                          await ebookApiController.updateCartQuantity(cartUpdateMap);
                          setState(() {
                            _workingLoading = false;
                          });
                        },
                        child: const Icon(
                          Icons.add_circle_outline,
                          color: CColor.themeColor,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() => _workingLoading = true);
                      await ebookApiController.deleteCart(ebookApiController.cartModel.value.data![index].cartId!);
                      setState((){
                        totalAmount = 0;
                        _cartList.removeAt(index);
                        if(_cartList.isNotEmpty){
                          for(int i=0; i<_cartList.length; i++){
                            totalAmount += double.parse(_cartList[i].cartSubTotalPrice!);
                          }
                        }
                        _workingLoading = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(size * .02),
                      child: Icon(
                        CupertinoIcons.delete_simple,
                        color: Colors.grey,
                        size: size * .08,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(height: size*.05,),

        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size * .02),
                        side: const BorderSide(color: Colors.red)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: TextFormField(
                              controller: _promoCodeController,
                              textAlign: TextAlign.center,
                              style: Style.bodyTextStyle(size * .045, Colors.black, FontWeight.w400),
                              cursorColor: Colors.black,
                              autofocus: false,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'প্রমো কোড',
                                hintStyle: Style.bodyTextStyle(size * .045, Colors.grey.shade600, FontWeight.w400),
                              ),
                            )),
                        GestureDetector(
                          onTap: () async {
                            print('clicked');
                            setState(() => _workingLoading = true);
                            await ebookApiController.getPromoCodeDiscount(_promoCodeController.text);
                            setState(() {
                              if(ebookApiController.promoCodeDiscount.value != "0"){
                                promoCodeDiscount = totalAmount * (double.parse(ebookApiController.promoCodeDiscount.value) / 100);
                                print('promo code discount  = ${promoCodeDiscount.toStringAsFixed(2)}');
                              }
                              else{
                                promoCodeDiscount = 0;
                              }
                              _promoCodeController.clear();
                              _workingLoading = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size * .06, vertical: size * .03),
                            decoration: BoxDecoration(
                                color: CColor.themeColor,
                                border: Border.all(
                                  color: CColor.themeColor,
                                ),
                                borderRadius:
                                BorderRadius.circular(size * .02)),
                            child: Text(
                              'প্রয়োগ',
                              style: Style.bodyTextStyle(
                                  size * .045, Colors.white, FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.pink.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(size*.08),
                            topRight: Radius.circular(size*.08),
                            bottomRight: Radius.circular(size*.06),
                            bottomLeft: Radius.circular(size*.05)
                        ),
                        side: const BorderSide(color: Colors.red)),
                    child: Container(
                      width: size*.98,
                      padding: EdgeInsets.symmetric(vertical: size*.04),
                      child: Column(
                        children: [

                          /// cart cost details
                          _costDetailPreview(size, 'মোট :', enToBnNumberConvert(totalAmount.toStringAsFixed(2))),
                          _costDetailPreview(size, 'ডিসকাউন্ট :', enToBnNumberConvert(promoCodeDiscount.toStringAsFixed(2))),
                          Divider(
                            thickness: size*.003,
                            color: Colors.red,
                          ),
                          _costDetailPreview(size, 'সর্বমোট :', enToBnNumberConvert((totalAmount - promoCodeDiscount).toStringAsFixed(2))),
                        ],
                      ),
                    ),

                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -size*.09,
              child: SolidColorButton(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: size * .03,
                      horizontal: size * .16),
                  borderRadius: size * .025,
                  child: Text('কিনুন',
                      style: Style.buttonTextStyle(size*.05, Colors.white, FontWeight.w500)),
                  onPressed: () {
                  },
                  bgColor: CColor.themeColor),
            ),
          ],
        ),
        SizedBox(height: size*.2,),
      ],
    ),
  );

  Widget _costDetailPreview(double size, String title, String value) => Padding(
    padding: EdgeInsets.symmetric(vertical: size * .01),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: size * .2),
            child: Text(
              title,
              style: Style.bodyTextStyle(
                  size * .04, Colors.black, FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: size * .1),
            child: Row(
              children: [
                Text(
                  value,
                  style: Style.bodyTextStyle(size * .04, Colors.black, FontWeight.w500),
                ),
                SizedBox(width: size * .04),
                Text(
                  'টাকা',
                  style: Style.bodyTextStyle(size * .04, Colors.black, FontWeight.w500),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
