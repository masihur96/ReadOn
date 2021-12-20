import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/subscription_model.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/language_convert.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SubscriptionPlanPage extends StatefulWidget {
  const SubscriptionPlanPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPlanPageState createState() => _SubscriptionPlanPageState();
}

class _SubscriptionPlanPageState extends State<SubscriptionPlanPage> {
  int _count = 0;
  bool _loading = false;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    await ebookApiController.getSubscriptionList();
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    final UserController userController = Get.find();
    if (_count == 0) _customInit(ebookApiController);
    double size = publicController.size.value;
    return Scaffold(
      body: _loading
          ? Padding(
        padding: EdgeInsets.all(size * .045),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Shimmer(
                    interval: const Duration(milliseconds: 500),
                    color: Colors.grey,
                    enabled: true,
                    direction: const ShimmerDirection.fromLeftToRight(),
                    colorOpacity: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: size,
                        height: size * .4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size * .04)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size * .02,
                  )
                ],
              );
            }),
      )

          : ebookApiController.subscriptionList.isNotEmpty
          ? Padding(
        padding: EdgeInsets.all(size * .04),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: ebookApiController.subscriptionList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  _subscriptionPlanCard(
                      size,
                      ebookApiController.subscriptionList[index], userController
                  ),
                  SizedBox(
                    height: size * .01,
                  )
                ],
              );
            }),
      )
          : const Center(child: Text('কোন সাবস্ক্রিপশন প্ল্যান নেই!')),
    );
  }

  /// subscription plan card
  Card _subscriptionPlanCard(double size, SubscriptionModel subscriptionModel,
      UserController userController) =>
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size * .03),
        ),
        child: Container(
          width: size,
          decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(size * .03)),
          child: Column(
            children: [
              Container(
                width: size,
                padding: EdgeInsets.symmetric(
                    vertical: size * .025, horizontal: size * .04),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [CColor.themeColor, CColor.themeColorLite],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size * .03),
                      topRight: Radius.circular(size * .03),
                    )),
                child: Text(
                  subscriptionModel.sTitle!,
                  textAlign: TextAlign.center,
                  style: Style.buttonTextStyle(
                      size * .055, Colors.white, FontWeight.w500),
                ),
              ),
              Container(
                width: size,
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(size * .03)),
                padding: EdgeInsets.symmetric(
                    vertical: size * .03, horizontal: size * .06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '৳ ${enToBnNumberConvert(subscriptionModel.sTaka!)}/-',
                      textAlign: TextAlign.center,
                      style: Style.bodyTextStyle(
                          size * .045, Colors.black, FontWeight.w500),
                    ),
                    SizedBox(
                      height: size * .02,
                    ),
                    Text(
                      subscriptionModel.sDescription!,
                      textAlign: TextAlign.center,
                      style: Style.bodyTextStyle(
                          size * .04, Colors.black, FontWeight.normal),
                    ),
                    SizedBox(
                      height: size * .03,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var currentDate = DateTime.now();
                        var updateDate = subscriptionModel.durationStatus == "month"
                            ? DateTime(currentDate.year, currentDate.month + int.parse(subscriptionModel.duration!), currentDate.day)
                            : subscriptionModel.durationStatus == "day"? DateTime(currentDate.year, currentDate.month, currentDate.day + int.parse(subscriptionModel.duration!))
                            : DateTime(currentDate.year + int.parse(subscriptionModel.duration!), currentDate.month, currentDate.day)
                        ;
                        Map subscriptionMap = {
                          "user_id": userController.userId,
                          "start_date": currentDate.toString(),
                          "end_date": updateDate.toString(),
                          "status" : "1"
                        };
                        print(subscriptionMap);
                        await userController.subscribe(subscriptionMap);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size * .015, horizontal: size * .07),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size * .02),
                            border: Border.all(
                                color: CColor.themeColor, width: size * .005)),
                        child: Text(
                          'সাবস্ক্রিপশন করুন',
                          textAlign: TextAlign.center,
                          style: Style.buttonTextStyle(
                              size * .035, Colors.black, FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
