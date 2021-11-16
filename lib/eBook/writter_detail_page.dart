import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/eBook/ebook_widgets/custom_drawer.dart';
import 'package:read_on/eBook/my_cart_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/widgets/gradient_button.dart';

class WriterDetailPage extends StatefulWidget {
  const WriterDetailPage({Key? key}) : super(key: key);

  @override
  _WriterDetailPageState createState() => _WriterDetailPageState();
}

class _WriterDetailPageState extends State<WriterDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final String _aboutWriter =
      'হুমায়ূন আহমেদ (১৩ নভেম্বর ১৯৪৮ - ১৯ জুলাই ২০১২) ছিলেন একজন বাংলাদেশি ঔপন্যাসিক, ছোটগল্পকার, নাট্যকার এবং গীতিকার,'
      ' চিত্রনাট্যকার ও চলচ্চিত্র নির্মাতা। তিনি বিংশ শতাব্দীর জনপ্রিয় বাঙালি কথাসাহিত্যিকদের মধ্যে অন্যতম। তাকে বাংলাদেশের স্বাধীনতা পরবর্তী অন্যতম শ্রেষ্ঠ লেখক বলে গণ্য করা হয়। বাংলা কথাসাহিত্যে তিনি সংলাপপ্রধান নতুন শৈলীর জনক। অন্য দিকে তিনি আধুনিক বাংলা বৈজ্ঞানিক কল্পকাহিনীর পথিকৃৎ। নাটক ও চলচ্চিত্র পরিচালক হিসাবেও তিনি সমাদৃত। তার'
      ' প্রকাশিত গ্রন্থের সংখ্যা তিন শতাধিক। তার বেশ কিছু গ্রন্থ পৃথিবীর নানা ভাষায় অনূদিত হয়েছে, বেশ কিছু গ্রন্থ স্কুল-কলেজ বিশ্ববিদ্যালয়ের পাঠ্যসূচীর অন্তর্ভুক্ত।'
      'ঢাকা কলেজ থেকে উচ্চ মাধ্যমিক পাস করার পর তিনি ঢাকা বিশ্ববিদ্যালয়ে রসায়ন এবং নর্থ ডাকোটা স্টেট বিশ্ববিদ্যালয়ে পলিমার রসায়ন শাস্ত্র অধ্যয়ন করেন। তিনি ঢাকা বিশ্ববিদ্যালয়ের রসায়ন বিভাগের অধ্যাপক হিসাবে দীর্ঘকাল কর্মরত ছিলেন। পরবর্তীতে লেখালেখি এবং চলচ্চিত্র নির্মাণের স্বার্থে অধ্যাপনা ছেড়ে দেন।';

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
        body: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child: CustomDrawer()),
          body: _bodyUI(size),
        ),
      ),
    );
  }

  Widget _bodyUI(double size) => SingleChildScrollView(
    child: Column(
          children: [
            SizedBox(
              width: size,
              height: size * .62,
              child: Stack(
                children: [
                  Positioned(
                    top: -size * .47,
                    left: -size * .2,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff86878B),
                      ),
                    ),
                  ),

                  /// writer's image
                  Positioned(
                    bottom: size * .04,
                    left: size * .33,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: CColor.greenColor, width: size * .006)),
                      child: CircleAvatar(
                        backgroundImage: const NetworkImage(
                          'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                        ),
                        radius: size * .16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// writer's name
            Text(
              'হুমায়ুন আহমেদ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size * .06,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size * .04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'জন্ম : ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),

                /// birth date
                Text(
                  '১৩ নভেম্বর ১৯৪৮',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'পুরস্কার : ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),

                /// award of writer
                Text(
                  'বাংলা একাডেমী (২০০৪)',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size * .04,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: size * .04,
            ),

            /// button
            Container(
              width: size * .32,
              padding: EdgeInsets.symmetric(
                  vertical: size * .01, horizontal: size * .04),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [CColor.themeColor, CColor.themeColorLite],
                  ),
                  borderRadius: BorderRadius.circular(size * .02)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: size * .06,
                  ),
                  SizedBox(
                    width: size * .02,
                  ),
                  Text(
                    'অনুসরণ',
                    style: Style.buttonTextStyle(
                        size * .04, Colors.white, FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size * .025,
            ),

            /// button
            Container(
              width: size * .32,
              padding: EdgeInsets.symmetric(
                  vertical: size * .01, horizontal: size * .04),
              decoration: BoxDecoration(
                  border: Border.all(color: CColor.greenColor),
                  borderRadius: BorderRadius.circular(size * .02)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check,
                    color: CColor.greenColor,
                    size: size * .06,
                  ),
                  SizedBox(
                    width: size * .02,
                  ),
                  Text(
                    'অনুকরণ',
                    style: Style.buttonTextStyle(
                        size * .04, CColor.greenColor, FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size * .025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size * .35,
                  padding: EdgeInsets.symmetric(
                    vertical: size * .03,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F3F2),
                    border: Border.all(color: const Color(0xffB8B8B8)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size * .03),
                        bottomLeft: Radius.circular(size * .03)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'মোট বই : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),

                      /// number of books
                      Text(
                        '৪৫',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size * .015,
                ),
                Container(
                  width: size * .35,
                  padding: EdgeInsets.symmetric(
                    vertical: size * .03,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F3F2),
                    border: Border.all(color: const Color(0xffB8B8B8)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(size * .03),
                        bottomLeft: Radius.circular(size * .03)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'অনুসারী : ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),

                      /// number of followers
                      Text(
                        '৫২৪',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size * .04,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size * .05,
            ),

            /// about writer
            Container(
              width: size,
              padding: EdgeInsets.symmetric(horizontal: size*.04),
              child: ExpandableText(
                _aboutWriter,
                textAlign: TextAlign.justify,
                expandText: 'আরও পড়ুন',
                collapseText: 'অল্প পড়ুন',
                maxLines: 4,
                linkColor: CColor.greenColor,
                style: Style.bodyTextStyle(
                    size * .04, Colors.black, FontWeight.w500),
              ),
            ),
            SizedBox(
              height: size * .06,
            ),
            Container(
              width: size,
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: Text(
                'লেখকের বই',
                style: Style.bodyTextStyle(
                    size * .05, const Color(0xff6E6E6E), FontWeight.w700),
              ),
            ),

            /// writer's books
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
  );

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
}
