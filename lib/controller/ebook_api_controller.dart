import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:read_on/controller/user_controller.dart';
import 'package:read_on/eBook/ebook_model_classes/audio_book_model.dart';
import 'package:read_on/eBook/ebook_model_classes/cart_model.dart';
import 'package:read_on/eBook/ebook_model_classes/my_purchased_book_model.dart';
import 'package:read_on/eBook/ebook_model_classes/package_model.dart';
import 'package:read_on/eBook/ebook_model_classes/product.dart';
import 'package:read_on/eBook/ebook_model_classes/home_page_book_list_model.dart';
import 'package:read_on/eBook/ebook_model_classes/publication_model.dart';
import 'package:read_on/eBook/ebook_model_classes/review_model.dart';
import 'package:read_on/eBook/ebook_model_classes/site_setting_model.dart';
import 'package:read_on/eBook/ebook_model_classes/subject_category_model.dart';
import 'package:read_on/eBook/ebook_model_classes/subject_subcategory_model.dart';
import 'package:read_on/eBook/ebook_model_classes/subscription_model.dart';
import 'package:read_on/eBook/ebook_model_classes/todays_attraction.dart';
import 'package:read_on/eBook/ebook_model_classes/writter_model.dart';
import 'package:read_on/public_variables/toast.dart';

class EbookApiController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getSubjectCategoryNameList();
    getWriterList();
    getTenFreeBooks();
    getTenNewBooks();
    getPublicationList();
  }

  final String domainName = 'https://readon.genextbd.net';
  RxList<SubjectCategoryModel> subjectCategoryList =
      RxList<SubjectCategoryModel>([]);
  RxList<SubjectSubcategoryModel> subjectSubcategoryListOfCategory =
      RxList<SubjectSubcategoryModel>([]);
  Rx<WriterModel> writeModel = WriterModel().obs;
  RxList<PublicationModel> publicationList = RxList<PublicationModel>([]);
  RxList<Product> bookList = RxList<Product>([]);
  RxList<Product> writerWiseBookList = RxList<Product>([]);
  RxList<Product> publicationWiseBookList = RxList<Product>([]);
  RxList<Product> categoryWiseBookList = RxList<Product>([]);
  RxList<Product> freeBookList = RxList<Product>([]);
  RxList<Product> newBookList = RxList<Product>([]);
  RxList<Product> subCategoryWiseBookList = RxList<Product>([]);
  Rx<HomePageBookListModel> homePageBookListModel = HomePageBookListModel().obs;
  RxList<SubscriptionModel> subscriptionList = RxList<SubscriptionModel>([]);
  RxList<ReviewModel> reviewList = RxList<ReviewModel>([]);
  Rx<CartModel> cartModel = CartModel().obs;
  RxString promoCodeDiscount = ''.obs;
  RxInt totalNumberOfCarts = 0.obs;
  RxList<SiteSettingModel> siteSettingImageList = RxList<SiteSettingModel>([]);
  RxList<PackageModel> packageList = RxList<PackageModel>([]);
  Rx<AudioBookModel> audioBookModel = AudioBookModel().obs;
  RxList<Product> singleBook = RxList<Product>([]);
  Rx<TodaysAttractionModel>? todaysAttractionModel =
      TodaysAttractionModel().obs;
  Rx<MyPurchasedBookModel> myPurchasedBookModel = MyPurchasedBookModel().obs;

  Future<void> getSubjectCategoryNameList() async {
    try {
      http.Response response =
          await http.get(Uri.parse('$domainName/api/category_list'));
      subjectCategoryList.value = subjectCategoryModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting subjectCategoryList error: $error');
    }
  }

  Future<void> getSubjectSubCategoryOfCategory(int categoryId) async {
    String baseUrl = '$domainName/api/subcategory_list/$categoryId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      subjectSubcategoryListOfCategory.value =
          subjectSubcategoryModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting subject subcategory error: $error');
    }
  }

  Future<void> getWriterList() async {
    try {
      http.Response response =
          await http.get(Uri.parse('$domainName/api/writer_list'));
      writeModel.value = writerModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting writer list error: $error');
    }
  }

  Future<void> getPublicationList() async {
    try {
      http.Response response =
          await http.get(Uri.parse('$domainName/api/publisher'));
      publicationList.value = publicationModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting publication list error: $error');
    }
  }

  /// free books
  Future<void> getFreeBooks() async {
    String baseUrl = '$domainName/api/freebooks';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      freeBookList.value = productFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting free book list error: $error');
    }
  }

  /// new books
  Future<void> getNewBooks() async {
    String baseUrl = '$domainName/api/newbooks';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      newBookList.value = productFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting free book list error: $error');
    }
  }

  /// category wise books
  Future<void> getCategoryWiseBooks(int categoryId) async {
    String baseUrl = '$domainName/api/allcategorybooks/$categoryId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      categoryWiseBookList.value = productFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting category wise books list error: $error');
    }
  }

  /// Sub-category wise books
  Future<void> getSubCategoryWiseBooks(int subCategoryId) async {
    String baseUrl = '$domainName/api/subcategory_list/$subCategoryId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      subCategoryWiseBookList.value = productFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting sub-category wise books list error: $error');
    }
  }

  /// writer wise books
  Future<void> getWriterWiseBookList(String writerId) async {
    String baseUrl = '$domainName/api/writersbooks/$writerId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      writerWiseBookList.value = productFromJson(response.body);
      print('writerId: $writerId, total books: ${writerWiseBookList.length}');
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting writer wist book list error: $error');
    }
  }

  /// publication wise books
  Future<void> getPublicationWiseBookList(String publicationId) async {
    String baseUrl = '$domainName/api/publicationbook/$publicationId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      publicationWiseBookList.value = productFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting publication wise book list error: $error');
    }
  }

  /// 10 free books for home page
  Future<void> getTenFreeBooks() async {
    String baseUrl = '$domainName/api/freebooks';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      freeBookList.value = productFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting free books list for home page error: $error');
    }
  }

  /// 10 new books for home page
  Future<void> getTenNewBooks() async {
    String baseUrl = '$domainName/api/newbooks';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      newBookList.value = productFromJson(response.body);
      // ignore: avoid_print
      print('new book = ${newBookList.length}');
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting new books list for home page error: $error');
    }
  }

  /// home page category books
  Future<void> getHomePageCategoryBooks() async {
    print('getting category on home page ');
    try {
      String baseUrl = '$domainName/api/homecategorybooks';
      http.Response response = await http.get(Uri.parse(baseUrl));
      homePageBookListModel.value =
          homePageBookListModelFromJson(response.body);
      update();
    } on SocketException {
      // ignore: avoid_print
      print("no internet connection!");
    } catch (error) {
      // ignore: avoid_print
      print('getting home page category book list for home page error: $error');
    }
  }

  /// all subscriptions list
  Future<void> getSubscriptionList() async {
    String baseUrl = '$domainName/api/subs';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      subscriptionList.value = subscriptionModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('Fetching all subscription list error: $error');
    }
  }

  /// add to cart
  Future<void> addToCart(Map cartMap) async {
    try {
      var response = await http.post(Uri.parse('$domainName/api/cart'),
          headers: {
            'Accept': 'application/json',
            // 'Content-Type' :'application/json',
          },
          body: cartMap);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // ignore: avoid_print
        print(
            'cart list result = ${jsonData['result']} and message = ${jsonData['message']}');
      } else {
        showToast('বইটি কার্ট লিস্টে যোগ হয় নি। আবার চেষ্টা করুন।');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Add to cart failed! error: $error');
    }
  }

  /// show ebook cart list
  Future<void> getEbookCartList(UserController userController) async {
    String baseUrl = '$domainName/api/ebookcartsdata/${userController.userId}';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      cartModel.value = cartModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting ebook cart list error: $error');
    }
  }

  ///show hard copy cart list
  Future<void> getHardCopyCartList(UserController userController) async {
    String baseUrl =
        '$domainName/api/hardCopycartsdata/${userController.userId}';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      cartModel.value = cartModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('getting hard copy cart list error: $error');
    }
  }

  /// delete cart
  Future<void> deleteCart(String cartId) async {
    final String baseUrl = '$domainName/api/cartdlt/$cartId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      print(response.body);
      var jsondata = jsonDecode(response.body);
      print('msg: ${jsondata['msg']}');
    } catch (error) {
      print('deleting cart error: $error');
    }
  }

  /// getting promo code discount
  Future<void> getPromoCodeDiscount(String promoCode) async {
    final String baseUrl = '$domainName/api/promocode?code=$promoCode';
    promoCodeDiscount.value = '0';
    try {
      var response = await http.post(
        Uri.parse(baseUrl),
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['msg'] == 'success') {
          promoCodeDiscount.value = jsonData['amount'];
          showToast(
              'অভিনন্দন! আপনি ${promoCodeDiscount.value}% ডিসকাউন্ট পেয়েছেন।');
          update();
        } else {
          // ignore: avoid_print
          print('wrong promoCode or no discount!, ${jsonData['msg']}');
          showToast('আপনি কোনো ডিসকাউন্ট পান নি।');
        }
      } else {
        print('statuscode for promoCode = ${response.statusCode}');
      }
    } catch (error) {
      print('getting promoCode discount error, $error');
    }
  }

  /// post review on book
  Future<void> postReviewOnBook(Map reviewMap) async {
    String baseUrl = '$domainName/api/review';
    try {
      var response = await http.post(Uri.parse(baseUrl), body: reviewMap);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        showToast('রিভিউ দেওয়া সফল হয়েছে!');
        print('review successful, result = ${jsonData['result']}');
      } else {
        print('response failed!, statusCode = ${response.statusCode}');
      }
    } on SocketException {
      // ignore: avoid_print
      print('no internet');
    } catch (error) {
      // ignore: avoid_print
      print('Giving review on book error, $error');
    }
  }

  /// get review list
  Future<void> getReviewList(String bookId) async {
    final String baseUrl = '$domainName/api/getreview/$bookId';
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      reviewList.value = reviewModelFromJson(response.body);
      update();
    } catch (error) {
      // ignore: avoid_print
      print('Fetching review list failed, error: $error');
    }
  }

  /// number of carts
  Future<void> countNumberOfCarts(UserController userController) async {
    try {
      await getHardCopyCartList(userController).then((value) async {
        totalNumberOfCarts.value += cartModel.value.data!.length;
        await getEbookCartList(userController).then((value) {
          totalNumberOfCarts.value += cartModel.value.data!.length;
        });
      });
      print('total number of cart = $totalNumberOfCarts');
    } catch (error) {
      print('Counting total number of carts error: $error');
    }
  }

  /// update cart quantity
  Future<void> updateCartQuantity(Map cartQuantityMap) async {
    final String baseUrl = "$domainName/api/cartsqty";
    var body = jsonEncode(cartQuantityMap);
    print(body);
    try {
      var response = await http.put(Uri.parse(baseUrl), body: body);
      var jsonData = jsonDecode(response.body);
      print('Updating cart quantity : ${jsonData['msg']}');
    } catch (error) {
      print('Updating cart quantity error: $error');
    }
  }

  /// home page - site_setting
  Future<void> getSiteSettings() async {
    final String baseUrl = "$domainName/api/site_setting";
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      siteSettingImageList.value = siteSettingModelFromJson(response.body);
      update();
    } catch (error) {
      print('getting site setting images error: $error');
    }
  }

  /// package list get
  Future<void> getPackageList() async {
    final String baseUrl = "$domainName/api/pac";
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      packageList.value = packageModelFromJson(response.body);
      update();
    } catch (error) {
      print('Fetching package list error: $error');
    }
  }

  /// all audio books
  Future<void> getAllAudioBooks() async {
    final String baseUrl = "$domainName/api/audio_book_list";
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      audioBookModel.value = audioBookModelFromJson(response.body);
      update();
    } catch (error) {
      print('Getting all audio books error: $error');
    }
  }

  /// sigle book info
  Future<void> getSingleBookInfo(String bookId) async {
    final String baseUrl = "$domainName/api/bookinfo/$bookId";
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      singleBook.value = productFromJson(response.body);
      update();
    } catch (error) {
      print("Getting single book info error: $error");
    }
  }

  /// today's attraction
  Future<void> getTodaysAttraction() async {
    final String baseUrl = "$domainName/api/todayAttraction";
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      todaysAttractionModel!.value =
          todaysAttractionModelFromJson(response.body);
      update();
    } catch (error) {
      print("Fetching todays attraction error: $error");
    }
  }

  /// order hard copy
  Future<void> orderHardCopyBooks(Map<String, dynamic> dataMap) async {
    final String baseUrl = "$domainName/api/order";
    print(dataMap);
    var response = await http.post(Uri.parse(baseUrl), body: dataMap);
    if (response.statusCode == 200) {
      showToast("আপনার অর্ডারটি সম্পন্ন হয়েছে।");
    }
    print(response.body);
    // var jsonData = jsonEncode(dataMap);
    // try {
    //   var response = await http.post(Uri.parse(baseUrl), body: dataMap);
    //   if (response.statusCode == 200) {
    //     showToast("আপনার অর্ডারটি সম্পন্ন হয়েছে।");
    //   }
    //   print(response.body);
    // } catch (error) {
    //   // ignore: avoid_print
    //   print("Order of hard copy books error: $error");
    // }
  }

  /// get purchased Ebook
  Future<void> purchaseBooks(Map purchaseBookMap) async {
    final String baseUrl = "$domainName/api/ebookorder";
    try {
      var response = await http.post(Uri.parse(baseUrl), body: purchaseBookMap);
      print(response.body);
      print("statusCode = ${response.statusCode}");
    } catch (error) {
      print("purchasing book error: $error");
    }
  }

  /// my purchased book
  Future<void> getMyPurchasedBooks(UserController userController) async {
    final String baseUrl = "$domainName/api/ebookbuy/${userController.userId}";
    try {
      http.Response response = await http.get(Uri.parse(baseUrl));
      myPurchasedBookModel.value = myPurchasedBookModelFromJson(response.body);
      update();
    } catch (error) {
      print("getting my purchased books error: $error");
    }
  }
}
