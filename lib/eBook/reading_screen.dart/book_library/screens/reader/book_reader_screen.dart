//import 'package:auto_scrolling_readon/book_library/screens/sections/bloc/section_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:read_on/controller/reading_api_controller.dart';
import 'package:read_on/controller/sqlite_reading_helper.dart';
import 'package:read_on/eBook/ebook_model_classes/sqlite_database_models/book_marks_model.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/loading.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/scroll_speed_widget.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/highlight.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/menu_button.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/bloc/reader_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/text_selection_controls.dart';
import 'highlight/highlight_helper.dart';

// TODO: lugat icin suanki yontemde dosyalar cok yer kapliyor. ayni kelimeden birden cok kayit olusuyor.
// TODO: lugat kelime anlami goruntulendiginde kapanma duzgun olmuyor.

class BookReaderScreen extends StatefulWidget {
  final Book book;
  final int sectionIndex; // sectionIndex
  final Function onTapNextSection;
  final String? nextSectionTitle;

  const BookReaderScreen(
      {Key? key,
      required this.onTapNextSection,
      this.nextSectionTitle,
      required this.book,
      required this.sectionIndex})
      : super(key: key);

  @override
  _BookReaderScreenState createState() =>
      _BookReaderScreenState(book, sectionIndex);
}

class _BookReaderScreenState extends State<BookReaderScreen>
    with WidgetsBindingObserver {
  late ReaderBloc _readerBloc;
  final Book book;
  final int index;

  // SectionGoToReader state;
  //
  // void gotoReaderScreen(BuildContext context, SectionGoToReader state) {
  //   Navigator.push(context,MaterialPageRoute(builder: (context) => BookReaderScreen(book: state.book)),
  //   );
  // }

  TextSelection currentTextSelection =
      const TextSelection(baseOffset: -1, extentOffset: -1);

  // ScrollController _scrollController = ScrollController();

  final transparentHighlight = Highlight(
      color: Colors.transparent.value, baseOffset: 0, extendOffset: 0);

  TapUpDetails? lastSelectedHighlightGestureDetails;
  bool _isAllReaded = false;
  bool _showScrollSpeed = false;

  _BookReaderScreenState(this.book, this.index);

  @override
  void initState() {
    // print(book.sections[index].fileName);
    _readerBloc = ReaderBloc(
      sectionFileName: book.sections[index].fileName,
      highlightFileName: book.getHighlightFileName(index),
      bookFolder: book.assetFolder,
    );
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addObserver(this);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _readerBloc
        .add(ReaderLastLocationChanged(_readerBloc.scrollController.offset));
    super.didChangeAppLifecycleState(state);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool isDrawerOpen = false;
  bool isScreenFit = false;
  double lineSpacing = 1.5;
  double selectedSize = 20.0;
  double _opecityVal = 0.5;
  Color? bgColor = Colors.white;
  Color? fontColor = Colors.black.withOpacity(0.5);
  int currentPosition = 0;
  int circleColor = 1;
  String? alignment = 'justify';
  final TextEditingController _textFieldController = TextEditingController();
  int counter = 0;
  customInfo(ReadingDatabaseHelper databaseHelper) async {
    counter++;
    await databaseHelper.getBookmarksList();
  }

  String note = '';

  //alignment checked variable
  bool leftAlignCheckValue = false;
  bool centerCheckedValue = false;
  bool rightAlignCheckValue = false;

  //Line spacing checked variable
  bool smallSpaceCheckValue = false;
  bool mediumSpaceCheckedValue = false;
  bool largeSpaceCheckValue = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final DatabaseHelper databaseHelper = Get.find();
    final ReadingDatabaseHelper databaseHelper = Get.find();
    // final ReadingApiController readingController = Get.find();
    //   readingController.updateSelectedText(note);
    return GetBuilder<ReadingApiController>(builder: (readingApiController) {
      //  readingApiController.updateSelectedText(note);
      if (counter == 0) {
        customInfo(databaseHelper);
      }

      return BlocProvider.value(
        value: _readerBloc,
        child: WillPopScope(
            onWillPop: () async {
              _readerBloc.add(ReaderLastLocationChanged(
                  _readerBloc.scrollController.offset));

              if (readingApiController.isScreenFit == true) {
                readingApiController.updateScreenFitMode(false);
              } else {
                // Get.back();
                // Get.back();
                // Get.back();
                readingApiController.ContentList.clear();
              }

              return true;
            },
            child: SafeArea(
              child: Scaffold(
                bottomNavigationBar: Visibility(
                  // ignore: unrelated_type_equality_checks
                  visible: readingApiController.isScreenFit == false,
                  child: BottomNavigationBar(
                    backgroundColor: const Color(0xffF2F2F2),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: InkWell(
                            onTap: () {
                              setState(() {
                                readingApiController.updateScreenFitMode(true);
                                // isScreenFit = true;
                              });
                            },
                            child: Image.asset(
                              'assets/zoom_icon.png',
                              height: size.width * .07,
                              width: size.width * .07,
                            )),
                        title: const Text(''),
                        backgroundColor: const Color(0xffF2F2F2),
                      ),
                      BottomNavigationBarItem(
                        icon: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: Colors.white,
                                    height: 300,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.font_download,
                                                  size: size.width * .04,
                                                  color: Colors.red,
                                                ),
                                                Expanded(
                                                  child: StatefulBuilder(
                                                      builder:
                                                          (context, setSt) {
                                                    return Slider(
                                                      value:
                                                          readingApiController
                                                              .redingFontSize
                                                              .value,
                                                      activeColor: Colors.red,
                                                      inactiveColor:
                                                          Colors.grey,
                                                      max: 50.0,
                                                      min: 10.0,
                                                      label:
                                                          '${readingApiController.redingFontSize.value.round()}',
                                                      onChanged:
                                                          (double newValue) {
                                                        setSt(() {
                                                          readingApiController
                                                              .updateSize(
                                                                  newValue);
                                                        });

                                                        // print( readingApiController.redingFontSize);
                                                      },
                                                    );
                                                  }),
                                                ),
                                                Icon(
                                                  Icons.font_download,
                                                  size: size.width * .06,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.opacity,
                                                  color: Colors.red,
                                                ),
                                                Expanded(
                                                  child: StatefulBuilder(
                                                      builder:
                                                          (context, setSt) {
                                                    return Slider(
                                                      value: _opecityVal,
                                                      max: 1.0,
                                                      min: 0.2,
                                                      activeColor: Colors.red,
                                                      inactiveColor:
                                                          Colors.grey,
                                                      // label: '${_opecityVal.round()}',
                                                      onChanged:
                                                          (double newValue) {
                                                        setSt(() {
                                                          readingApiController
                                                              .updateColorOpacity(
                                                                  newValue);
                                                          _opecityVal =
                                                              newValue;
                                                        });
                                                        print(newValue);
                                                      },
                                                    );
                                                  }),
                                                ),
                                                Image.asset(
                                                  'assets/heigh_opecity_icon.png',
                                                  height: size.width * .08,
                                                  width: size.width * .08,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            height: 2,
                                          ),
                                          StatefulBuilder(
                                              builder: (context, setSt) {
                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setSt(() {
                                                          readingApiController
                                                              .updateFontCircleColor(
                                                                  1);
                                                          readingApiController
                                                              .updateFont(
                                                                  'Kalpurush');
                                                        });
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Container(
                                                                height: 80,
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: readingApiController.fontCircleColor.value ==
                                                                                1
                                                                            ? Colors
                                                                                .red
                                                                            : Colors
                                                                                .grey)),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "অআ"))),
                                                          ),
                                                          Center(
                                                              child: Text(
                                                            "ডিফল্ট ফন্ট",
                                                            style: TextStyle(
                                                                color: readingApiController
                                                                            .fontCircleColor
                                                                            .value ==
                                                                        1
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black),
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setSt(() {
                                                            readingApiController
                                                                .updateFontCircleColor(
                                                                    2);
                                                            readingApiController
                                                                .updateFont(
                                                                    'SolaimanLipi_29-05-06');
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                              child: Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: readingApiController.fontCircleColor.value == 2
                                                                              ? Colors
                                                                                  .red
                                                                              : Colors
                                                                                  .grey)),
                                                                  child: const Center(
                                                                      child: Text(
                                                                          "অআ"))),
                                                            ),
                                                            Center(
                                                                child: Text(
                                                              "সুলাইমান লিপি",
                                                              style: TextStyle(
                                                                  color: readingApiController
                                                                              .fontCircleColor
                                                                              .value ==
                                                                          2
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .black),
                                                            ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setSt(() {
                                                          readingApiController
                                                              .updateFont(
                                                                  'AdorshoLipi');
                                                          readingApiController
                                                              .updateFontCircleColor(
                                                                  3);
                                                        });
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Container(
                                                                height: 80,
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: readingApiController.fontCircleColor.value ==
                                                                                3
                                                                            ? Colors
                                                                                .red
                                                                            : Colors
                                                                                .grey)),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "অআ"))),
                                                          ),
                                                          Center(
                                                              child: Text(
                                                            "আদর্শ লিপি",
                                                            style: TextStyle(
                                                                color: readingApiController
                                                                            .fontCircleColor
                                                                            .value ==
                                                                        3
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black),
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setSt(() {
                                                            readingApiController
                                                                .updateFontCircleColor(
                                                                    4);
                                                            readingApiController
                                                                .updateFont(
                                                                    'Hind_Siliguri');
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                              child: Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: readingApiController.fontCircleColor.value == 4
                                                                              ? Colors
                                                                                  .red
                                                                              : Colors
                                                                                  .grey)),
                                                                  child: const Center(
                                                                      child: Text(
                                                                          "অআ"))),
                                                            ),
                                                            Center(
                                                                child: Text(
                                                              "হিন্দ শিলিগুড়ি",
                                                              style: TextStyle(
                                                                  color: readingApiController
                                                                              .fontCircleColor
                                                                              .value ==
                                                                          4
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .black),
                                                            ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setSt(() {
                                                          readingApiController
                                                              .updateFontCircleColor(
                                                                  5);
                                                          readingApiController
                                                              .updateFont(
                                                                  'SLIPI_N');
                                                        });
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Container(
                                                                height: 80,
                                                                width: 80,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: readingApiController.selectedFont.value ==
                                                                                'SLIPI_N'
                                                                            ? Colors
                                                                                .red
                                                                            : Colors
                                                                                .grey)),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "অআ"))),
                                                          ),
                                                          Center(
                                                              child: Text(
                                                            "লিপি মল্লিকা",
                                                            style: TextStyle(
                                                                color: readingApiController
                                                                            .selectedFont
                                                                            .value ==
                                                                        'SLIPI_N'
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black),
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setSt(() {
                                                            //   circleColor = 6;
                                                            readingApiController
                                                                .updateFontCircleColor(
                                                                    6);
                                                            readingApiController
                                                                .updateFont(
                                                                    'Galada');

                                                            // selectedFont = 'Galada';
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                              child: Container(
                                                                  height: 80,
                                                                  width: 80,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: readingApiController.fontCircleColor.value == 6
                                                                              ? Colors
                                                                                  .red
                                                                              : Colors
                                                                                  .grey)),
                                                                  child: const Center(
                                                                      child: Text(
                                                                          "অআ"))),
                                                            ),
                                                            Center(
                                                                child: Text(
                                                              "গালাদা",
                                                              style: TextStyle(
                                                                  color: readingApiController
                                                                              .fontCircleColor
                                                                              .value ==
                                                                          6
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .black),
                                                            ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              'assets/font_icon_reding_page.png',
                              height: size.width * .07,
                              width: size.width * .07,
                            )),
                        title: const Text(''),
                        backgroundColor: const Color(0xffF2F2F2),
                      ),
                      BottomNavigationBarItem(
                        icon: InkWell(
                            onTap: () {
                              _settingModalBottomSheet(context, databaseHelper);
                            },
                            child: Image.asset(
                              'assets/save_icon_reading_page.png',
                              height: size.width * .07,
                              width: size.width * .07,
                            )),
                        title: const Text(''),
                        backgroundColor: const Color(0xffF2F2F2),
                      ),
                      BottomNavigationBarItem(
                        icon: InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      color: Colors.white,
                                      height: 200,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            StatefulBuilder(
                                                builder: (context, setState) {
                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            readingApiController
                                                                .updateColorMode(
                                                                    1);
                                                            //  readingApiController.updateColorMode(Colors.black);
                                                            bgColor =
                                                                const Color(
                                                                    0xffB0B0B0);
                                                            fontColor =
                                                                Colors.black;
                                                          });
                                                          print(bgColor);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffB0B0B0),
                                                                border: Border.all(
                                                                    color: readingApiController.bgCircleColor ==
                                                                            1
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey)),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              readingApiController
                                                                  .updateColorMode(
                                                                      2);
                                                              bgColor =
                                                                  const Color(
                                                                      0xff1E1E1E);
                                                              fontColor =
                                                                  Colors.white;
                                                            });
                                                            print(readingApiController
                                                                .bgCircleColor);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Container(
                                                              height: 80,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color(
                                                                      0xff1E1E1E),
                                                                  border: Border.all(
                                                                      color: readingApiController.bgCircleColor == 2
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            readingApiController
                                                                .updateColorMode(
                                                                    3);
                                                            bgColor =
                                                                const Color(
                                                                    0xff6F6D5E);
                                                            fontColor =
                                                                Colors.white;
                                                          });
                                                          print(bgColor);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      8.0),
                                                          child: Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: const Color(
                                                                    0xff6F6D5E),
                                                                border: Border.all(
                                                                    color: readingApiController.bgCircleColor ==
                                                                            3
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey)),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              readingApiController
                                                                  .updateColorMode(
                                                                      4);
                                                              bgColor =
                                                                  const Color(
                                                                      0xff262C39);
                                                              fontColor = Colors
                                                                  .white54;
                                                            });

                                                            print(bgColor);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Container(
                                                              height: 80,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color(
                                                                      0xff262C39),
                                                                  border: Border.all(
                                                                      color: readingApiController.bgCircleColor == 4
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              readingApiController
                                                                  .updateColorMode(
                                                                      4);
                                                              bgColor =
                                                                  const Color(
                                                                      0xff8D8D8D);
                                                              fontColor =
                                                                  Colors.black;
                                                            });

                                                            print(bgColor);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0),
                                                            child: Container(
                                                              height: 80,
                                                              width: 80,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xff8D8D8D),
                                                                  border: Border.all(
                                                                      color: readingApiController.bgCircleColor == 4
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Image.asset(
                              'assets/play_file_icon.png',
                              height: size.width * .07,
                              width: size.width * .07,
                            )),
                        title: const Text(''),
                        backgroundColor: const Color(0xffF2F2F2),
                      ),
                    ],
                    type: BottomNavigationBarType.shifting,
                    currentIndex: 1,

                    // selectedItemColor: Colors.black,
                    iconSize: 30,

                    // elevation: 5
                  ),
                ),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      readingApiController.isScreenFit == false
                          ? size.width * .13
                          : 0.0),
                  child: AppBar(
                    primary: true,
                    backgroundColor: Color(0xffF4D3D5),
                    automaticallyImplyLeading: false,
                    leading: Row(
                      children: [
                        // InkWell(
                        //     onTap: () async {
                        //       await _readerBloc.toggleAutoScroll();
                        //     },
                        //     child: _readerBloc.isScrolling
                        //         ? Image.asset(
                        //             'assets/auto_scroll_play_icon.png')
                        //         : Image.asset('assets/pause_icon.png')),
                        IconButton(
                          onPressed: () async {
                            await _readerBloc.toggleAutoScroll();
                            setState(() {});
                          },
                          icon: Icon(
                              _readerBloc.isScrolling
                                  ? FontAwesomeIcons.pause
                                  : FontAwesomeIcons.play,
                              size: size.width * .05,
                              color: Color(0xffB1002C)
                              // color: Colors.white,
                              ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showScrollSpeed = !_showScrollSpeed;
                            });
                            print('Tapped');
                          },
                          icon: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(Icons.settings_ethernet,
                                size: size.width * .05, color: Color(0xffB1002C)
                                // color: Colors.white,
                                ),
                          ),
                        ),
                      ],
                    ),
                    leadingWidth: size.width * .25,
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .1),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_scaffoldKey.currentState!.isDrawerOpen ==
                                    false) {
                                  _scaffoldKey.currentState!.openDrawer();
                                } else if (_scaffoldKey
                                        .currentState!.isDrawerOpen ==
                                    true) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            icon: Image.asset(
                                'assets/reading_appbar_right_drower_icon.png')),
                      ),
                      // IconButton(
                      //   onPressed: () async {
                      //     await _readerBloc.toggleAutoScroll();
                      //     setState(() {});
                      //   },
                      //   icon: Icon(
                      //     _readerBloc.isScrolling
                      //         ? Icons.stop_circle_outlined
                      //         : Icons.arrow_downward,
                      //     // color: Colors.white,
                      //   ),
                      // ),

                      if (_readerBloc.currentSelectedHighlight != null)
                        IconButton(
                          onPressed: () {
                            _readerBloc.highlights
                                .remove(_readerBloc.currentSelectedHighlight);
                            _readerBloc.currentSelectedHighlight = null;
                            _readerBloc.saveHighlights();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.highlight_remove,
                            color: Color(0xffB1002C),
                          ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'বই শিরোনাম',
                            style: TextStyle(
                              fontSize: size.width * .045,
                              color: Color(0xffB1002C),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '০১ অধ্যায়',
                              style: TextStyle(
                                fontSize: size.width * .035,
                                color: Color(0xffB1002C),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * .05),
                        child: Container(
                          color: Color(0xffB1002C),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * .01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '00',
                                  style: TextStyle(
                                      fontSize: size.width * .03,
                                      color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    '0১',
                                    style: TextStyle(
                                        fontSize: size.width * .035,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '0২',
                                  style: TextStyle(
                                      fontSize: size.width * .03,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _displayTextInputDialog(
                                context, readingApiController, databaseHelper);

                            print(note);
                          },
                          icon:
                              Image.asset('assets/reading_book_mark_icon.png')),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_scaffoldKey.currentState!.isEndDrawerOpen ==
                                  false) {
                                _scaffoldKey.currentState!.openEndDrawer();
                              } else if (_scaffoldKey
                                      .currentState!.isEndDrawerOpen ==
                                  true) {
                                Navigator.pop(context);
                              }
                            });
                          },
                          icon:
                              Image.asset('assets/reading_three_dot_icon.png')),
                    ],
                  ),
                ),
                body: Scaffold(
                  backgroundColor: bgColor,
                  key: _scaffoldKey,
                  drawer: Drawer(
                    child: Container(
                      color: Colors.white,
                      child: ListView(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.width * .7,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: -size.width * .47,
                                  left: -size.width * .4,
                                  child: Container(
                                    width: size.width,
                                    height: size.width,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      // border: Border.all(color: Colors.blueGrey, width: 1.5),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg")),
                                    ),
                                    // child: BackdropFilter(
                                    //   filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 0.0),
                                    //   child: Container(
                                    //     decoration:
                                    //     BoxDecoration(color: Colors.white.withOpacity(0.0)),
                                    //   ),
                                    // ),
                                  ),
                                ),

                                /// book image
                                Positioned(
                                  top: size.width * .05,
                                  left: size.width * .14,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    margin: EdgeInsets.zero,
                                    child: Container(
                                      width: size.width * .4,
                                      height: size.width * .6,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          child: Image.network(
                                            "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg",
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            color: Colors.grey.shade300,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'আদর্শ হিন্দু হোটেল',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Text(
                                    'বিভূতিভূষণ বন্দপাদ্দয়',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '${index + 1}.  1',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  endDrawer: Drawer(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(size.width * .1),
                              bottomLeft: Radius.circular(size.width * .1))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView(
                          children: [
                            const Text(
                              'টেক্সট এলাইনমেন্ট',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.red,
                                        ),
                                        child: Checkbox(
                                            value: leftAlignCheckValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                leftAlignCheckValue = newValue!;
                                                rightAlignCheckValue = false;
                                                centerCheckedValue = false;
                                                alignment = 'leftAlign';
                                              });
                                            }),
                                      ),
                                      Icon(
                                        Icons.format_align_left,
                                        size: 25.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.red,
                                        ),
                                        child: Checkbox(
                                            value: centerCheckedValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                leftAlignCheckValue = false;
                                                rightAlignCheckValue = false;
                                                centerCheckedValue = newValue!;
                                                alignment = 'center';
                                              });
                                            }),
                                      ),
                                      Icon(
                                        Icons.format_align_center,
                                        size: 25.0,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.red,
                                        ),
                                        child: Checkbox(
                                            value: rightAlignCheckValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                leftAlignCheckValue = false;
                                                rightAlignCheckValue =
                                                    newValue!;
                                                centerCheckedValue = false;
                                                alignment = 'justify';
                                              });
                                            }),
                                      ),
                                      Icon(
                                        Icons.format_align_justify_outlined,
                                        size: 25.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'লাইন ব্যাবধান',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.red,
                                        ),
                                        child: Checkbox(
                                            value: smallSpaceCheckValue,
                                            checkColor: Colors.orange,
                                            onChanged: (newValue) {
                                              setState(() {
                                                smallSpaceCheckValue =
                                                    newValue!;
                                                mediumSpaceCheckedValue = false;
                                                largeSpaceCheckValue = false;
                                                lineSpacing = 1.5;
                                              });
                                            }),
                                      ),
                                      Icon(Icons.format_line_spacing_outlined,
                                          size: 20),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.red,
                                        ),
                                        child: Checkbox(
                                            value: mediumSpaceCheckedValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                smallSpaceCheckValue = false;
                                                mediumSpaceCheckedValue =
                                                    newValue!;
                                                largeSpaceCheckValue = false;
                                                lineSpacing = 2.0;
                                              });
                                            }),
                                      ),
                                      Icon(Icons.format_line_spacing_outlined,
                                          size: 25),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.red,
                                        ),
                                        child: Checkbox(
                                            value: largeSpaceCheckValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                smallSpaceCheckValue = false;
                                                mediumSpaceCheckedValue = false;
                                                largeSpaceCheckValue =
                                                    newValue!;
                                                lineSpacing = 2.5;
                                              });
                                            }),
                                      ),
                                      Icon(Icons.format_line_spacing_outlined,
                                          size: 25),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/download_icon_reading_page.png',
                                    height: size.width * .05,
                                    width: size.width * .05,
                                  ),
                                  SizedBox(
                                    width: size.width * .05,
                                  ),
                                  Text(
                                    'ডাউনলোড করুন',
                                    style:
                                        TextStyle(fontSize: size.width * .045),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/review_icon_reading_page.png',
                                    height: size.width * .05,
                                    width: size.width * .05,
                                  ),
                                  SizedBox(
                                    width: size.width * .05,
                                  ),
                                  Text(
                                    'রিভিউ লিখুন',
                                    style:
                                        TextStyle(fontSize: size.width * .045),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/book_share_icon.png',
                                    height: size.width * .05,
                                    width: size.width * .05,
                                  ),
                                  SizedBox(
                                    width: size.width * .05,
                                  ),
                                  Text(
                                    'বইটি শেয়ার করুন',
                                    style:
                                        TextStyle(fontSize: size.width * .045),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: InkWell(
                    onTap: () {
                      readingApiController.updateScreenFitMode(false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NotificationListener(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              _readerBloc.isScrolling) {
                            setState(() {
                              _readerBloc.isScrolling = false;
                              _isAllReaded = true;
                            });
                            _readerBloc.add(ReaderLastLocationChanged(
                                _readerBloc.scrollController.offset));
                          } else if (notification is ScrollEndNotification) {
                            final metrics = notification.metrics;
                            if (metrics.atEdge) {
                              if (metrics.pixels == 0) {
                                // at top
                                if (_isAllReaded) {
                                  setState(() {
                                    _isAllReaded = false;
                                  });
                                }
                                debugPrint("nooo pixelsss");
                              } else {
                                if (!_isAllReaded) {
                                  setState(() {
                                    _isAllReaded = true;
                                  });
                                }
                              }
                            }
                          }
                          return true;
                        },
                        child: Column(
                          children: [
                            if (_showScrollSpeed)
                              ScrollSpeedWidget(
                                onChanged: (newValue) async {
                                  await _readerBloc
                                      .scrollSpeedChanged(newValue);
                                  setState(() {});
                                },
                                onTapClose: () {
                                  setState(() {
                                    _showScrollSpeed = false;
                                  });
                                },
                              ),
                            BlocBuilder<ReaderBloc, ReaderState>(
                              builder: (context, state) {
                                if (state is ReaderReady) {
                                  return Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        readingApiController
                                            .updateScreenFitMode(false);
                                        print('ll');
                                      },
                                      child: Scrollbar(
                                        controller:
                                            _readerBloc.scrollController,
                                        child: SingleChildScrollView(
                                          controller:
                                              _readerBloc.scrollController,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Stack(
                                                children: [
                                                  GestureDetector(
                                                    onScaleStart: (details) =>
                                                        _readerBloc
                                                                .baseScaleFactor =
                                                            _readerBloc
                                                                .scaleFactor,
                                                    onScaleUpdate: (details) {
                                                      setState(() {
                                                        _readerBloc
                                                                .scaleFactor =
                                                            _readerBloc
                                                                    .baseScaleFactor *
                                                                details.scale;
                                                      });
                                                    },
                                                    onTap: () {},
                                                    child: buildSelectableText(
                                                        readingApiController,
                                                        databaseHelper),
                                                  ),
                                                  if (_readerBloc
                                                              .currentSelectedHighlight !=
                                                          null &&
                                                      lastSelectedHighlightGestureDetails !=
                                                          null)
                                                    Positioned.fill(
                                                      child:
                                                          buildSelectionHighlightTextMenu(
                                                              this.note),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Loading();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }

  void _settingModalBottomSheet(context, ReadingDatabaseHelper databaseHelper) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (bc, setStat) {
            return Container(
              height: size.height * .9,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Material(
                        color: Colors.red,
                        child: SafeArea(
                          child: Stack(children: [
                            Positioned(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                    ))),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * .15),
                              child: const TabBar(
                                automaticIndicatorColorAdjustment: true,
                                indicatorColor: Colors.white,
                                labelColor: Colors.white,
                                tabs: [
                                  Tab(text: 'Bookmarks'),
                                  Tab(text: 'Save'),
                                  Tab(text: 'Notes'),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            StatefulBuilder(builder: (context, innerSetState) {
                              var lenth;

                              innerSetState(() {
                                lenth = databaseHelper.bookMarksList.length;

                                print('form list ${lenth}');
                              });
                              return SizedBox(
                                height: size.height * .8,
                                width: size.width,
                                child: ListView.builder(
                                    itemCount: lenth,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.bookmark),
                                              SizedBox(
                                                width: size.width * .02,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      databaseHelper
                                                          .bookMarksList[index]
                                                          .bookmarksTitle,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(databaseHelper
                                                        .bookMarksList[index]
                                                        .chapterName),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    databaseHelper
                                                        .deleteBookmarksItem(
                                                            databaseHelper
                                                                .bookMarksList[
                                                                    index]
                                                                .bookmarksTitle,
                                                            index);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }),
                            Container(
                              height: size.height * .8,
                              width: size.width,
                              child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.save_outlined),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text("নিহত"),
                                                  Text(
                                                      "02. হরিহর রায়ের আদি বাসস্থান"),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Container(
                              height: size.height * .8,
                              width: size.width,
                              child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.note),
                                            SizedBox(
                                              width: size.width * .02,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text("Test Note"),
                                                  Text("02. নিহত"),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Future<void> _displayTextInputDialog(
      BuildContext context,
      ReadingApiController readingApiController,
      ReadingDatabaseHelper databaseHelper) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bookmark'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "My bookmark"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () async {
                  BookMarksModel bookMarksModel = BookMarksModel(
                    readingApiController.bookId,
                    _textFieldController.text,
                    book.sections[index].title,
                  );
                  await databaseHelper.insertBookmarksData(bookMarksModel);
                  _textFieldController.clear();
                  // showToast("Successfully Bookmarked");

                  // codeDialog = valueText;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  double returnSize() {
    return selectedSize;
  }

  late SelectableText selectableTextWidget;

  SelectableText buildSelectableText(ReadingApiController readingApiController,
      ReadingDatabaseHelper databaseHelper) {
    selectableTextWidget = SelectableText.rich(
      TextSpan(
        children: handleHighlight(
            _readerBloc.allText,
            readingApiController.redingFontSize.value,
            readingApiController.selectedFont.value,
            readingApiController,
            databaseHelper),
        style: TextStyle(
          color: fontColor!.withOpacity(_opecityVal),
          height: lineSpacing,
          decorationStyle: TextDecorationStyle.wavy,
        ),
      ),
      textAlign: alignment == 'justify'
          ? TextAlign.justify
          : alignment == 'center'
              ? TextAlign.center
              : TextAlign.left,
      textScaleFactor: _readerBloc.scaleFactor,
      onTap: () {},
      selectionControls: MyMaterialTextSelectionControls(
        onTapped: onTappedMenuButton,
        currentTextSelection: currentTextSelection,
      ),
      onSelectionChanged: (selection, cause) async {
        if (selection.baseOffset == selection.extentOffset) {
          findBeforeAndAfterWords(
              selection, readingApiController, databaseHelper);
        }
        if (selection.baseOffset == selection.extentOffset) {
        } else {
          currentTextSelection = selection;
        }
      },
      scrollPhysics: const NeverScrollableScrollPhysics(),
    );

    return selectableTextWidget;
  }

  onTappedMenuButton(HighlightMenuButton button) {
    final value = button.color;

    if (!allowInsert(currentTextSelection)) return;

    addHighlight(currentTextSelection,
        color: value.value,
        type: button.type,
        sectionFileName: book.sections[index].fileName,
        readerBloc: _readerBloc);

    currentTextSelection = TextSelection(baseOffset: -1, extentOffset: -1);
    setState(() {});

    if (lastSelectedHighlightGestureDetails != null) {}
    lastSelectedHighlightGestureDetails = null;
  }

  void hideTextSelectionToolbar() {
    if (_readerBloc.currentSelectedHighlight != null) {
      setState(() {
        _readerBloc.currentSelectedHighlight = null;
      });
    }
  }

  handleHighlight(
      String text,
      double fontSize,
      String selectedFont,
      ReadingApiController readingApiController,
      ReadingDatabaseHelper databaseHelper) {
    int index = 0;
    final int length = text.length;
    final List<TextSpan> widgets = [];

    for (int i = 0; i < _readerBloc.highlights.length; i++) {
      final highlight = _readerBloc.highlights.elementAt(i);
      if (index == highlight.baseOffset) {
        index = highlight.extendOffset;

        final textStyle = getTextStyle(highlight, fontSize, selectedFont);

        widgets.add(
          TextSpan(
            text: text.substring(highlight.baseOffset, highlight.extendOffset),
            style: textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                hideTextSelectionToolbar();

                setState(() {
                  _readerBloc.currentSelectedHighlight = highlight;
                });
              }
              ..onTapUp = (details) {
                lastSelectedHighlightGestureDetails = details;
                currentTextSelection = TextSelection(
                    baseOffset: highlight.baseOffset,
                    extentOffset: highlight.extendOffset);
              }
              ..onTapDown = (details) {
                if (_readerBloc.currentSelectedHighlight != null) {
                  hideTextSelectionToolbar();
                }
              },
          ),
        );
      } else {
        widgets.add(TextSpan(
            text: text.substring(index, highlight.baseOffset),
            style: getTextStyle(transparentHighlight, fontSize, selectedFont),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                hideTextSelectionToolbar();
              }));

        index = highlight.baseOffset;
        i -= 1;
      }
      note = _readerBloc.allText
          .substring(highlight.baseOffset, highlight.extendOffset)
          .obs
          .toString();

      // readingApiController.updateSelectedText(note);

      // if (readingApiController.selectedSaveText == 'save') {
      //   print('From Reader: save');
      // } else if (readingApiController.selectedSaveText == 'note') {
      //   // Navigator.pop(context);
      //   // _displayNoteInputDialog(context, readingApiController, databaseHelper);
      //   // _displayNoteInputDialog(context, readingApiController, databaseHelper);
      //   // showDialog(
      //   //   context: context,
      //   //   builder: (BuildContext context) {
      //   //     double width = MediaQuery.of(context).size.width;
      //   //     double height = MediaQuery.of(context).size.height;
      //   //     return AlertDialog(
      //   //         backgroundColor: Colors.transparent,
      //   //         contentPadding: EdgeInsets.zero,
      //   //         elevation: 0.0,
      //   //         // title: Center(child: Text("Evaluation our APP")),
      //   //         content: Column(
      //   //           mainAxisAlignment: MainAxisAlignment.end,
      //   //           children: [
      //   //             Container(
      //   //               padding: const EdgeInsets.all(8.0),
      //   //               decoration: BoxDecoration(
      //   //                   color: Colors.white,
      //   //                   borderRadius:
      //   //                       const BorderRadius.all(Radius.circular(10.0))),
      //   //               child: Column(
      //   //                 children: [
      //   //                   Text("a"),
      //   //                   Divider(),
      //   //                   Text("b"),
      //   //                   Divider(),
      //   //                   Text("c"),
      //   //                 ],
      //   //               ),
      //   //             ),
      //   //             SizedBox(
      //   //               height: 10,
      //   //             ),
      //   //             Container(
      //   //               padding: const EdgeInsets.all(8.0),
      //   //               decoration: BoxDecoration(
      //   //                   color: Colors.white,
      //   //                   borderRadius:
      //   //                       const BorderRadius.all(Radius.circular(10.0))),
      //   //               child: Center(child: Text("d")),
      //   //             )
      //   //           ],
      //   //         ));
      //   //   },
      //   // );
      //   print('From Reader: note');
      // }
    }

    if (index != length) {
      widgets.add(
        TextSpan(
            text: text.substring(index, length),
            style: getTextStyle(transparentHighlight, fontSize, selectedFont)),
      );

      // print(text.substring(index, length));
    }

    return widgets;
  }

  void findBeforeAndAfterWords(
      TextSelection selection,
      ReadingApiController readingApiController,
      ReadingDatabaseHelper databaseHelper) {
    final middleIndex = selection.baseOffset;
    int startIndex = middleIndex - 1;
    int endIndex = middleIndex;

    if (_readerBloc.lugat != null) {
      final meaning = _readerBloc.lugat!.firstWhere((element) {
        // return true;
        return element['s'] <= startIndex && element['e'] >= endIndex;
      });
      return;
    }

    bool find = true;
    bool isFirstSpace = true;

    while (find && startIndex != -1) {
      if (isEndChar(_readerBloc.allText[startIndex])) {
        // print(_readerBloc.allText[startIndex]);
        if (isFirstSpace) {
          find = true;
          isFirstSpace = false;
        } else {
          find = false;
        }
        startIndex--;
      } else {
        startIndex--;
      }
    }

    find = true;
    isFirstSpace = true;

    while (find && endIndex < _readerBloc.allText.length) {
      if (isEndChar(_readerBloc.allText[endIndex])) {
        if (isFirstSpace) {
          find = true;
          isFirstSpace = false;
        } else {
          find = false;
        }
        endIndex++;
      } else {
        endIndex++;
      }
    }

    readingApiController.updateScreenFitMode(false);
    //  _displayTextInputDialog(context, readingApiController, databaseHelper);
    print("start word:\n" +
        _readerBloc.allText.substring(startIndex + 1, endIndex));
  }

  bool isEndChar(String letter) {
    return letter == " " || letter == "\n" || letter == "\0" || letter == "\r";
  }

  bool allowInsert(TextSelection currentTextSelection) {
    _readerBloc.highlights.removeWhere((element) =>
        element.baseOffset >= currentTextSelection.baseOffset &&
        element.extendOffset <= currentTextSelection.extentOffset);

    final first = _readerBloc.highlights.indexWhere((element) =>
        ((currentTextSelection.baseOffset >= element.baseOffset &&
                currentTextSelection.baseOffset <= element.extendOffset) ||
            (currentTextSelection.extentOffset >= element.baseOffset &&
                currentTextSelection.extentOffset <= element.extendOffset)));
    return first == -1;
  }

  buildSelectionHighlightTextMenu(String note55555) {
    print('SelectionHTM${note}');
    if (lastSelectedHighlightGestureDetails == null) return Container();
    final Rect globalEditableRegion = Rect.fromPoints(
        lastSelectedHighlightGestureDetails!.globalPosition,
        lastSelectedHighlightGestureDetails!.globalPosition);

    final TextSelectionPoint startTextSelectionPoint = TextSelectionPoint(
        lastSelectedHighlightGestureDetails!.localPosition, TextDirection.ltr);
    final TextSelectionPoint endTextSelectionPoint = TextSelectionPoint(
        lastSelectedHighlightGestureDetails!.localPosition, TextDirection.ltr);

    final selectionMidpoint =
        lastSelectedHighlightGestureDetails!.globalPosition;

    final textLineHeight = 1.5;
    final Offset anchorAbove = Offset(
        globalEditableRegion.left + selectionMidpoint.dx,
        globalEditableRegion.top +
            startTextSelectionPoint.point.dy -
            textLineHeight -
            MyMaterialTextSelectionControls.kToolbarContentDistance);
    final Offset anchorBelow = Offset(
      globalEditableRegion.left + selectionMidpoint.dx,
      globalEditableRegion.top +
          endTextSelectionPoint.point.dy +
          MyMaterialTextSelectionControls.kToolbarContentDistanceBelow,
    );

    final myTextSelectionControls = MyMaterialTextSelectionControls(
      onTapped: onTappedMenuButton,
      currentTextSelection: currentTextSelection,
    );

    final zeroOffset = lastSelectedHighlightGestureDetails!.localPosition;
    final zeroOffsetBelow = lastSelectedHighlightGestureDetails!.localPosition;

    return myTextSelectionControls.buildTextSelectionToolbar(
        zeroOffset, zeroOffsetBelow, note);
  }

  void closeScrollSpeedWidget() {
    if (_showScrollSpeed) _showScrollSpeed = false;
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    // final DatabaseHelper databaseHelper = Get.find();
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ReadingDatabaseHelper>(builder: (databaseHelper) {
      return Container(
        height: size.height * .9,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
                Material(
                  color: Colors.red,
                  child: SafeArea(
                    child: Stack(children: [
                      Positioned(
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              ))),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * .15),
                        child: const TabBar(
                          automaticIndicatorColorAdjustment: true,
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          tabs: [
                            Tab(text: 'Bookmarks'),
                            Tab(text: 'Save'),
                            Tab(text: 'Notes'),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      StatefulBuilder(builder: (context, innerSetState) {
                        return SizedBox(
                          height: size.height * .8,
                          width: size.width,
                          child: ListView.builder(
                              itemCount: databaseHelper.bookMarksList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.bookmark),
                                        SizedBox(
                                          width: size.width * .02,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                databaseHelper
                                                    .bookMarksList[index]
                                                    .bookmarksTitle,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(databaseHelper
                                                  .bookMarksList[index]
                                                  .chapterName),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await databaseHelper
                                                  .deleteBookmarksItem(
                                                      databaseHelper
                                                          .bookMarksList[index]
                                                          .bookmarksTitle,
                                                      index);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                      Container(
                        height: size.height * .8,
                        width: size.width,
                        child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.save_outlined),
                                      SizedBox(
                                        width: size.width * .02,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text("নিহত"),
                                            Text(
                                                "02. হরিহর রায়ের আদি বাসস্থান"),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        height: size.height * .8,
                        width: size.width,
                        child: ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.note),
                                      SizedBox(
                                        width: size.width * .02,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text("Test Note"),
                                            Text("02. নিহত"),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
