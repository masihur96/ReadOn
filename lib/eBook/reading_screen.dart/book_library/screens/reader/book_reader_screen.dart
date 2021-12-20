//import 'package:auto_scrolling_readon/book_library/screens/sections/bloc/section_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/loading.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/components/scroll_speed_widget.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/book.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/highlight.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/model/menu_button.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/screens/reader/bloc/reader_bloc.dart';
import 'package:read_on/eBook/reading_screen.dart/book_library/text_selection_controls.dart';
// import 'package:auto_scrolling_readon/book_library/components/loading.dart';
// import 'package:auto_scrolling_readon/book_library/components/scroll_speed_widget.dart';
// import 'package:auto_scrolling_readon/book_library/model/book.dart';
// import 'package:auto_scrolling_readon/book_library/model/highlight.dart';
// import 'package:auto_scrolling_readon/book_library/model/menu_button.dart';
// import 'package:auto_scrolling_readon/book_library/screens/reader/bloc/reader_bloc.dart';
// import 'package:auto_scrolling_readon/book_library/text_selection_controls.dart';
import '../../../mina_reader.dart';
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
        required this.sectionIndex
         })
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
  TextSelection(baseOffset: -1, extentOffset: -1);
  // ScrollController _scrollController = ScrollController();

  final transparentHighlight = Highlight(color: Colors.transparent.value, baseOffset: 0, extendOffset: 0);

  TapUpDetails? lastSelectedHighlightGestureDetails;
  bool _isAllReaded = false;
  bool _showScrollSpeed = false;

  _BookReaderScreenState(this.book, this.index);

  @override
  void initState() {
    print(book.sections[index].fileName);
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
    if (WidgetsBinding.instance != null)
      WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _readerBloc
        .add(ReaderLastLocationChanged(_readerBloc.scrollController.offset));
    super.didChangeAppLifecycleState(state);
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool isDrawerOpen =false;
  double lineSpacing=1.5;
  double selectedSize=20.0;
  Color? bgColor,fontColor;
  int currentPosition=0;
  String selectedFont ='Kalpurush';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: _readerBloc,
      child: WillPopScope(
          onWillPop: () async {
            _readerBloc.add(
                ReaderLastLocationChanged(_readerBloc.scrollController.offset));

          Get.back();
          Get.back();
          Get.back();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              primary: true,
              backgroundColor: Colors.red,
              automaticallyImplyLeading: false,
              leading: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await _readerBloc.toggleAutoScroll();
                      setState(() {});
                    },
                    icon: Icon(
                      _readerBloc.isScrolling
                          ? Icons.pause
                          : Icons.play_arrow,size: 40,color: Colors.white,
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
                    icon: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.settings_ethernet,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
                leadingWidth: 100,
              actions: [
                Padding(
                  padding: EdgeInsets.only(left: size.width*.1),
                  child:     IconButton(onPressed: (){
                    setState(() {
                      if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                        _scaffoldKey.currentState!.openDrawer();
                      } else if(_scaffoldKey.currentState!.isDrawerOpen == true){
                        Navigator.pop(context);
                      }
                    });
                  }, icon: Icon(Icons.menu_sharp)),
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
                    icon: Icon(
                      Icons.highlight_remove,

                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text('বিরাজ বউ',style: TextStyle(fontSize: 20,color: Colors.white),),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text('অধ্যায় ঃ ৩',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  ],),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*.1),
                  child: Container(
                    color: Colors.black87,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text('1',style: TextStyle(fontSize: 10,color: Colors.grey),),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text('2',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                        Text('3',style: TextStyle(fontSize: 10,color: Colors.grey),),
                      ],),
                  ),
                ),

                IconButton(onPressed: (){

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ReaderScreenSettings()),
                  // );

                },
                  icon: Icon(Icons.bookmark_border_outlined,color: Colors.white,),
                ),


                IconButton(onPressed: (){
                  setState(() {
                    if (_scaffoldKey.currentState!.isEndDrawerOpen == false) {
                      _scaffoldKey.currentState!.openEndDrawer();
                    } else if(_scaffoldKey.currentState!.isEndDrawerOpen == true){
                      Navigator.pop(context);
                    }
                  });
                }, icon: Icon(Icons.more_vert_outlined)),
              ],
            ),
            body: Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
              drawer: Drawer(
                child:Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.width*.7,
                        child: Stack(
                          children: [
                            Positioned(
                              top: -size.width * .47,
                              left: -size.width * .4,
                              child: Container(
                                width:size.width,
                                height: size.width,

                                decoration:  BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  // border: Border.all(color: Colors.blueGrey, width: 1.5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://1.bp.blogspot.com/-QoKjWWKcnC0/XWVnOba6kbI/AAAAAAAAXn4/fwXfr6wBflcYMrUlRSFxfB9K62_5SONAgCLcBGAs/s1600/Ekjon%2BMayaboti%2Bby%2BHumayun%2BAhmed%2B-%2BBangla%2BRomantic%2BNovel%2BPDF%2BBooks.jpg")
                                  ),
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
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
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
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text('আদর্শ হিন্দু হোটেল',style: TextStyle(fontSize: 25),),
                              Text('বিভূতিভূষণ বন্দপাদ্দয়',style: TextStyle(fontSize: 20),),
                            ],),
                        ),
                      ),
                      SizedBox(
                        height: size.height,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('${index + 1}.  1',style: TextStyle(fontSize: 20),),
                              );
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              endDrawer:Drawer(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView(
                      children:  [
                        Text('Font Size',style: TextStyle(fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    selectedSize = 20.0;
                                  });
                                },
                                icon: Icon(Icons.font_download_outlined,size: 20.0,),),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    selectedSize = 40.0;
                                  });

                                },
                                icon: Icon(Icons.font_download_outlined,size: 25.0,),),

                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    selectedSize = 60.0;
                                  });
                                },
                                icon: Icon(Icons.font_download_outlined,size: 30.0,),),
                            ],),
                        ),
                        Text('Line space',style: TextStyle(fontSize: 20),),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:  [

                              IconButton(
                                onPressed: (){
                                  setState(() {
                                  lineSpacing = 1.5;
                                  });
                                },
                                icon: Icon(Icons.format_line_spacing_outlined,size: 20),),

                              IconButton(
                                onPressed: (){
                                  setState(() {
                                   lineSpacing = 2.0;
                                  });
                                },
                                icon: Icon(Icons.format_line_spacing_outlined,size: 25),),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                 lineSpacing = 2.5;
                                  });

                                },
                                icon: Icon(Icons.format_line_spacing_outlined,size: 25),),


                            ],),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){

                                setState(() {
                                  bgColor = Colors.white;
                                  fontColor= Colors.black;
                                });

                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.grey.shade50,
                                  ),

                                  child:  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                    child: Text('white',style: TextStyle(color: Colors.black),),
                                  )),
                            ),
                            const SizedBox(width: 20,),
                            InkWell(
                              onTap: (){

                                setState(() {
                                  bgColor = Colors.black;
                                  fontColor= Colors.white;
                                });

                              },
                              child: Container(
                                  decoration: const BoxDecoration( borderRadius:  BorderRadius.all(Radius.circular(5)),
                                    color: Colors.black54,),
                                  child:  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                    child:Text('black',style: TextStyle(color: fontColor),),
                                  )),
                            ),
                          ],
                        ),
                        const Text('Font',style: TextStyle(fontSize: 20),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedFont = 'Kalpurush';
                                });
                                print(selectedFont);
                              },
                              child:  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                child: Text('বই ফন্ট',style: TextStyle(color: Colors.black,fontSize: 18),),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedFont = 'SolaimanLipi_29-05-06';
                                }); print(selectedFont);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                child: Text('সুলাইমান লিপি',style: TextStyle(color: Colors.black,fontSize: 18),),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedFont = 'AdorshoLipi';
                                }); print(selectedFont);
                              },
                              child:  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                child: Text('আদর্শ লিপি',style: TextStyle(color: Colors.black,fontSize: 18),),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedFont = 'Hind_Siliguri';
                                });     print(selectedFont);
                              },
                              child:   Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                child: Text('হিন্দ শিলিগুড়ি',style: TextStyle(color: Colors.black,fontSize: 18),),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedFont = 'SLIPI_N';
                                });   print(selectedFont);
                              },
                              child:Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                child: Text('লিপি মল্লিকা',style: TextStyle(color: Colors.black,fontSize: 18),),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  selectedFont = 'Galada';
                                });    print(selectedFont);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                                child: Text('গালাদা',style: TextStyle(color: Colors.black,fontSize: 18),),
                              ),
                            ),
                          ],),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: const Text('Review book',style: TextStyle(fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child:const Text('Download book',style: TextStyle(fontSize: 20),),
                        ),


                        const Text('Share book',style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ),
                ),
              ),
              body: Padding(
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
                          print("nooo pixelsss");
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
                            await _readerBloc.scrollSpeedChanged(newValue);
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

                              child: Scrollbar(
                                controller: _readerBloc.scrollController,
                                child: SingleChildScrollView(
                                  controller: _readerBloc.scrollController,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Stack(
                                        children: [
                                          GestureDetector(
                                            onScaleStart: (details) =>
                                            _readerBloc.baseScaleFactor =
                                                _readerBloc.scaleFactor,
                                            onScaleUpdate: (details) {
                                              setState(() {
                                                _readerBloc.scaleFactor =
                                                    _readerBloc.baseScaleFactor *
                                                        details.scale;
                                              });
                                            },
                                            child: buildSelectableText(),
                                          ),
                                          if (_readerBloc
                                              .currentSelectedHighlight !=
                                              null &&
                                              lastSelectedHighlightGestureDetails !=
                                                  null)
                                            Positioned.fill(
                                              child: buildSelectionHighlightTextMenu(),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Loading();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }


  double returnSize(){
    return selectedSize;
  }

  late SelectableText selectableTextWidget;

  SelectableText buildSelectableText() {
    selectableTextWidget = SelectableText.rich(
      TextSpan(
       // text: _readerBloc.allText,
        children:
        handleHighlight(_readerBloc.allText,returnSize(),),
        style: TextStyle(
          color: fontColor,
           height: lineSpacing,

          decorationStyle: TextDecorationStyle.wavy,
        ),

      ),
       textAlign: TextAlign.justify,

      textScaleFactor: _readerBloc.scaleFactor,
      toolbarOptions: ToolbarOptions(copy: false, selectAll: false),
      onTap: () {},
      selectionControls: MyMaterialTextSelectionControls(
          onTapped: onTappedMenuButton,
          currentTextSelection: currentTextSelection),
      onSelectionChanged: (selection, cause) async {
        if (selection.baseOffset == selection.extentOffset)
          findBeforeAndAfterWords(selection);
        if (selection.baseOffset == selection.extentOffset) {
        } else {
          currentTextSelection = selection;
        }
      },
      scrollPhysics: NeverScrollableScrollPhysics(),
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

  handleHighlight(String text ,double fontSize) {
    int index = 0;
    final int length = text.length;
    final List<TextSpan> widgets = [];

    for (int i = 0; i < _readerBloc.highlights.length; i++) {
      final highlight = _readerBloc.highlights.elementAt(i);
      if (index == highlight.baseOffset) {
        index = highlight.extendOffset;

        final textStyle = getTextStyle(highlight,fontSize,selectedFont);

        widgets.add(
          TextSpan(
            text: text.substring(highlight.baseOffset, highlight.extendOffset),
            style: textStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                hideTextSelectionToolbar();

                print("${highlight.baseOffset} ${highlight.extendOffset}");
                setState(() {
                  _readerBloc.currentSelectedHighlight = highlight;
                });
              }
              ..onTapUp = (details) {
                lastSelectedHighlightGestureDetails = details;
                currentTextSelection = TextSelection(
                    baseOffset: highlight.baseOffset,
                    extentOffset: highlight.extendOffset);
                print(details);
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
            style: getTextStyle(transparentHighlight,fontSize,selectedFont),

            recognizer: TapGestureRecognizer()
              ..onTap = () {
                hideTextSelectionToolbar();
              }));
        index = highlight.baseOffset;
        i -= 1;
      }
    }

    if (index != length) {
      widgets.add(TextSpan(
          text: text.substring(index, length),
          style: getTextStyle(transparentHighlight,fontSize,selectedFont)));
    }

    return widgets;
  }

  void findBeforeAndAfterWords(TextSelection selection) {
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

  buildSelectionHighlightTextMenu() {
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
        currentTextSelection: currentTextSelection);

    final zeroOffset = lastSelectedHighlightGestureDetails!.localPosition;
    final zeroOffsetBelow = lastSelectedHighlightGestureDetails!.localPosition;

    return myTextSelectionControls.buildTextSelectionToolbar(
        zeroOffset, zeroOffsetBelow);
  }

  void closeScrollSpeedWidget() {
    if (_showScrollSpeed) _showScrollSpeed = false;
  }
}
