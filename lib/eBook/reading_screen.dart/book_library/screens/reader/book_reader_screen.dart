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
import 'package:read_on/eBook/ebook_screens/book_detail.dart';
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
  const TextSelection(baseOffset: -1, extentOffset: -1);
  // ScrollController _scrollController = ScrollController();

  final transparentHighlight = Highlight(color: Colors.transparent.value, baseOffset: 0, extendOffset: 0);

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

  bool isDrawerOpen =false;
  bool isScreenFit =false;
  double lineSpacing=1.5;
  double selectedSize=20.0;

  double _opecityVal = 0.5;
  Color? bgColor = Colors.white;
  Color? fontColor = Colors.black.withOpacity(0.5);

  int currentPosition=0;
  // String selectedFont ='Kalpurush';
  int circleColor = 1;

  String? alignment='justify';


  final TextEditingController _textFieldController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ReadingApiController>(
      builder: (readingApiController) {

        return BlocProvider.value(
          value: _readerBloc,
          child: WillPopScope(
              onWillPop: () async {
                _readerBloc.add(
                    ReaderLastLocationChanged(_readerBloc.scrollController.offset));
                //
                // Get.to(() =>
                //     BookDetail(product: null,));

                if( readingApiController.isScreenFit==true){
                  readingApiController.updateScreenFitMode(false);
                }else{
                  Get.back();
                  Get.back();
                  Get.back();
                }


                return true;
              },
              child: SafeArea(
                child: Scaffold(
                  bottomNavigationBar: Visibility(
                    // ignore: unrelated_type_equality_checks
                    visible: readingApiController.isScreenFit==false,
                    child: BottomNavigationBar(
                      backgroundColor: Colors.grey,
                      items:   <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: InkWell(
                              onTap: (){
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: Colors.white,
                                      height: 300,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:  <Widget>[

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Row(children: [
                                                const Icon(Icons.font_download_outlined,color: Colors.red,),
                                                Expanded(
                                                  child: StatefulBuilder(
                                                    builder: (context,setSt) {
                                                      return Slider(
                                                        value: readingApiController.redingFontSize.value,
                                                        max: 50.0,
                                                        min: 10.0,
                                                        divisions: 5,
                                                        label: '${readingApiController.redingFontSize.value.round()}',
                                                        onChanged: (double newValue) {
                                                          setSt(() {
                                                            readingApiController.updateSize(newValue);
                                                          });


                                                          // print( readingApiController.redingFontSize);
                                                        },
                                                      );
                                                    }
                                                  ),
                                                ),
                                                const Icon(Icons.font_download_outlined,color: Colors.red,),
                                              ],),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Row(children: [
                                                const Icon(Icons.opacity,color: Colors.red,),
                                                Expanded(
                                                  child: StatefulBuilder(
                                                      builder: (context, setSt){
                                                        return Slider(
                                                          value: _opecityVal,
                                                          max: 1.0,
                                                          divisions: 5,
                                                           min:0.2 ,
                                                          // label: '${_opecityVal.round()}',
                                                          onChanged: (double newValue) {
                                                            setSt(() {
                                                              readingApiController.updateColorOpacity(newValue);
                                                              _opecityVal = newValue;
                                                            });
                                                            print(newValue);
                                                          },
                                                        );
                                                      }
                                                  ),
                                                ),
                                                const Icon(Icons.font_download_outlined,color: Colors.red,),
                                              ],),
                                            ),

                                            const Divider(height: 2,),

                                            StatefulBuilder(
                                              builder: (context,setSt) {
                                                return SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            setSt(() {

                                                              readingApiController.updateFontCircleColor(1);
                                                              readingApiController.updateFont('Kalpurush');


                                                            });

                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                child: Container(
                                                                    height: 80,
                                                                    width: 80,
                                                                    decoration:  BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        border: Border.all(color:readingApiController.fontCircleColor.value==1? Colors.red:Colors.grey)
                                                                    ),
                                                                    child: const Center(child: Text("অআ"))
                                                                ),
                                                              ),
                                                              Center(child: Text("ডিফল্ট ফন্ট",style: TextStyle(color: readingApiController.fontCircleColor.value==1?Colors.red:Colors.black),))
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child:      InkWell(
                                                            onTap: (){
                                                              setSt(() {
                                                                readingApiController.updateFontCircleColor(2);
                                                                readingApiController.updateFont('SolaimanLipi_29-05-06');
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                  child: Container(
                                                                      height: 80,
                                                                      width: 80,
                                                                      decoration:  BoxDecoration(
                                                                          shape: BoxShape.circle,

                                                                          border: Border.all(color:readingApiController.fontCircleColor.value==2? Colors.red:Colors.grey)

                                                                      ),
                                                                      child: const Center(child: Text("অআ"))
                                                                  ),
                                                                ),

                                                                Center(child: Text("সুলাইমান লিপি",style: TextStyle(color: readingApiController.fontCircleColor.value==2?Colors.red:Colors.black),))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            setSt(() {
                                                              readingApiController.updateFont('AdorshoLipi');
                                                              readingApiController.updateFontCircleColor(3);

                                                            });

                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                child: Container(
                                                                    height: 80,
                                                                    width: 80,
                                                                    decoration:  BoxDecoration(
                                                                        shape: BoxShape.circle,

                                                                        border: Border.all(color:readingApiController.fontCircleColor.value==3? Colors.red:Colors.grey)

                                                                    ),
                                                                    child: const Center(child: Text("অআ"))
                                                                ),
                                                              ),

                                                              Center(child: Text("আদর্শ লিপি",style: TextStyle(color: readingApiController.fontCircleColor.value==3?Colors.red:Colors.black),))
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child:      InkWell(
                                                            onTap: (){
                                                              setSt(() {
                                                                readingApiController.updateFontCircleColor(4);
                                                                readingApiController.updateFont('Hind_Siliguri');
                                                              });

                                                            },
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                  child: Container(
                                                                      height: 80,
                                                                      width: 80,
                                                                      decoration:  BoxDecoration(
                                                                          shape: BoxShape.circle,

                                                                          border: Border.all(color:readingApiController.fontCircleColor.value==4? Colors.red:Colors.grey)

                                                                      ),
                                                                      child: const Center(child: Text("অআ"))
                                                                  ),
                                                                ),

                                                                Center(child: Text("হিন্দ শিলিগুড়ি",style: TextStyle(color: readingApiController.fontCircleColor.value==4?Colors.red:Colors.black),))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            setSt(() {
                                                              readingApiController.updateFontCircleColor(5);
                                                              readingApiController.updateFont('SLIPI_N');
                                                            });

                                                          },
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                child: Container(
                                                                    height: 80,
                                                                    width: 80,
                                                                    decoration:  BoxDecoration(
                                                                        shape: BoxShape.circle,

                                                                        border: Border.all(color: readingApiController.selectedFont.value=='SLIPI_N'? Colors.red:Colors.grey)
                                                                    ),
                                                                    child: const Center(child: Text("অআ"))
                                                                ),
                                                              ),

                                                              Center(child: Text("লিপি মল্লিকা",style: TextStyle(color: readingApiController.selectedFont.value=='SLIPI_N'?Colors.red:Colors.black),))
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child:      InkWell(
                                                            onTap: (){
                                                              setSt(() {
                                                                //   circleColor = 6;
                                                                readingApiController.updateFontCircleColor(6);
                                                                readingApiController.updateFont('Galada');

                                                                // selectedFont = 'Galada';
                                                              });



                                                            },
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                  child: Container(
                                                                      height: 80,
                                                                      width: 80,
                                                                      decoration:  BoxDecoration(
                                                                          shape: BoxShape.circle,

                                                                          border: Border.all(color:readingApiController.fontCircleColor.value==6? Colors.red:Colors.grey)

                                                                      ),
                                                                      child: const Center(child: Text("অআ"))
                                                                  ),
                                                                ),

                                                                Center(child: Text("গালাদা",style: TextStyle(color: readingApiController.fontCircleColor.value==6?Colors.red:Colors.black),))
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],),
                                                  ),
                                                );
                                              }
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.text_fields_outlined,color: Colors.black,)),
                          title: const Text(''),
                          backgroundColor: Colors.grey,
                        ),
                        BottomNavigationBarItem(
                          icon: InkWell(

                              onTap: (){

                                setState((){
                                  readingApiController.updateScreenFitMode(true);
                                  // isScreenFit = true;
                                });

                              },
                              child: const Icon(Icons.fit_screen,color: Colors.black,)),
                          title: const Text(''),
                          backgroundColor: Colors.grey,
                        ),
                        BottomNavigationBarItem(
                          icon: InkWell(
                            onTap: (){
                              _settingModalBottomSheet(context);
                            },
                              child: const Icon(Icons.save_outlined,color: Colors.black,)),
                          title: const Text(''),
                          backgroundColor: Colors.grey,
                        ),
                        BottomNavigationBarItem(
                          icon: InkWell(
                              onTap: (){
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState){
                                          return Container(
                                            color: Colors.white,
                                            height: 200,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children:  <Widget>[
                                                  StatefulBuilder(
                                                      builder: (context, setState){
                                                        return  SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      readingApiController.updateColorMode(1);
                                                                      //  readingApiController.updateColorMode(Colors.black);
                                                                      bgColor = Colors.black87;
                                                                      fontColor= Colors.white70;
                                                                    });
                                                                    print(bgColor);
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                        child: Container(
                                                                          height: 80,
                                                                          width: 80,
                                                                          decoration:  BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Colors.black87,

                                                                              border: Border.all(color:readingApiController.bgCircleColor==1? Colors.red:Colors.grey)

                                                                          ),

                                                                        ),
                                                                      ),

                                                                      Center(child: Text("ডিফল্ট",style: TextStyle(color: readingApiController.bgCircleColor== 1?Colors.red:Colors.black),))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                  child:      InkWell(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        readingApiController.updateColorMode(2);
                                                                        bgColor = Colors.white;
                                                                        fontColor= Colors.black;
                                                                      });
                                                                      print(readingApiController.bgCircleColor);
                                                                    },
                                                                    child: Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                          child: Container(
                                                                            height: 80,
                                                                            width: 80,
                                                                            decoration:  BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: Colors.white,
                                                                                border: Border.all(color:readingApiController.bgCircleColor== 2? Colors.red:Colors.grey)
                                                                            ),

                                                                          ),
                                                                        ),

                                                                        Center(child: Text("উজ্জ্বল",style: TextStyle(color: readingApiController.bgCircleColor== 2?Colors.red:Colors.black),))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      readingApiController.updateColorMode(3);
                                                                      bgColor = Colors.white70;
                                                                      fontColor= Colors.black87;
                                                                    });
                                                                    print(bgColor);
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                        child: Container(
                                                                          height: 80,
                                                                          width: 80,
                                                                          decoration:  BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: Colors.white70,
                                                                              border: Border.all(color:readingApiController.bgCircleColor== 3? Colors.red:Colors.grey)

                                                                          ),

                                                                        ),
                                                                      ),

                                                                      Center(child: Text("পেপার",style: TextStyle(color: readingApiController.bgCircleColor== 3?Colors.red:Colors.black),))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                  child: InkWell(
                                                                    onTap: (){

                                                                      setState((){
                                                                        readingApiController.updateColorMode(4);
                                                                        bgColor = const Color(0xFF20222F);
                                                                        fontColor= Colors.white54;
                                                                      });


                                                                      print(bgColor);

                                                                    },
                                                                    child: Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(vertical:8.0),
                                                                          child: Container(
                                                                            height: 80,
                                                                            width: 80,
                                                                            decoration:  BoxDecoration(
                                                                                shape: BoxShape.circle,
                                                                                color: const Color(0xFF20222F),
                                                                                border: Border.all(color:readingApiController.bgCircleColor== 4? Colors.red:Colors.grey)

                                                                            ),

                                                                          ),
                                                                        ),

                                                                        Center(child: Text("গাড় নীল",style: TextStyle(color:readingApiController.bgCircleColor== 4?Colors.red:Colors.black),))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],),
                                                          ),
                                                        );

                                                       }


                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }

                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.settings_outlined,color: Colors.black,)),
                          title: const Text(''),
                          backgroundColor: Colors.grey,
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
                      preferredSize: Size.fromHeight(readingApiController.isScreenFit== false?size.width*.13:0.0),
                    child: AppBar(
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
                                  ? FontAwesomeIcons.pause
                                  : FontAwesomeIcons.play,size: size.width*.05,color: Colors.white,
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
                            icon:  RotatedBox(
                              quarterTurns: 1,
                              child: Icon(
                                Icons.settings_ethernet,size: size.width*.05,color: Colors.white
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                        leadingWidth:size.width*.25,
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
                          }, icon: Icon(Icons.menu_sharp,size: size.width*.06,color: Colors.white)),
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
                              setState(() {


                              });
                            },
                            icon: const Icon(
                              Icons.highlight_remove,

                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text('${readingApiController.bookName}',style: TextStyle(fontSize: size.width*.04,color: Colors.white,),),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('অধ্যায় ঃ ১',style: TextStyle(fontSize: size.width*.03,color: Colors.black,),),
                            ),
                          ],),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*.05),
                          child: Container(
                            color: Colors.black54,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text('0',style: TextStyle(fontSize: size.width*.03,color: Colors.grey),),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text('১',style: TextStyle(fontSize: size.width*.035,color: Colors.white,fontWeight: FontWeight.bold),),
                                ),
                                Text('২',style: TextStyle(fontSize: size.width*.03,color: Colors.grey),),
                              ],),
                          ),
                        ),
                        IconButton(onPressed: (){
                          _displayTextInputDialog(context,readingApiController);
                        },
                          icon: Icon(Icons.bookmark_border_outlined,size: size.width*.06,color: Colors.white,),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            if (_scaffoldKey.currentState!.isEndDrawerOpen == false) {
                              _scaffoldKey.currentState!.openEndDrawer();
                            } else if(_scaffoldKey.currentState!.isEndDrawerOpen == true){
                              Navigator.pop(context);
                            }
                          });
                        }, icon: Icon(Icons.more_vert_outlined,size: size.width*.06,color: Colors.white,)),
                      ],
                    ),
                  ),

                  body: Scaffold(
                    backgroundColor: bgColor,
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
                                      decoration:  const BoxDecoration(
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
                                    return InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text('${index + 1}.  1',style: const TextStyle(fontSize: 20),),
                                      ),
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
                              const Text('Line Alignment',style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [
                                    IconButton(
                                      onPressed: (){
                                        setState(() {

                                          alignment='leftAlign';

                                        });
                                      },
                                      icon: const Icon(Icons.format_align_left,size: 25.0,),),
                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                          alignment='center';

                                        });

                                      },
                                      icon: const Icon(Icons.format_align_center,size: 25.0,),),

                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                          alignment='justify';
                                        });
                                      },
                                      icon: const Icon(Icons.format_align_justify_outlined,size: 25.0,),),
                                  ],),
                              ),
                              const Text('Line space',style: TextStyle(fontSize: 20),),
                              Padding(
                                padding:  const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children:  [

                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                        lineSpacing = 1.5;
                                        });
                                      },
                                      icon: const Icon(Icons.format_line_spacing_outlined,size: 20),),

                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                         lineSpacing = 2.0;
                                        });
                                      },
                                      icon: const Icon(Icons.format_line_spacing_outlined,size: 25),),
                                    IconButton(
                                      onPressed: (){
                                        setState(() {
                                       lineSpacing = 2.5;
                                        });

                                      },
                                      icon: const Icon(Icons.format_line_spacing_outlined,size: 25),),


                                  ],),
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text('Review book',style: TextStyle(fontSize: 20),),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child:Text('Download book',style: TextStyle(fontSize: 20),),
                              ),


                              const Text('Share book',style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: InkWell(
                      onTap: (){
                        readingApiController.updateScreenFitMode(false);
                        print('onTap');
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

                                      child: InkWell(
                                        onTap: (){
                                          readingApiController.updateScreenFitMode(false);
                                          print('ll');
                                        },
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
                                                      onTap: (){

                                                      },
                                                      child: buildSelectableText(readingApiController),
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
              )
          ),
        );
      }
    );
  }

  void _settingModalBottomSheet(context){
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc){
          return Container(
            height: size.height*.9,
            child: Scaffold(

              backgroundColor: Colors.white,

              body:  DefaultTabController(
                length: 3,
                initialIndex: 0,

                child: Column(
                  children:  [
                     Material(
                      color: Colors.red,
                      child: SafeArea(
                        child: Stack(
                          children:[
                            Positioned(
                            child: IconButton(onPressed: (){
                              Get.back();
                            }, icon: const Icon(Icons.cancel,color: Colors.white,))
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width*.15),
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
                            ]
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            height: size.height*.8,
                            width: size.width,

                            child: ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,int index){
                                  return  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                        Icon(Icons.bookmark),
                                        SizedBox(width: size.width*.02,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text("Test"),
                                              Text("02. হরিহর রায়ের আদি বাসস্থান"),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.delete,color: Colors.red,),
                                      ],),
                                    ),
                                  ) ;

                                }
                            ),
                          ),
                          Container(
                            height: size.height*.8,
                            width: size.width,

                            child: ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,int index){
                                  return  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Icon(Icons.save_outlined),
                                        SizedBox(width: size.width*.02,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text("নিহত"),
                                              Text("02. হরিহর রায়ের আদি বাসস্থান"),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.delete,color: Colors.red,),
                                      ],),
                                    ),
                                  ) ;
                                }
                            ),
                          ),
                          Container(
                            height: size.height*.8,
                            width: size.width,
                            child: ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,int index){
                                  return  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Icon(Icons.note),
                                        SizedBox(width: size.width*.02,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text("Test Note"),
                                              Text("02. নিহত"),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.delete,color: Colors.red,),
                                      ],),
                                    ),
                                  ) ;
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context,ReadingApiController readingApiController) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bookmark'),
            content: TextField(
              onChanged: (value) {
                setState(() {
               //   valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "My bookmark"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {



                  print('ID ${readingApiController.bookId}');
                  print('Title ${_textFieldController.text}');
                  print('Content ${book.sections[index].fileName}');



                  setState(() {
                   // codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }

  double returnSize(){
    return selectedSize;
  }

  late SelectableText selectableTextWidget;

  SelectableText buildSelectableText(ReadingApiController readingApiController) {

   // print(' ssss${readingApiController.selectedFont.value}');
    selectableTextWidget = SelectableText.rich(


      TextSpan(
       // text: _readerBloc.allText,
        children:
        handleHighlight(_readerBloc.allText,readingApiController.redingFontSize.value,readingApiController.selectedFont.value),
        style: TextStyle(
          color: fontColor!.withOpacity(_opecityVal),
           height: lineSpacing,

          decorationStyle: TextDecorationStyle.wavy,
        ),

      ),
       textAlign:   alignment=='justify'? TextAlign.justify:alignment=='center'?TextAlign.center:TextAlign.left,

      textScaleFactor: _readerBloc.scaleFactor,
      toolbarOptions: const ToolbarOptions(copy: false, selectAll: false),
      onTap: () {

      },
      // selectionControls: FlutterSelectionControls(toolBarItems: <ToolBarItem>[
      //   ToolBarItem(
      //     item: const Text('Copy'),
      //     // itemControl: ToolBarItemControl.copy,
      //     onItemPressed: (String highlightedText, int startIndex, int endIndex) {
      //       shareHighlightedString(highlightedText);
      //     },
      //   ),
      //   ToolBarItem(
      //     item: const Text('Highlights'),
      //     onItemPressed: (String highlightedText, int startIndex, int endIndex) {
      //       shareHighlightedString(highlightedText);
      //       var date = DateTime.now();
      //       var currentDate = '${date.day}-${date.month}-${date.year}';
      //       print(currentDate);
      //       HeighlightDatabaseHelper hdh =  HeighlightDatabaseHelper();
      //       HeightLightModel heightLightModel =  HeightLightModel('Chapter one','$currentDate','$highlightedText','$currentPosition');
      //       hdh.insertHeightLightData(heightLightModel);
      //     },
      //   ),
      // ]),
      //
      //
      selectionControls: MyMaterialTextSelectionControls(
          onTapped: onTappedMenuButton,
          currentTextSelection: currentTextSelection),


      onSelectionChanged: (selection, cause) async {

        print(currentTextSelection);
        if (selection.baseOffset == selection.extentOffset) {
          findBeforeAndAfterWords(selection,readingApiController);
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
    setState(() {

  //    print('aaaaaaaaaaaaa ${book.sections[index].fileName}');
    });

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

  handleHighlight(String text ,double fontSize,String selectedFont) {
    int index = 0;
    final int length = text.length;
    final List<TextSpan> widgets = [];
    print(text);
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

  void findBeforeAndAfterWords(TextSelection selection,ReadingApiController readingApiController) {
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


      readingApiController.updateScreenFitMode(false);


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
