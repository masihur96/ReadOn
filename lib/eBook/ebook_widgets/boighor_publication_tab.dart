import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';
import 'package:read_on/public_variables/color_variable.dart';

class BoighorPublicationTabPage extends StatefulWidget {
  const BoighorPublicationTabPage({Key? key}) : super(key: key);

  @override
  _BoighorPublicationTabPageState createState() => _BoighorPublicationTabPageState();
}

class _BoighorPublicationTabPageState extends State<BoighorPublicationTabPage> {
  int _tappedIndex = 0;
  final List<String> _subjectList = [
    'অন্যপ্রকাশ',
    'বাতীঘর',
    'রকমারি',
    'পরশ',
    'অন্যপ্রকাশ',
    'বাতীঘর',
    'রকমারি',
    'পরশ',
  ];

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
            height: size * .15,
            alignment: Alignment.center,
            color: const Color(0xffDEDFE1),
            padding:  EdgeInsets.symmetric(horizontal: size*.04),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: _subjectList.length,
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() => _tappedIndex = index);
                    },
                    child: Container(
                      padding:  EdgeInsets.fromLTRB(size*.04, size*.05, size*.04, size*.05),
                      child: Text(
                        _subjectList[index],
                        style: TextStyle(
                            color: _tappedIndex == index? CColor.themeColor : Colors.black, fontSize: size * .04, fontWeight: FontWeight.w500),
                      ),
                    )))),
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
