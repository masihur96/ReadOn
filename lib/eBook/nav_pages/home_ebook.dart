import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/eBook/more_books_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/gradient_button.dart';

class HomePageEbook extends StatefulWidget {
  const HomePageEbook({Key? key}) : super(key: key);

  @override
  State<HomePageEbook> createState() => _HomePageEbookState();
}

class _HomePageEbookState extends State<HomePageEbook> {
  int _sliderIndex = 0;
  int _tappedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size * .05),
            Container(
                width: size,
                height: size * .4,
                padding: EdgeInsets.symmetric(horizontal: size * .03),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * .02)),
                child: Carousel(
                  showIndicator: false,
                  borderRadius: true,
                  onImageChange: (x, index) {
                    setState(() => _sliderIndex = index);
                  },
                  images: [
                    ClipRRect(
                      child: Image.network(
                        'https://www.newagebd.com/files/records/news/202009/115828_140.jpg',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(size * .02),
                    ),
                    ClipRRect(
                        child: Image.network(
                            'https://cdn.dribbble.com/users/1954067/screenshots/6304914/3_4x.png?compress=1&resize=400x300',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(size * .02)),
                    ClipRRect(
                        child: Image.network(
                            'https://2.bp.blogspot.com/-CRSDzOvxXBU/Wn3gvRdDbMI/AAAAAAAASds/-VHI6eYdQco4Cs9ck9NvFXedUOLmzwwEACLcBGAs/s1600/boi%2Bmela.jpg',
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(size * .02)),
                  ],
                )),
            SizedBox(height: size * .02),
            SizedBox(
              height: size * .04,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) => Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: index == _sliderIndex
                                ? size * .025
                                : size * .02,
                            color: index == _sliderIndex
                                ? CColor.themeColor
                                : Colors.black38,
                          ),
                          SizedBox(
                            width: size * .015,
                          )
                        ],
                      )),
            ),
            SizedBox(height: size * .04),

            /// best seller section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'বেস্ট সেলার (সর্বাধিক বিক্রিত)',
                      style: Style.headerTextStyle(
                          size * .05, Colors.black, FontWeight.normal),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                            Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .03),
                    child: Text(
                      'আরও',
                      style: Style.headerTextStyle(
                          size * .035, Colors.black, FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1526455811l/40130315._SY475_.jpg",
                        bookName: 'রেশমি রেশমি রেশমি রেশমি রেশমি',
                        writerName: 'এমদাদুল হক মিলন রহমান তপু'),
                  )
              ),
            ),
            SizedBox(height: size * .02),

            /// free books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'ফ্রি বই',
                      style: Style.headerTextStyle(
                          size * .05, Colors.black, FontWeight.normal),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> MoreBooksPage(title: 'ফ্রি বই', categoryId: 101,));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.headerTextStyle(
                            size * .035, Colors.black, FontWeight.normal),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-6JwjMDVsKmc/XPtVOfDzC4I/AAAAAAAAWlk/qvzj5UKCcHYG66x0QcGTEeiVxWl7gkkIACLcBGAs/s1600/Nirbachita%2B100%2BKabita%2Bby%2Bby%2BNirmalendu%2BGoon.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://bdebooks.com/wp-content/uploads/2019/09/Rakhali-Gaan-By-Jasim-Uddin-185x278.jpg",
                        bookName: 'রেশমি',
                        writerName: 'এমদাদুল হক মিলন'),
                  )
              ),
            ),
            SizedBox(height: size * .02),

            /// today's attraction
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Text(
                'আজকের আকর্ষণ',
                style: Style.headerTextStyle(
                    size * .05, Colors.black, FontWeight.normal),
              ),
            ),
            SizedBox(height: size * .02),
            Container(
              width: size,
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05)),
              padding: EdgeInsets.symmetric(
                  horizontal: size * .03, vertical: size * .045),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: EdgeInsets.zero,
                        child: Container(
                          width: size * .35,
                          height: size * .55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.network(
                                'https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: size * .05,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'একজন মায়াবতী',
                              style: Style.headerTextStyle(
                                  size * .05, Colors.black, FontWeight.w500),
                            ),
                            Text(
                              'হুমায়ুন আহমেদ',
                              style: Style.headerTextStyle(size * .045,
                                  Colors.grey.shade600, FontWeight.normal),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(size * .4),
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: size * .005)),
                              padding: EdgeInsets.symmetric(
                                  vertical: size * .005,
                                  horizontal: size * .04),
                              child: Text(
                                'উপন্যাস',
                                style: Style.bodyTextStyle(size * .035,
                                    Colors.black, FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: Style.bodyTextStyle(size * .045,
                                      Colors.grey.shade600, FontWeight.normal),
                                  children: [
                                    TextSpan(
                                      text: '৳',
                                      style: Style.bodyTextStyle(size * .07,
                                          CColor.themeColor, FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: '৩০ ',
                                      style: Style.headerTextStyle(size * .07,
                                          CColor.themeColor, FontWeight.normal),
                                    ),
                                    TextSpan(
                                      text: '৳৫৫',
                                      style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: size*.04
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' (\$0.99)',
                                      style: Style.bodyTextStyle(size * .035,
                                          Colors.black, FontWeight.normal),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: GradientButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'পড়ুন',
                                        style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
                                      ),
                                      SizedBox(width: size*.04,),
                                      const Icon(
                                        Icons.double_arrow_outlined,
                                      ),
                                    ],
                                  ),
                                  onPressed: (){},
                                  borderRadius: size*.01,
                                  height: size*.1,
                                  width: size*.25,
                                  gradientColors: const [CColor.themeColor, CColor.themeColorLite]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size * .03,
                  ),
                  Text(
                    'বইটি মানব প্রকৃতি এবং সম্পর্কের বেড়াজাল নিয়ে শব্দের রং তুলিতে আঁকা জীবনের গল্প। জটিল মানব মনের জটিল ভাবাবেগ তুলে ধরা হয়েছে গল্পটিতে। আধুনিক ধারার লোক দেখানো আর চাটুকারিতা ছাপিয়ে ভালোবাসাকে একটা নতুন মাত্রা দেওয়া হয়েছে। যে ভালোবাসা ধরা যায় না,ছোঁয়া যায় না। শুধু অন্তর দিয়ে অনুভব করতে হয়।',
                    maxLines: 3,
                    style: Style.bodyTextStyle(size*.04, Colors.grey.shade800, FontWeight.normal),
                  )
                ],
              ),
            ),
            SizedBox(height: size * .03),

            /// special offers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'বিশেষ ছাড়',
                      style: Style.headerTextStyle(
                          size * .05, Colors.black, FontWeight.normal),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                            Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .03),
                    child: Text(
                      'আরও',
                      style: Style.headerTextStyle(
                          size * .035, Colors.black, FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: size * .06),
                        child: BookPreview(
                            bookImageWidth: size * .26,
                            bookImageHeight: size * .4,
                            bookImage:
                                "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                            bookName: 'একজন মায়াবতী',
                            writerName: 'হুমায়ুন আহমেদ'),
                      )),
            ),
            SizedBox(height: size * .02),

            /// book of the month
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Text(
                'এ মাসের সেরা',
                style: Style.headerTextStyle(
                    size * .05, Colors.black, FontWeight.normal),
              ),
            ),
            SizedBox(height: size * .02),
            Container(
              width: size,
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05)),
              padding: EdgeInsets.symmetric(
                  horizontal: size * .03, vertical: size * .045),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: EdgeInsets.zero,
                        child: Container(
                          width: size * .35,
                          height: size * .55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.network(
                                'https://i.pinimg.com/236x/49/72/b9/4972b95c652c85762429f9c48e6727dc.jpg',
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: size * .05,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'একজন মায়াবতী',
                              style: Style.headerTextStyle(
                                  size * .05, Colors.black, FontWeight.w500),
                            ),
                            Text(
                              'হুমায়ুন আহমেদ',
                              style: Style.headerTextStyle(size * .045,
                                  Colors.grey.shade600, FontWeight.normal),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(size * .4),
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: size * .005)),
                              padding: EdgeInsets.symmetric(
                                  vertical: size * .005,
                                  horizontal: size * .04),
                              child: Text(
                                'উপন্যাস',
                                style: Style.bodyTextStyle(size * .035,
                                    Colors.black, FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: Style.bodyTextStyle(size * .045,
                                      Colors.grey.shade600, FontWeight.normal),
                                  children: [
                                    TextSpan(
                                      text: '৳',
                                      style: Style.bodyTextStyle(size * .07,
                                          CColor.themeColor, FontWeight.w500),
                                    ),
                                    TextSpan(
                                      text: '৩০ ',
                                      style: Style.headerTextStyle(size * .07,
                                          CColor.themeColor, FontWeight.normal),
                                    ),
                                    TextSpan(
                                      text: '৳৫৫',
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: size*.04
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' (\$0.99)',
                                      style: Style.bodyTextStyle(size * .035,
                                          Colors.black, FontWeight.normal),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                    ),
                                  ],
                                ),
                                GradientButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'পড়ুন',
                                          style: Style.buttonTextStyle(size*.04, Colors.white, FontWeight.w500),
                                        ),
                                        SizedBox(width: size*.04,),
                                        const Icon(
                                          Icons.double_arrow_outlined,
                                        ),
                                      ],
                                    ),
                                    onPressed: (){},
                                    borderRadius: size*.01,
                                    height: size*.1,
                                    width: size*.25,
                                    gradientColors: const [CColor.themeColor, CColor.themeColorLite])
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size * .04,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                            ExpandableText(
                              'একজন মায়াবতী pdf বাংলা বই। একজন মায়াবতী – হুমায়ূন আহমেদ এর লেখা একটি বাংলা জনপ্রিয় বই। আমাদের টিম তার “একজন মায়াবতী” বইটি সংগ্রহ করেছি এবং আপনাদের জন্য হুমায়ূন আহমেদ (Humayun Ahmed) এর অসাধারণ এই অসাধারণ বইটি শেয়ার করছি  আপনারা খুব সহজের “একজন মায়াবতী” বইটি ডাউনলোড করতে পারবেন অথবা অনলাইনেই পড়ে ফেলতে পারবেন যে কোনো মুহূর্তে।আপনার পছন্দের যে কোনো বই খুব সহজেই পেয়ে যাবেন আমাদের সাইটে । ১২৫ পাতার একজন মায়াবতী বাংলা বইটি (Bangla Boi) স্ক্যন কোয়ালিটি অসাধারণ। বইটি প্রথম প্রকাশিত হয় ২০০৯ সালে এবং বইটি প্রকাশ করে অন্যপ্রকাশ।',
                              expandText: 'আরও পড়ুন',
                              collapseText: 'অল্প পড়ুন',
                              maxLines: 2,
                              linkColor: CColor.greenColor,
                              style: Style.bodyTextStyle(
                                  size * .035, Colors.black, FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size * .03),

            /// new books section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'নতুন বই',
                      style: Style.headerTextStyle(
                          size * .05, Colors.black, FontWeight.normal),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                            Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .03),
                    child: Text(
                      'আরও',
                      style: Style.headerTextStyle(
                          size * .035, Colors.black, FontWeight.normal),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: size * .06),
                        child: BookPreview(
                            bookImageWidth: size * .26,
                            bookImageHeight: size * .4,
                            bookImage:
                                "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                            bookName: 'একজন মায়াবতী',
                            writerName: 'হুমায়ুন আহমেদ'),
                      )),
            ),
            SizedBox(height: size * .02),

            /// famous writers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'জনপ্রিয় লেখক',
                      style: Style.headerTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                            Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .03),
                    child: Text(
                      'আরও',
                      style: Style.bodyTextStyle(
                          size * .035, Colors.black, FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .5,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: size * .04),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                /// writer image
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: _tappedIndex == index
                                              ? CColor.themeColor
                                              : Colors.white,
                                          width: size * .005)),
                                  child: CircleAvatar(
                                    backgroundImage: const NetworkImage(
                                      'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                                    ),
                                    radius: size * .12,
                                  ),
                                ),
                                SizedBox(height: size * .015),

                                /// writer name
                                SizedBox(
                                  width: size*.3,
                                  child: Text(
                                    'হুমায়ুন আহমেদ',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: Style.bodyTextStyle(
                                        size * .035,
                                        _tappedIndex == index
                                            ? CColor.themeColor
                                            : Colors.black,
                                        FontWeight.w500),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      )
              ),
            ),

            /// ReadOn Publication Books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'রিডঅন প্রকাশন',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'রিডঅন প্রকাশন', categoryId: 11,));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                              Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: size * .06),
                        child: BookPreview(
                            bookImageWidth: size * .26,
                            bookImageHeight: size * .4,
                            bookImage:
                                "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                            bookName: 'একজন মায়াবতী',
                            writerName: 'হুমায়ুন আহমেদ'),
                      )),
            ),

            /// Young writers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'তরুণ লেখক',
                      style: Style.headerTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size * .4),
                        border:
                        Border.all(color: Colors.red, width: size * .005)),
                    padding: EdgeInsets.symmetric(
                        vertical: size * .004, horizontal: size * .03),
                    child: Text(
                      'আরও',
                      style: Style.bodyTextStyle(
                          size * .035, Colors.black, FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .5,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size * .04),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// writer image
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: _tappedIndex == index
                                          ? CColor.themeColor
                                          : Colors.white,
                                      width: size * .005)),
                              child: CircleAvatar(
                                backgroundImage: const NetworkImage(
                                  'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                                ),
                                radius: size * .12,
                              ),
                            ),
                            SizedBox(height: size * .015),

                            /// writer name
                            SizedBox(
                              width: size*.3,
                              child: Text(
                                'হুমায়ুন আহমেদ',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Style.bodyTextStyle(
                                    size * .035,
                                    _tappedIndex == index
                                        ? CColor.themeColor
                                        : Colors.black,
                                    FontWeight.w500),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  )
              ),
            ),

            /// Thrillers
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'থ্রিলার',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'থ্রিলার', categoryId: 12,));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  )),
            ),

            /// Audio books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'অডিও বই',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'অডিও বই', categoryId: 13));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        BookPreview(
                            bookImageWidth: size * .3,
                            bookImageHeight: size * .35,
                            bookImage:
                            "https://i.pinimg.com/originals/90/dc/ed/90dcede9d67f67d5464070ea3c9ad72c.jpg",
                            bookName: 'একজন মায়াবতী',
                            writerName: 'হুমায়ুন আহমেদ'),

                        Positioned(
                          top: size*.2,
                          child: Container(
                            decoration:  BoxDecoration(
                              color: Colors.grey.shade800,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(size*.02),
                            child: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )),
            ),

            /// Science Fictions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'সায়েন্স ফিকশন',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'সায়েন্স ফিকশন', categoryId: 14));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  )),
            ),

            /// Horrors
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'হরর',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'হরর', categoryId: 15));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  )),
            ),

            /// Comics
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'কমিক্স',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'কমিক্স', categoryId: 16));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index % 2 != 0?Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .3,
                        bookImageHeight: size * .35,
                        bookImage:
                        "https://i.pinimg.com/originals/09/d4/b0/09d4b080789fd67fd578df6d0136e713.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .3,
                        bookImageHeight: size * .35,
                        bookImage:
                        "https://4.bp.blogspot.com/-eFC4Ewbag7M/WigqCAA3OrI/AAAAAAAABcY/uPRpOs88-aoISQ3qXVQfnIcVpeUq-DEfQCLcBGAs/s1600/images.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  )
              ),
            ),

            /// Romantic Books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'রোমান্টিক',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'রোমান্টিক', categoryId: 17));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1526455811l/40130315._SY475_.jpg",
                        bookName: 'রেশমি',
                        writerName: 'এমদাদুল হক মিলন'),
                  )
              ),
            ),

            /// Children Books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'শিশু কিশোর',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'শিশু কিশোর', categoryId: 18));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-3yfD9u2lWQk/YHPbXny3CyI/AAAAAAAAAMo/geFkdTQ4luM0e76Z7v-1TZfdxsPsGNb3ACLcBGAsYHQ/s320/Adarshalipi%2BBangla%2BPDF%2BChildren%2BBooks.JPG",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://i.pinimg.com/originals/6d/9a/06/6d9a061624ef92c8b9707f3772219ec9.jpg",
                        bookName: 'রেশমি',
                        writerName: 'এমদাদুল হক মিলন'),
                  )
              ),
            ),

            /// Poem Books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'কবিতা',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'কবিতা', categoryId: 19));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-6JwjMDVsKmc/XPtVOfDzC4I/AAAAAAAAWlk/qvzj5UKCcHYG66x0QcGTEeiVxWl7gkkIACLcBGAs/s1600/Nirbachita%2B100%2BKabita%2Bby%2Bby%2BNirmalendu%2BGoon.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://bdebooks.com/wp-content/uploads/2019/09/Rakhali-Gaan-By-Jasim-Uddin-185x278.jpg",
                        bookName: 'রেশমি',
                        writerName: 'এমদাদুল হক মিলন'),
                  )
              ),
            ),

            /// Religious Books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'ধর্মীয়',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'ধর্মীয়', categoryId: 20));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-fJJfgCHKKj4/YHRKdDp5vNI/AAAAAAAAlGs/w5V-tk4HlpIJnrNtQbm67pGQhEkSrTaxQCLcBGAsYHQ/s16000/karbalar%2Bprantore.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://i0.wp.com/www.banglaboipdf.com/wp-content/uploads/2019/05/RadhaKrishna-Sunil-Gangopadhyay.jpg?ssl=1",
                        bookName: 'রেশমি',
                        writerName: 'এমদাদুল হক মিলন'),
                  )
              ),
            ),

            /// Motivational Books
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'মোটিভেশনাল',
                      style: Style.bodyTextStyle(
                          size * .05, Colors.black, FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => MoreBooksPage(title: 'মোটিভেশনাল', categoryId: 21));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(size * .4),
                          border:
                          Border.all(color: Colors.red, width: size * .005)),
                      padding: EdgeInsets.symmetric(
                          vertical: size * .004, horizontal: size * .03),
                      child: Text(
                        'আরও',
                        style: Style.bodyTextStyle(
                            size * .035, Colors.black, FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size * .03),
              height: size * .6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => index%2 == 0? Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://bdebooks.com/wp-content/uploads/2020/03/book_37-185x278.jpg",
                        bookName: 'একজন মায়াবতী',
                        writerName: 'হুমায়ুন আহমেদ'),
                  ): Padding(
                    padding: EdgeInsets.only(right: size * .06),
                    child: BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://i.pinimg.com/236x/49/72/b9/4972b95c652c85762429f9c48e6727dc.jpg",
                        bookName: 'রেশমি',
                        writerName: 'এমদাদুল হক মিলন'),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
