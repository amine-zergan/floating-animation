// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bottomanimation/details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'bootom animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            iconSize: 25,
            backgroundColor: Color.fromARGB(255, 125, 195, 249),
          ),
          iconTheme:
              const IconThemeData(color: Color.fromRGBO(151, 151, 236, 1)),
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(elevation: 0.0)),
      home: const MyHomePage(title: 'Flutter Demo Nav Animation'),
      //home: const PaintWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey floatingKey = GlobalKey();
  bool isdrag = false;
  Offset offset = const Offset(0.0, 0.0);
  double _translation = 40.0;
  // ignore: unused_element

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInCubic,
        width: double.infinity,
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 100),
                  opacity: isdrag ? 0 : 1,
                  child: Text(
                    'Events',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: const Color.fromRGBO(55, 81, 205, 1),
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 45.0,
                  ),
                  child: NavigationBottom(isdrag: isdrag),
                ),
              ),
              isdrag
                  ? AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.elasticOut,
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      // ignore: sized_box_for_whitespaces
                      child: ClipPath(
                        clipper: Background(offset: offset),
                        child: Container(
                          color: const Color.fromARGB(255, 125, 195, 249),
                          width: double.infinity,
                          height: size.height,
                        ),
                      ),
                    )
                  : Container(),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 50),
                curve: Curves.linearToEaseOut,
                left: size.width / 2 - 50,
                bottom: _translation,
                right: size.width / 2 - 50,
                child: GestureDetector(
                  onVerticalDragStart: ((details) {
                    setState(() {
                      isdrag = true;
                      offset = details.localPosition;
                      _translation = 40;
                    });
                  }),
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      offset = details.localPosition;
                      print(offset);
                      _translation = 30 + (-details.localPosition.dy);
                    });
                  },
                  onVerticalDragEnd: (details) {
                    setState(() {
                      offset = const Offset(51.0, 70.7);
                    });
                    Get.to<double>(() => const DetailsPage(),
                            transition: Transition.fade,
                            duration: const Duration(milliseconds: 200))!
                        .then((value) {
                      print(value);
                      setState(() {
                        isdrag = false;
                        _translation = 40;
                        offset = const Offset(0.0, 0.0);
                      });
                    });
                  },
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () async {
                      double? position = await Get.to<double>(
                          () => const DetailsPage(),
                          transition: Transition.fadeIn,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticInOut);
                      setState(() {
                        _translation = position!;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 25,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBottom extends StatelessWidget {
  const NavigationBottom({
    Key? key,
    required this.isdrag,
  }) : super(key: key);

  final bool isdrag;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      opacity: isdrag ? 0.6 : 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavigationItem(
            icon: Icons.emoji_flags_rounded,
            onTap: () {},
          ),
          BottomNavigationItem(
            onTap: () {},
            icon: Icons.search_rounded,
          ),
          SizedBox(
            width: size.width * 0.1,
          ),
          BottomNavigationItem(
            onTap: () {},
            icon: Icons.flash_on_outlined,
          ),
          BottomNavigationItem(
            onTap: () {},
            icon: Icons.emoji_events_outlined,
          )
        ],
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: onTap,
        child: Icon(
          icon,
          size: 35,
        ),
      ),
    );
  }
}

class Background extends CustomClipper<Path> {
  final Offset? offset;
  Background({
    this.offset,
  });
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2 - 30, size.height - 10,
        size.width / 2 - 30, size.height + offset!.dy - 50);
    path.conicTo(size.width / 2, size.height + offset!.dy - 120,
        size.width / 2 + 30, size.height + offset!.dy - 50, 0.6);
    path.quadraticBezierTo(
        size.width / 2 + 30, size.height - 10, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
