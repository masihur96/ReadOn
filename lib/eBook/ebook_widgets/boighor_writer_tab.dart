import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/eBook/writter_detail_page.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class BoighorWriterTabPage extends StatefulWidget {
  const BoighorWriterTabPage({Key? key}) : super(key: key);

  @override
  _BoighorWriterTabPageState createState() => _BoighorWriterTabPageState();
}

class _BoighorWriterTabPageState extends State<BoighorWriterTabPage> {
  int _tappedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;

    return Scaffold(
      body: _bodyUI(size),
    );
  }

  Widget _bodyUI(double size) => SizedBox(
        width: Get.width,
        child: Column(
          children: [
            Container(
              height: size * .3,
              color: const Color(0xffDEDFE1),
              padding: EdgeInsets.symmetric(horizontal: size * .04),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      setState(() => _tappedIndex = index);
                      Get.to(() => const WriterDetailPage());
                    },
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
                                          color: _tappedIndex == index? CColor.themeColor : Colors.white,
                                          width: size * .005)),
                                  child: CircleAvatar(
                                    backgroundImage: const NetworkImage(
                                      'https://m.media-amazon.com/images/M/MV5BNTM5YmQ5ZGYtMzRiMC00ZmVkLWIzMGItYjkwMTRkZWIyMTk1XkEyXkFqcGdeQXVyNDI3NjcxMDA@._V1_.jpg',
                                    ),
                                    radius: size * .065,
                                  ),
                                ),
                                SizedBox(height: size * .015),

                                /// writer name
                                Text(
                                  'হুমায়ুন আহমেদ',
                                  style: Style.bodyTextStyle(
                                      size * .035, _tappedIndex == index? CColor.themeColor : Colors.black, FontWeight.w500),
                                )
                              ],
                            ),
                            SizedBox(
                              width: size * .06,
                            )
                          ],
                        ),
                  )),
            ),
            Expanded(
              child: GridView.builder(
                  physics: const ClampingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 3 / 5, mainAxisSpacing: 2),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return BookPreview(
                        bookImageWidth: size * .26,
                        bookImageHeight: size * .4,
                        bookImage:
                        "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                        bookName: 'একজন মায়াবতী ',
                        writerName: 'হুমায়ুন আহমেদ');
                  }),
            ),
          ],
        ),
      );
}
