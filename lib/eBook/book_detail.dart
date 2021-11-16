import 'dart:ui';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/eBook/my_cart_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: _bodyUI(size),
      ),
    );
  }

  Widget _bodyUI(double size) => ListView(
        children: [
          SizedBox(
            width: size,
            height: size * .72,
            child: Stack(
              children: [
                Positioned(
                  top: -size * .47,
                  left: -size * .2,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.grey.shade600,
                      border: Border.all(color: Colors.blueGrey, width: 1.5),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg")),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                ),

                /// book image
                Positioned(
                  top: size * .1,
                  left: size * .1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    margin: EdgeInsets.zero,
                    child: Container(
                      width: size * .4,
                      height: size * .6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(
                            "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),

                /// book online reading price
                Positioned(
                  top: size * .47,
                  right: size * .07,
                  child: Container(
                    width: size * .35,
                    padding: EdgeInsets.symmetric(
                        vertical: size * .01, horizontal: size * .02),
                    decoration: BoxDecoration(
                        color: CColor.themeColor,
                        borderRadius: BorderRadius.circular(size * .04)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          LineAwesomeIcons.mobile_phone,
                          color: Colors.white,
                          size: size * .065,
                        ),
                        SizedBox(
                          width: size * .02,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('ট ৫০ ',
                                  style: Style.bodyTextStyle(size * .045,
                                      Colors.white, FontWeight.w500)),
                              Text('(\$1.00)',
                                  style: Style.bodyTextStyle(size * .035,
                                      Colors.white, FontWeight.w500)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// main book price
                Positioned(
                  top: size * .6,
                  right: size * .07,
                  child: Container(
                    width: size * .35,
                    padding: EdgeInsets.symmetric(
                        vertical: size * .01, horizontal: size * .02),
                    decoration: BoxDecoration(
                        color: CColor.themeColor,
                        borderRadius: BorderRadius.circular(size * .04)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          LineAwesomeIcons.book_open,
                          color: Colors.white,
                          size: size * .065,
                        ),
                        SizedBox(
                          width: size * .02,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ট ১৫০ ',
                                  style: Style.bodyTextStyle(size * .045,
                                      Colors.white, FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size,
                padding: EdgeInsets.only(left: size * .1, right: size * .07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /// book name
                    Expanded(
                        child: Text('একজন মায়াবতী',
                            style: Style.bodyTextStyle(
                                size * .06, Colors.grey, FontWeight.w600))),

                    /// cart
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: CColor.themeColor,
                        )),

                    /// favourite
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                          color: CColor.themeColor,
                        )),

                    /// share
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share,
                          color: CColor.themeColor,
                        )),
                  ],
                ),
              ),
              Container(
                width: size,
                height: size * .5,
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(size*.06), topRight: Radius.circular(size*.06))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// writer image
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: CColor.greenColor,
                                  width: size * .006)),
                          child: CircleAvatar(
                            backgroundImage: const NetworkImage(
                              'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                            ),
                            radius: size * .1,
                          ),
                        ),
                        SizedBox(height: size * .03),

                        /// writer name
                        Text(
                          'হুমায়ুন আহমেদ',
                          style: Style.bodyTextStyle(
                              size * .04, CColor.greenColor, FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      width: size * .05,
                    ),

                    /// writer's book list
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(right: size * .02),
                                child: BookPreview(
                                    bookImageWidth: size * .2,
                                    bookImageHeight: size * .3,
                                    bookImage:
                                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                                    bookName: 'একজন মায়াবতী',
                                    writerName: 'হুমায়ুন আহমেদ'),
                              )),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size,
                child: const Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 1,
                ),
              ),
              SizedBox(height: size * .05),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                width: size,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _bookDetailOption(size, 'বিষয়', 'উপন্যাস'),
                          _bookDetailOption(size, 'পৃষ্ঠা', '০০'),
                          _bookDetailOption(size, 'প্রকাশনী', 'রিডঅন'),
                          _bookDetailOption(
                              size, 'সংস্করণ', 'প্রথম প্রকাশ ২০২০'),
                        ],
                      ),
                    ),

                    /// book description
                    Expanded(
                      child: ExpandableText(
                        'একজন মায়াবতী pdf বাংলা বই। একজন মায়াবতী – হুমায়ূন আহমেদ এর লেখা একটি বাংলা জনপ্রিয় বই। আমাদের টিম তার “একজন মায়াবতী” বইটি সংগ্রহ করেছি এবং আপনাদের জন্য হুমায়ূন আহমেদ (Humayun Ahmed) এর অসাধারণ এই অসাধারণ বইটি শেয়ার করছি  আপনারা খুব সহজের “একজন মায়াবতী” বইটি ডাউনলোড করতে পারবেন অথবা অনলাইনেই পড়ে ফেলতে পারবেন যে কোনো মুহূর্তে।আপনার পছন্দের যে কোনো বই খুব সহজেই পেয়ে যাবেন আমাদের সাইটে । ১২৫ পাতার একজন মায়াবতী বাংলা বইটি (Bangla Boi) স্ক্যন কোয়ালিটি অসাধারণ। বইটি প্রথম প্রকাশিত হয় ২০০৯ সালে এবং বইটি প্রকাশ করে অন্যপ্রকাশ।',
                        expandText: 'আরও পড়ুন',
                        collapseText: 'অল্প পড়ুন',
                        maxLines: 3,
                        linkColor: CColor.greenColor,
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size * .05),
              Container(
                width: size,
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '4.2',
                              style: Style.bodyTextStyle(size * .04,
                                  CColor.greenColor, FontWeight.w500),
                            ),
                            SizedBox(width: size * .015),
                            Icon(
                              Icons.star,
                              color: CColor.greenColor,
                              size: size * .04,
                            )
                          ],
                        ),
                        SizedBox(
                          height: size * .01,
                        ),

                        /// Number of reviews
                        Text(
                          'Review (12)',
                          style: Style.bodyTextStyle(size * .032,
                              CColor.greenColor, FontWeight.normal),
                        )
                      ],
                    ),
                    SizedBox(
                      width: size * .04,
                    ),

                    /// review field
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: Style.bodyTextStyle(
                            size * .045, Colors.black, FontWeight.w400),
                        cursorColor: Colors.black,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: size*.035),
                            fillColor: Colors.pink.shade50,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CColor.themeColor, width: 1),
                              borderRadius: BorderRadius.circular(size * .02),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CColor.themeColor, width: 1),
                              borderRadius: BorderRadius.circular(size * .02),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CColor.themeColor, width: 1),
                              borderRadius: BorderRadius.circular(size * .02),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: CColor.themeColor, width: 1),
                              borderRadius: BorderRadius.circular(size * .02),
                            ),
                            hintText: 'রিভিউ লিখুন',
                            hintStyle: Style.bodyTextStyle(size * .045,
                                Colors.grey.shade600, FontWeight.w400),
                            suffixIcon: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: size * .1,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size * .05),

              /// Review section
              Container(
                width: size,
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// reviewer profile picture
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnELq88FqJJ3fRj93adsIGYvhO-TiVlgimVQ&usqp=CAU'),
                    ),
                    SizedBox(
                      width: size * .04,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(children: [
                              TextSpan(text: 'by '),

                              /// reviewer name
                              TextSpan(
                                  text: 'Silvana Esmeralda',
                                  style: TextStyle(color: CColor.greenColor)),
                            ], style: TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(height: 1.5),

                          /// review point with stars
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: CColor.greenColor,
                                size: size * .04,
                              ),
                              Icon(
                                Icons.star,
                                color: CColor.greenColor,
                                size: size * .04,
                              ),
                              Icon(
                                Icons.star,
                                color: CColor.greenColor,
                                size: size * .04,
                              ),
                              Icon(
                                Icons.star_border,
                                color: CColor.greenColor,
                                size: size * .04,
                              ),
                              Icon(
                                Icons.star_border,
                                color: CColor.greenColor,
                                size: size * .04,
                              ),
                              SizedBox(width: size*.02,),

                              /// review date
                              Text(
                                '5 June 2020',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: size*.03
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 1.5),

                          /// review text
                          Padding(
                            padding: EdgeInsets.only(right: size*.2),
                            child: ExpandableText(
                              'একজন মায়াবতী pdf বাংলা বই। একজন মায়াবতী – হুমায়ূন আহমেদ এর লেখা একটি বাংলা জনপ্রিয় বই। আমাদের টিম তার “একজন মায়াবতী” বইটি সংগ্রহ করেছি এবং আপনাদের জন্য হুমায়ূন আহমেদ (Humayun Ahmed) এর অসাধারণ এই অসাধারণ বইটি শেয়ার করছি  আপনারা খুব সহজের “একজন মায়াবতী” বইটি ডাউনলোড করতে পারবেন অথবা অনলাইনেই পড়ে ফেলতে পারবেন যে কোনো মুহূর্তে।আপনার পছন্দের যে কোনো বই খুব সহজেই পেয়ে যাবেন আমাদের সাইটে । ১২৫ পাতার একজন মায়াবতী বাংলা বইটি (Bangla Boi) স্ক্যন কোয়ালিটি অসাধারণ। বইটি প্রথম প্রকাশিত হয় ২০০৯ সালে এবং বইটি প্রকাশ করে অন্যপ্রকাশ।',
                              expandText: 'আরও পড়ুন',
                              collapseText: 'অল্প পড়ুন',
                              maxLines: 2,
                              linkColor: CColor.greenColor,
                              style: Style.bodyTextStyle(
                                  size * .035, Colors.black, FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size * .05),
              Padding(
               padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: Text(
                  'আবার পড়ুন',
                  style: Style.bodyTextStyle(
                      size * .05, const Color(0xff616161), FontWeight.w700),
                ),
              ),
              Container(
                height: size*.6,
                padding: EdgeInsets.symmetric(horizontal: size*.04),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: size*.06),
                      child: BookPreview(
                          bookImageWidth: size*.26,
                          bookImageHeight: size*.4,
                          bookImage: "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                          bookName: 'একজন মায়াবতী',
                          writerName: 'হুমায়ুন আহমেদ'),
                    )),
              )
            ],
          ),
        ],
      );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: "",
        iconData: LineAwesomeIcons.bars,
        action: [
          Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: publicController.size.value * .08,
          ),
          SizedBox(width: size * .04),
          GestureDetector(
            onTap: () {
              Get.to(() => MyCartPage());
            },
            child: Container(
              width: size * .085,
              height: size * .085,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Icon(
                    LineAwesomeIcons.shopping_cart,
                    color: Colors.white,
                    size: size * .085,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: size * .035,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),

                      /// notification count
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size * .03,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
        scaffoldKey: _scaffoldKey,
      );

  /// book detail option
  Row _bookDetailOption(double size, String title, String value) => Row(
        children: [
          Text(
            '$title : ',
            style:
                Style.bodyTextStyle(size * .035, Colors.black, FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: Style.bodyTextStyle(
                  size * .035,
                  (title == 'পৃষ্ঠা' || title == 'সংস্করণ')
                      ? Colors.black
                      : CColor.greenColor,
                  FontWeight.normal),
            ),
          ),
        ],
      );
}
