import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/video_play.dart';

void main() => runApp(const NavBarApp());
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}
class NavBarApp extends StatelessWidget {
  const NavBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  CupertinoApp(scrollBehavior: CupertinoScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.trackpad,PointerDeviceKind.touch, PointerDeviceKind.stylus, PointerDeviceKind.unknown}),
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: NavBarExample(),
    );
  }
}

class NavBarExample extends StatefulWidget {
  const NavBarExample({super.key});

  @override
  State<NavBarExample> createState() => _NavBarExampleState();
}

class _NavBarExampleState extends State<NavBarExample> {
  double pos = 0;
  Future<List<String>> initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    print( manifestMap.keys.toString());

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/images/'))

        .toList();
    return imagePaths;


  }
  _scrollListener() {

    setState(() {
      pos = _controller.offset;
      print(pos);
    });
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {

    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // setState(() {
      //   message = "reach the top";
      // });
    }
  }
  final pageController = PageController(initialPage: 0);
  late ScrollController _controller ;
  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }
  final outerController = ScrollController();
  final innerController = ScrollController();
  int _index = 0;
  //final pageController = PageController();
  final _animationDuration = Duration(milliseconds: 500);
  final _curve = Curves.ease;
  ScrollPhysics mainScroll = AlwaysScrollableScrollPhysics();
  double scrollValue = 0.0 ;
  List instructions = [
    {"img":"assets/images/a1.jpg","title":"Scan and Setup","description":"Follow the laminated instruction document shipped with kits to create your own account. "},
    {"img":"assets/images/a2.jpg","title":"Login into the App","description":"You can login as many devices as you want,create as many users you need",},
    {"img":"assets/images/s3.jpg","title":"Explore your tests","description":"Browse all the tests you have done . See the graphs , gps locations ,photos and videos yoy have taken"},
    {"img":"assets/images/s4.jpg","title":"Perform a test","description":"Perform your desired test setting you preffered taget load and time duraration",},
    {"img":"assets/images/s6.jpg","title":"Take photos and videos","description":"Take as much photos and videos you need before and while running the test, while having eye on the load graphs",},
    {"img":"assets/images/s7.jpg","title":"Clear instructions","description":"The app will give you clear instructions about what to do and when",},
    {"img":"assets/images/s8.jpg","title":"Proof load test","description":"You can perform fixed time load test againts a target load",},
    //{"title":"Peace of mind","description":"You can decide when you want to start the timer",},
    {"img":"assets/images/s9.jpg","title":"Picture in Picture","description":"Continue your important task while running the test",},
    {"img":"assets/images/s13.jpg","title":"Save your test","description":"Give the a name and description",},
    {"img":"assets/images/s17.jpg","title":"Files and Folders","description":"All your tests are saved in Files and Folders , so you can manage your tasks",},
    {"img":"assets/images/s14.jpg","title":"View your test","description":"Open and view any tests, any where",},
    {"img":"assets/images/s15.jpg","title":"Lots of Metadata","description":"Every tests comes with usefull meta data",},



  ];

  ScrollController ccc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:  Text('Shop',style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 12, letterSpacing: .5),
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:  Text('About us',style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 12, letterSpacing: .5),
              ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:  Text('App login',style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 12, letterSpacing: .5),
              ),),
            ),
          ],
        ),
      ),
      child:   SingleChildScrollView(physics:mainScroll ,controller: ccc,
        child: Column( mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(height:MediaQuery.of(context).size.height*0.75 ,color:Colors.black ,
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1,bottom: 0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Digital Pull Tester",style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.05, letterSpacing: .5,fontWeight: FontWeight.bold),
                          ),),
                          Text("Staht 60 kN",style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, letterSpacing: .5,fontWeight: FontWeight.bold),
                          ),),
                          Padding(
                            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(onPressed: (){}, child: Row(
                                  children: [
                                    Text("Lean more",style: GoogleFonts.poppins(
                                      textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, letterSpacing: .5),
                                    ),),
                                    Icon(Icons.navigate_next),
                                  ],
                                ),),
                                TextButton(onPressed: (){}, child:  Row(
                                  children: [
                                    Text("Buy",style: GoogleFonts.poppins(
                                      textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, letterSpacing: .5),
                                    ),),
                                    Icon(Icons.navigate_next),
                                  ],
                                ),),
                                TextButton(onPressed: (){
                                  // ,child: ButterFlyAssetVideo()

                                //  showCupertinoDialog(context: context, builder: builder)

                                  showGeneralDialog(
                                   // barrierDismissible: true,
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    pageBuilder: (_, __, ___) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Container(
                                            color: Colors.white, // Dialog background
                                           // width: 120, // Dialog width
                                           // height: 50, // Dialog height
                                            child: ButterFlyAssetVideo(),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                if(false)  showCupertinoDialog(
                                    context: context,
                                    builder: (ctx) => CupertinoAlertDialog(
                                      content: ButterFlyAssetVideo(),
                                    ),
                                  );
                                }, child:  Row(
                                  children: [
                                    Text("View a demo",style: GoogleFonts.poppins(
                                      textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, letterSpacing: .5),
                                    ),),
                                    Icon(Icons.navigate_next),
                                  ],
                                ),),

                              ],
                            ),
                          ),
                        ],
                      ),

                      Image.asset("assets/images/t3.png",height: MediaQuery.of(context).size.height*0.5,),
                    ],
                  ),
                ),
              ),
            ),
            Container(height:MediaQuery.of(context).size.height*0.75 ,width: MediaQuery.of(context).size.width,
              color: Colors.white,child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Text('Staht t60',style: GoogleFonts.lexend(
                      textStyle: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.05, letterSpacing: .5,color: Colors.black,fontWeight: FontWeight.bold),
                    ),),
                    Text('Compact and digital',style: GoogleFonts.lexend(
                      textStyle: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.03, letterSpacing: .5,color: Colors.black),
                    ),),
                  ],),

                  Padding(
                    padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){}, child: Row(
                          children: [
                            Text("Lean more",style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, letterSpacing: .5),
                            ),),
                            Icon(Icons.navigate_next),
                          ],
                        ),),
                        TextButton(onPressed: (){}, child:  Row(
                          children: [
                            Text("Buy",style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02, letterSpacing: .5),
                            ),),
                            Icon(Icons.navigate_next),
                          ],
                        ),),


                      ],
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05  ),
                    child: Image.asset("assets/mm.png",height:MediaQuery.of(context).size.height*0.45 ),
                  ),
                ],
              ),),


            Container(height:MediaQuery.of(context).size.height*0.97,width:MediaQuery.of(context).size.width ,
              child:  Column( mainAxisSize: MainAxisSize.min,
                children: [

                  Text(instructions[_index??0]["title"],style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.05, letterSpacing: .5,fontWeight: FontWeight.bold),
                  ),),
                  Expanded(
                    child: Row(
                      children: [
                        Container(width: MediaQuery.of(context).size.width * 0.3,
                          child: Padding(
                            padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                            child: Text(instructions[_index??0]["description"],style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03, letterSpacing: .5,fontWeight: FontWeight.bold),
                            ),),
                          ),
                        ),
                        Container(width: MediaQuery.of(context).size.width * 0.7,
                          child: Listener(
                            onPointerSignal: (pointerSignal) async {

                              print(" value  "+scrollValue.toString());
                              if (pointerSignal is PointerScrollEvent) {
                                // print(pointerSignal.scrollDelta);
                                //&& pageController.page==snapshot.data!.length
                                // if (pointerSignal.scrollDelta.dy > 0 && pageController.page!=0) {
                                //   setState(() {
                                //     mainScroll = NeverScrollableScrollPhysics();
                                //   });
                                // }
                                if (pointerSignal.scrollDelta.dy ==-100   ){
                                 // print(pageController.page);

                                  if(scrollValue == 0.0){
                                    scrollValue = ccc.offset;
                                  }
                                  setState(() {
                                    mainScroll = NeverScrollableScrollPhysics();
                                  });

                                }
                                if( pageController.page==0){
                                  setState(() {

                                    mainScroll = AlwaysScrollableScrollPhysics();
                                  });
                                }
                                if (pointerSignal.scrollDelta.dy > 0) {

                                  await   pageController.nextPage(
                                      curve: _curve, duration: _animationDuration).then((value) {
                                    setState(() {
                                    });

                                  });
                                } else {
                                  if(scrollValue>0){
                                    ccc.animateTo(scrollValue, duration: Duration(milliseconds: 100), curve: _curve);
                                  }

                                  await  pageController.previousPage(
                                      duration: _animationDuration, curve: _curve).then((value) {
                                    setState(() {
                                    });

                                  });
                                }
                              }
                            },
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: pageController,
                              scrollDirection: Axis.horizontal,
                              pageSnapping: true,
                              onPageChanged: (index) {
                                setState(() {
                                  _index = index;
                                });

                              },
                              children:  instructions.map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(decoration: BoxDecoration(border: Border.all(width: 5,color: Colors.white)),child: Image.asset(e["img"],height: MediaQuery.of(context).size.height*0.55,)),
                              )).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  //  Image.asset("pre.png",),
                ],
              ),
            ),

/*
                Container(height: 50, color: CupertinoColors.systemRed),
                Container(height: 50, color: CupertinoColors.systemGreen),
                Container(height: 50, color: CupertinoColors.systemBlue),
                Container(height: 50, color: CupertinoColors.systemYellow),

 */
          ],
        ),
      ),
    );
  }
}
