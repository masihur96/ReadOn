import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/ebook_api_controller.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/eBook/ebook_widgets/custom_appbar.dart';
import 'package:read_on/eBook/ebook_widgets/custom_drawer.dart';
import 'package:read_on/widgets/custom_loading.dart';

class MoreBooksPage extends StatefulWidget {
  String title;
  int categoryId;
  MoreBooksPage({Key? key, required this.title, required this.categoryId}) : super(key: key);

  @override
  _MoreBooksPageState createState() => _MoreBooksPageState();
}

class _MoreBooksPageState extends State<MoreBooksPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int _count = 0;
  bool _loading = false;

  void _customInit(EbookApiController ebookApiController) async {
    _count++;
    setState(() => _loading = true);
    if(widget.title == 'ফ্রি বই') {
      await ebookApiController.getFreeBooks();
      setState(() => _loading = false);
    }else{
      await ebookApiController.getCategoryWiseBooks(widget.categoryId);
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    final EbookApiController ebookApiController = Get.put(EbookApiController());
    double size = publicController.size.value;
    if(_count == 0) _customInit(ebookApiController);
    return Obx(() => SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: _pageAppBar(size, publicController)),
        body: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child: CustomDrawer()),
          body: _loading? const Center(child: CustomLoading()) :  ebookApiController.bookList.isNotEmpty ? GridView.builder(
            physics: const ClampingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 5,
                mainAxisSpacing: 2),
            itemCount: ebookApiController.bookList.length,
            itemBuilder: (context, index) => BookPreview(
                bookImageWidth: size * .26,
                bookImageHeight: size * .4,
                bookImage:
                "https://${ebookApiController.domainName}/public//frontend/images/book_thumbnail/${ebookApiController.bookList[index].bookThumbnail!}",
                bookName: ebookApiController.bookList[index].name!,
                writerName: ebookApiController.bookList[index].wname!),
          ) : const Center(child: Text('কোন বই খুঁজে পাওয়া যায় নি!')),
        ),
      ),
    ));
  }

  /// app bar
  CustomAppBar _pageAppBar(double size, PublicController publicController) => CustomAppBar(
    title: widget.title,
    iconData: LineAwesomeIcons.bars,
    action: [
      Icon(
        Icons.search_outlined,
        color: Colors.white,
        size: publicController.size.value * .08,
      ),
    ],
    scaffoldKey: _scaffoldKey,
  );
}
