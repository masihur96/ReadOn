import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:read_on/eBook/ebook_model_classes/book_model.dart';
import 'package:read_on/eBook/ebook_model_classes/publication_model.dart';
import 'package:read_on/eBook/ebook_model_classes/subject_category_model.dart';
import 'package:read_on/eBook/ebook_model_classes/subject_subcategory_model.dart';
import 'package:read_on/eBook/ebook_model_classes/writter_model.dart';

class EbookApiController extends GetxController{
  final String domainName = 'readon.glamworlditltd.com';
  RxList<SubjectCategoryModel> subjectCategoryList = RxList<SubjectCategoryModel>([]);
  RxList<SubjectSubcategoryModel> subjectSubcategoryListOfCategory = RxList<SubjectSubcategoryModel>([]);
  RxList<WriterModel> writerList = RxList<WriterModel>([]);
  RxList<PublicationModel> publicationList = RxList<PublicationModel>([]);
  RxList<BookModel> bookList = RxList<BookModel>([]);

  Future<void> getSubjectCategoryNameList() async {
    try{
      http.Response response = await http.get(Uri.parse('http://$domainName/api/category_list'));
      //subjectCategoryList(subjectCategoryModelFromJson(response.body));
      subjectCategoryList.value = subjectCategoryModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print('getting subjectCategoryList error: $error');
    }
  }

  Future <void> getSubjectSubCategoryOfCategory(int categoryId) async {
    String baseUrl = 'https://$domainName/api/subcategory_list/$categoryId';
    try{
      http.Response response = await http.get(Uri.parse(baseUrl));
      subjectSubcategoryListOfCategory.value = subjectSubcategoryModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print('getting subject subcategory error: $error');
    }
  }

  Future <void> getWriterList() async {
    try{
      http.Response response = await http.get(Uri.parse('http://$domainName/api/writer_list'));
      writerList.value = writerModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print('getting writer list error: $error');
    }
  }

  Future <void> getPublicationList() async {
    try{
      http.Response response = await http.get(Uri.parse('http://$domainName/api/publisher'));
      publicationList.value = publicationModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print('getting publication list error: $error');
    }
  }

  /// writer wise books
  Future <void> getWriterWiseBookList(String writerId) async {
    String baseUrl = 'http://$domainName/api/writersbooks/$writerId';
    try{
      http.Response response = await http.get(Uri.parse(baseUrl));
      bookList.value = bookModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print('getting writer wist book list error: $error');
    }
  }

  /// free books
  Future <void> getFreeBooks() async {
    String baseUrl = 'http://$domainName/api/books';
    try{
      http.Response response = await http.get(Uri.parse(baseUrl));
      bookList.value = bookModelFromJson(response.body);
      update();
    }catch(error){
      // ignore: avoid_print
      print('getting free book list error: $error');
    }
  }

  /// category wise books
 Future <void> getCategoryWiseBooks(int categoryId) async {
   String baseUrl = 'http://$domainName/api/allcategorybooks/$categoryId';
   try{
     http.Response response = await http.get(Uri.parse(baseUrl));
     bookList.value = bookModelFromJson(response.body);
     update();
   }catch(error){
     // ignore: avoid_print
     print('getting category wise books list error: $error');
   }
 }

}
