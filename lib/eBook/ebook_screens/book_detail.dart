import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/controller/reading_api_controller.dart';
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/reading_screen.dart/reading_screen.dart';
import 'package:read_on/widgets/custom_loading.dart';
import 'category_wise_book_page.dart';
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import '../../widgets/custom_appbar.dart';
import 'my_cart_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/language_convert.dart';
import 'package:read_on/public_variables/style_variable.dart';
import 'package:read_on/public_variables/toast.dart';
import 'package:read_on/widgets/gradient_button.dart';

class BookDetail extends StatefulWidget {
  Product product;

  BookDetail({Key? key, required this.product}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _commentController = TextEditingController();
  int _count = 0;
  String writterName = '';
  bool _writerBooksLoading = false;
  bool _publicationBooksLoading = false;
  bool _addedToCart = false;
  bool _isShared = false;
  bool _addedToWishList = false;
  double rating = 0;
  double averageRating = 0;
  int totalReview = 0;
  String reviewDate = '';
  bool _loadingData = false;

  void _customInit(EbookApiController ebookApiController, ReadingApiController readingApiController) async {
    _count++;
    setState(() => _loadingData = true);
    readingApiController.getChapterContent(widget.product.id!);
    readingApiController.updateBookName(widget.product.name!);
    setState(() {
      writterName = widget.product.wname!.length > 16
          ? widget.product.wname!.substring(0, 13) + '...'
          : widget.product.wname!;
      _writerBooksLoading = true;
      _publicationBooksLoading = true;
    });
    await ebookApiController.getWriterDetails(widget.product.writerId!);
    await ebookApiController.getWriterWiseBookList(widget.product.writerId!);
    await ebookApiController
        .getPublicationWiseBookList(widget.product.publicationId!);
    setState(() {
      _writerBooksLoading = false;
      _publicationBooksLoading = false;
    });
    print(
        'product name: ${widget.product.name}, product id: ${widget.product.id}, writer: ${widget.product.wname}');

    await ebookApiController.getReviewList(widget.product.id!).then((value) {
      if (ebookApiController.reviewList.isNotEmpty) {
        setState(() => totalReview = ebookApiController.reviewList.length);
        double ratingSum = 0;
        for (int i = 0; i < ebookApiController.reviewList.length; i++) {
          ratingSum = ratingSum +
              double.parse(ebookApiController.reviewList[i].ratting!);
        }
        setState(() =>
        averageRating = ratingSum / ebookApiController.reviewList.length);
        print('avg rating = $averageRating');
      }
    });
    print('review list length = ${ebookApiController.reviewList.length}');
    setState(() => _loadingData = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.find();
    final ReadingApiController readingApiController = Get.find();
    final UserController userController = Get.find();
    final double size = publicController.size.value;
    if (_count == 0) _customInit(ebookApiController, readingApiController);
    var dFormat = DateFormat("yMMMd");
    if (ebookApiController.reviewList.isNotEmpty) {
      reviewDate = dFormat.format(ebookApiController.reviewList[0].createdAt!);
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: _loadingData? const Center(child: CupertinoActivityIndicator()) : Stack(
          children: [
            _bodyUI(
                size, ebookApiController, userController, readingApiController),
            Visibility(
              visible: _addedToCart ? true : false,
              child: Container(
                width: Get.width,
                height: Get.height,
                color: Colors.black38,
                child: const CustomLoading(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bodyUI(
          double size,
          EbookApiController ebookApiController,
          UserController userController,
          ReadingApiController readingApiController) =>
      ListView(
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
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${widget.product.bookThumbnail!}")),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 0.0),
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
                  child: Stack(
                    children: [
                      Card(
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
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${widget.product.bookThumbnail!}",
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ReadingScreen()));

                            setState(() {
                              readingApiController.ektuPorun == true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(size * .015),
                                    topRight: Radius.circular(size * .015))),
                            padding: EdgeInsets.symmetric(
                                horizontal: size * .025, vertical: size * .008),
                            child: Text(
                              'একটু পড়ুন',
                              style: Style.bodyTextStyle(
                                  size * .03, Colors.black, FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                /// ebook price
                Positioned(
                  top: size * .47,
                  right: size * .07,
                  child: GestureDetector(
                    onTap: () {
                      showCartDialog(size, ebookApiController, userController);
                    },
                    child: Container(
                      width: size * .3,
                      padding: EdgeInsets.symmetric(
                          vertical: size * .01, horizontal: size * .02),
                      decoration: BoxDecoration(
                        color: CColor.themeColor,
                        borderRadius: BorderRadius.circular(size * .04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            LineAwesomeIcons.mobile_phone,
                            color: Colors.white,
                            size: size * .065,
                          ),
                          Expanded(
                              child: Text(
                                  int.parse(widget.product.sellingPriceEbook!) >
                                          0
                                      ? '৳ ${enToBnNumberConvert(widget.product.sellingPriceEbook!)}/-'
                                      : 'ফ্রি',
                                  textAlign: TextAlign.center,
                                  style: Style.bodyTextStyle(size * .045,
                                      Colors.white, FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                ),

                /// hard copy price
                Positioned(
                  top: size * .6,
                  right: size * .07,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() => _addedToCart = true);
                      await addToCart(
                          userController,
                          widget.product.sellingPriceHardcopy!,
                          ebookApiController,
                          'hardCopy',
                          'false');
                      setState(() => _addedToCart = false);
                      showToast(
                          'এই বইটির হার্ড কপি আপনার কার্টলিস্টে যুক্ত হয়েছে।');
                    },
                    child: Container(
                      width: size * .3,
                      padding: EdgeInsets.symmetric(
                          vertical: size * .01, horizontal: size * .02),
                      decoration: BoxDecoration(
                        color: CColor.themeColor,
                        borderRadius: BorderRadius.circular(size * .04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            LineAwesomeIcons.book_open,
                            color: Colors.white,
                            size: size * .065,
                          ),
                          Expanded(
                            child: Text(
                                '৳ ${enToBnNumberConvert(widget.product.sellingPriceHardcopy!)}/-',
                                textAlign: TextAlign.center,
                                style: Style.bodyTextStyle(size * .045,
                                    Colors.white, FontWeight.w500)),
                          ),
                        ],
                      ),
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
                padding: EdgeInsets.only(left: size * .07, right: size * .07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// book name
                    Expanded(
                        child: Text(widget.product.name!,
                            textAlign: TextAlign.center,
                            style: Style.bodyTextStyle(
                                size * .06, Colors.grey, FontWeight.w600))),

                    /// cart
                    IconButton(
                        onPressed: () {
                          showCartDialog(
                              size, ebookApiController, userController);
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: CColor.themeColor,
                        )),

                    /// favourite
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          _addedToWishList
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: CColor.themeColor,
                        )),

                    /// share
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          _isShared ? Icons.share : Icons.share_outlined,
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
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size * .06),
                        topRight: Radius.circular(size * .06))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size*.3,
                      child: Column(
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
                              backgroundImage:
                                  ebookApiController.writerDetailModel[0].image != null
                                      ? NetworkImage(
                                          "${ebookApiController.domainName}/public//frontend/images/writerImage//${ebookApiController.writerDetailModel[0].image}",
                                        )
                                      : const AssetImage(
                                              "assets/default_profile_image.png")
                                          as ImageProvider,
                              radius: size * .1,
                            ),
                          ),
                          SizedBox(height: size * .03),

                          /// writer name
                          Text(
                            writterName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Style.bodyTextStyle(
                                size * .04, CColor.greenColor, FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size * .05,
                    ),

                    /// writer's book list
                    Expanded(
                      child: _writerBooksLoading
                          ? const CupertinoActivityIndicator()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemCount:
                                  ebookApiController.writerWiseBookList.length,
                              itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(right: size * .02),
                                    child: BookPreview(
                                      bookImageWidth: size * .2,
                                      bookImageHeight: size * .3,
                                      bookImage:
                                          '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.writerWiseBookList[index].bookThumbnail!}',
                                      bookName: ebookApiController
                                          .writerWiseBookList[index].name!,
                                      writerName: ebookApiController
                                          .writerWiseBookList[index].wname!,
                                      product: ebookApiController
                                          .writerWiseBookList[index],
                                    ),
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
                          _bookDetailOption(
                              size, 'বিষয়', widget.product.categoryName!),
                          _bookDetailOption(size, 'প্রকাশনী',
                              widget.product.publicationName!),
                          _bookDetailOption(
                              size, 'সংস্করণ', 'প্রথম প্রকাশ ২০২০'),
                        ],
                      ),
                    ),

                    /// book description
                    Expanded(
                      child: ExpandableText(
                        widget.product.bookDescription!,
                        expandText: 'আরও পড়ুন',
                        collapseText: 'পূর্বের অবস্থা',
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
                    GestureDetector(
                      onTap: () {
                        showReviewListDialog(
                            size, ebookApiController, userController);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(size * .02),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  averageRating.toString(),
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
                              'Review ($totalReview)',
                              style: Style.bodyTextStyle(size * .032,
                                  CColor.greenColor, FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size * .04,
                    ),

                    /// review field
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showReviewDialog(
                              size, ebookApiController, userController);
                        },
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          style: Style.bodyTextStyle(
                              size * .045, Colors.black, FontWeight.w400),
                          cursorColor: Colors.black,
                          autofocus: false,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: size * .035),
                              fillColor: Colors.pink.shade50,
                              filled: true,
                              enabled: false,
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
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size * .05),

              /// Review section
              totalReview == 0
                  ? const SizedBox()
                  : Container(
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
                          SizedBox(width: size * .04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      children: [
                                        const TextSpan(text: 'by '),

                                        /// reviewer name
                                        TextSpan(
                                            text: ebookApiController
                                                .reviewList[0].userName!,
                                            style: const TextStyle(
                                                color: CColor.greenColor)),
                                      ],
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ),
                                const SizedBox(height: 1.5),

                                /// review point with stars
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar(
                                      ignoreGestures: true,
                                      glowColor: CColor.greenColor,
                                      unratedColor: Colors.grey,
                                      initialRating: double.parse(
                                          ebookApiController
                                              .reviewList[0].ratting!),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: size * .035,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(
                                          Icons.star,
                                          color: CColor.greenColor,
                                        ),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: CColor.greenColor,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: CColor.greenColor,
                                        ),
                                      ),
                                      onRatingUpdate: (double value) {},
                                    ),
                                    SizedBox(
                                      width: size * .02,
                                    ),

                                    /// review date
                                    Text(
                                      reviewDate,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: size * .03),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1.5),

                                /// review text
                                Padding(
                                  padding: EdgeInsets.only(right: size * .2),
                                  child: ExpandableText(
                                    ebookApiController
                                        .reviewList[0].reviewDetails!,
                                    expandText: 'আরও পড়ুন',
                                    collapseText: 'অল্প পড়ুন',
                                    maxLines: 2,
                                    linkColor: CColor.greenColor,
                                    style: Style.bodyTextStyle(size * .035,
                                        Colors.black, FontWeight.normal),
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
                  'আরও পড়ুন',
                  style: Style.bodyTextStyle(
                      size * .05, const Color(0xff616161), FontWeight.w700),
                ),
              ),
              Container(
                height: size * .6,
                padding: EdgeInsets.symmetric(horizontal: size * .04),
                child: _publicationBooksLoading
                    ? const CupertinoActivityIndicator()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        itemCount:
                            ebookApiController.publicationWiseBookList.length,
                        itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(right: size * .06),
                              child: BookPreview(
                                bookImageWidth: size * .26,
                                bookImageHeight: size * .4,
                                bookImage:
                                    '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.publicationWiseBookList[index].bookThumbnail!}',
                                bookName: ebookApiController
                                    .publicationWiseBookList[index].name!,
                                writerName: ebookApiController
                                    .publicationWiseBookList[index].wname!,
                                product: ebookApiController
                                    .publicationWiseBookList[index],
                              ),
                            )),
              )
            ],
          ),
        ],
      );

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) =>
      CustomAppBar(
        title: widget.product.name!,
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
  Widget _bookDetailOption(double size, String title, String value) => Padding(
        padding: EdgeInsets.symmetric(vertical: size * .005),
        child: Row(
          children: [
            Text(
              '$title : ',
              style: Style.bodyTextStyle(
                  size * .035, Colors.black, FontWeight.w500),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.to(() => CategoryWiseBookPage(
                      categoryName: widget.product.categoryName!,
                      categoryId: widget.product.categoryId!));
                },
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
            ),
          ],
        ),
      );

  /// review dialog
  showReviewDialog(double size, EbookApiController ebookApiController,
      UserController userController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: Colors.pink.shade50.withOpacity(0.95),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'রিভিউ লিখুন',
                  style: Style.bodyTextStyle(
                      size * .04, Colors.black, FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  margin: EdgeInsets.zero,
                  child: Container(
                    width: size * .26,
                    height: size * .4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${widget.product.bookThumbnail!}',
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Text(
                  widget.product.name!,
                  style: Style.bodyTextStyle(
                      size * .06, Colors.black, FontWeight.w500),
                ),
                SizedBox(
                  height: size * .04,
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: size * .1,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                SizedBox(
                  height: size * .04,
                ),
                TextFormField(
                  maxLines: null,
                  controller: _commentController,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'আপনার মন্তব্য লিখুন',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CColor.themeColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size * .04,
                ),
                Container(
                  alignment: Alignment.center,
                  child: GradientButton(
                      child: Text(
                        'সাবমিট',
                        style: Style.buttonTextStyle(
                            size * .04, Colors.white, FontWeight.w500),
                      ),
                      onPressed: () async {
                        if (_commentController.text.isEmpty) {
                          showToast('রিভিউতে আপনার মন্তব্য লিখুন।');
                          return;
                        }
                        Map reviewMap = {
                          'user_id': userController.userId,
                          'ratting': rating.toString(),
                          'book_id': widget.product.id,
                          'review_details': _commentController.text
                        };
                        await ebookApiController.postReviewOnBook(reviewMap);
                        print(reviewMap);
                      },
                      borderRadius: size * .01,
                      height: size * .1,
                      width: size * .3,
                      gradientColors: const [
                        CColor.themeColor,
                        CColor.themeColorLite
                      ]),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// cart dialog
  showCartDialog(double size, EbookApiController ebookApiController,
      UserController userController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: Colors.pink.shade50.withOpacity(0.95),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'কার্ট',
                  style: Style.bodyTextStyle(
                      size * .04, Colors.black, FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                        width: size * .16,
                        height: size * .22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${widget.product.bookThumbnail!}',
                            placeholder: (context, url) =>
                                const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: size * .04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name!,
                              style: Style.bodyTextStyle(
                                  size * .04, Colors.black, FontWeight.w500),
                            ),
                            SizedBox(
                              height: size * .01,
                            ),
                            Text(
                              'ইবুক',
                              style: Style.bodyTextStyle(
                                  size * .04, Colors.black, FontWeight.bold),
                            ),
                            SizedBox(
                              height: size * .01,
                            ),
                            Text(
                              '৳ ${enToBnNumberConvert(widget.product.sellingPriceEbook!)}/-',
                              style: Style.bodyTextStyle(
                                  size * .04, Colors.black, FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        setState(() => _addedToCart = true);
                        await addToCart(
                            userController,
                            widget.product.sellingPriceEbook!,
                            ebookApiController,
                            "ebook",
                            'false');
                        setState(() => _addedToCart = false);
                        showToast('ইবুকটি আপনার কার্টলিস্টে যুক্ত হয়েছে।');
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(
                                color: CColor.themeColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(size * .01))),
                      ),
                      child: Text(
                        "কিনুন",
                        style: Style.bodyTextStyle(
                            size * .04, CColor.themeColor, FontWeight.w500),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          margin: EdgeInsets.zero,
                          child: Container(
                            width: size * .16,
                            height: size * .22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    '${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${widget.product.bookThumbnail!}',
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.play_circle_fill,
                          color: Colors.red.withOpacity(0.8),
                          size: size * .07,
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: size * .04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name!,
                              style: Style.bodyTextStyle(
                                  size * .04, Colors.black, FontWeight.w500),
                            ),
                            SizedBox(
                              height: size * .01,
                            ),
                            Text(
                              'ইবুক + অডিও',
                              style: Style.bodyTextStyle(
                                  size * .04, Colors.black, FontWeight.bold),
                            ),
                            SizedBox(
                              height: size * .01,
                            ),
                            Text(
                              '৳ ${enToBnNumberConvert(widget.product.sellingPriceEbook!)}/-',
                              style: Style.bodyTextStyle(
                                  size * .04, Colors.black, FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () async {
                        setState(() => _addedToCart = true);
                        await addToCart(
                            userController,
                            widget.product.sellingPriceEbook!,
                            ebookApiController,
                            "ebook",
                            'true');
                        setState(() => _addedToCart = false);
                        showToast('ইবুকটি আপনার কার্টলিস্টে যুক্ত হয়েছে।');
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            side: const BorderSide(
                                color: CColor.themeColor,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(size * .01))),
                      ),
                      child: Text(
                        "কিনুন",
                        style: Style.bodyTextStyle(
                            size * .04, CColor.themeColor, FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
      },
    );
  }

  /// add to cart
  Future<void> addToCart(
      UserController userController,
      String subPrice,
      EbookApiController ebookApiController,
      String bookType,
      String audioStatus) async {
    Map cartMap = {
      "user_id": userController.userId,
      "book_id": widget.product.id!,
      "quantity": "1",
      'book_type': bookType,
      "sub_total_price": subPrice,
      'audio_status': audioStatus
    };
    // ignore: avoid_print
    print(cartMap);
    await ebookApiController.addToCart(cartMap);
  }

  /// review list showing dialog
  showReviewListDialog(double size, EbookApiController ebookApiController,
      UserController userController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
              scrollable: true,
              backgroundColor: Colors.grey.shade50.withOpacity(0.95),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'রিভিউ',
                    style: Style.bodyTextStyle(
                        size * .04, Colors.black, FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              content: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: ebookApiController.reviewList.length,
                itemBuilder: (context, index) {
                  var dFormat = DateFormat("yMMMd");
                  String dReviewDate = dFormat
                      .format(ebookApiController.reviewList[index].createdAt!);
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// reviewer profile picture
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnELq88FqJJ3fRj93adsIGYvhO-TiVlgimVQ&usqp=CAU'),
                          ),
                          SizedBox(width: size * .04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      children: [
                                        const TextSpan(text: 'by '),

                                        /// reviewer name
                                        TextSpan(
                                            text: ebookApiController
                                                .reviewList[index].userName!,
                                            style: const TextStyle(
                                                color: CColor.greenColor)),
                                      ],
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ),
                                const SizedBox(height: 1.5),

                                /// review point with stars
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar(
                                      ignoreGestures: true,
                                      glowColor: CColor.greenColor,
                                      unratedColor: Colors.grey,
                                      initialRating: double.parse(
                                          ebookApiController
                                              .reviewList[index].ratting!),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: size * .035,
                                      ratingWidget: RatingWidget(
                                        full: const Icon(
                                          Icons.star,
                                          color: CColor.greenColor,
                                        ),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: CColor.greenColor,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: CColor.greenColor,
                                        ),
                                      ),
                                      onRatingUpdate: (double value) {},
                                    ),
                                    SizedBox(
                                      width: size * .02,
                                    ),

                                    /// review date
                                    Text(
                                      dReviewDate,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: size * .03),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1.5),

                                /// review text
                                ExpandableText(
                                  ebookApiController
                                      .reviewList[index].reviewDetails!,
                                  expandText: 'আরও পড়ুন',
                                  collapseText: 'পূর্বের অবস্থা',
                                  maxLines: 2,
                                  linkColor: CColor.greenColor,
                                  style: Style.bodyTextStyle(size * .035,
                                      Colors.black, FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size * .03,
                      )
                    ],
                  );
                },
              ));
        });
      },
    );
  }
}
