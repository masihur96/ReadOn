import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/book_front_preview.dart';

class FavouriteBook extends StatefulWidget {
  @override
  State<FavouriteBook> createState() => _FavouriteBookState();
}

class _FavouriteBookState extends State<FavouriteBook> {
  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size*.04),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
             childAspectRatio: 9/16,
            mainAxisSpacing: 10
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return BookPreview(
                bookImage:
                    "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                bookName: 'একজন মায়াবতী একজন মায়াবতী একজন মায়াবতী',
                writerName: 'হুমায়ুন আহমেদ একজন মায়াবতী একজন মায়াবতী');
          }),
    );
  }
}
