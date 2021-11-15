import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/public_controller.dart';
import 'package:read_on/eBook/ebook_widgets/boighor_subject_tab.dart';
import 'package:read_on/eBook/ebook_widgets/boighor_publication_tab.dart';
import 'package:read_on/eBook/ebook_widgets/boighor_writer_tab.dart';
import 'package:read_on/public_variables/color_variable.dart';
import 'package:read_on/public_variables/style_variable.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    //_tabController!.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _tabIndex = _tabController!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicController publicController = Get.find();
    double size = publicController.size.value;
    return Scaffold(backgroundColor: Colors.white, body: _bodyUI(size));
  }

  Widget _bodyUI(double size) => Column(
        children: [
          Container(
            color: const Color(0xffF1F3F2),
            child: TabBar(
                onTap: (index) {_handleTabSelection();},
                controller: _tabController,
                indicatorColor: CColor.themeColor,
                unselectedLabelColor: Colors.black,
                labelStyle: Style.bodyTextStyle(size * .04, CColor.themeColor, FontWeight.w500),
                labelColor: CColor.themeColor,
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: size * .02),
                    child: Column(
                      children: [
                        Icon(LineAwesomeIcons.user_edit,
                            color: _tabIndex == 0 ? CColor.themeColor : Colors.black),
                        SizedBox(height: size * .01),
                        const Text('লেখক')
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.library_books_outlined,
                          color: _tabIndex == 1 ? CColor.themeColor : Colors.black),
                      SizedBox(height: size * .01),
                      const Text('বিষয়')
                    ],
                  ),
                  Column(
                    children: [
                      Icon(LineAwesomeIcons.alternate_feather,
                          color: _tabIndex == 2 ? CColor.themeColor : Colors.black),
                      SizedBox(height: size * .01),
                      const Text('প্রকাশনী')
                    ],
                  )
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: [
                   const BoighorWriterTabPage(),
                  BoighorSubjectTabPage(),
                  BoighorPublicationTabPage()
                ]
            ),
          )
        ],
      );
}
