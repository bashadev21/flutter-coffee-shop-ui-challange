import 'dart:ui';

import 'package:coffee_shop_ui_challange/coffee_model.dart';
import 'package:flutter/material.dart';

import 'details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controler = PageController(viewportFraction: 0.3);
  final _controller1 = PageController();

  double curntpage = 0.0;
  double textpage = 0.0;
  void listener() {
    setState(() {
      curntpage = _controler.page!;
    });
  }

  void textlistner() {
    textpage = curntpage;
  }

  @override
  void initState() {
    _controler.addListener(listener);
    _controller1.addListener(textlistner);

    super.initState();
  }

  @override
  void dispose() {
    _controler.removeListener(listener);
    _controller1.removeListener(textlistner);
    _controler.dispose();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
              height: MediaQuery.of(context).size.height * 0.3,
              left: 20,
              right: 20,
              bottom: -MediaQuery.of(context).size.height * 0.2,
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                      color: Colors.brown,
                      blurRadius: 90,
                      offset: Offset.zero,
                      spreadRadius: 45)
                ]),
              )),
          Transform.scale(
            scale: 1.9,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(

                // onPageChanged: (value) {
                //   if (value <= coffees.length) {
                //     _controller1.animateToPage(value,
                //         duration: const Duration(milliseconds: 300),
                //         curve: Curves.easeOut);
                //   }
                // },
                controller: _controler,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length,
                itemBuilder: (context, index) {
                  final coffee = coffees[index];
                  final result = curntpage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  print(result);
                  return Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(2, 2, .001)
                        ..translate(
                            0.0,
                            MediaQuery.of(context).size.height /
                                2.6 *
                                (1 - value).abs())
                        ..scale(value),
                      child: Opacity(
                          opacity: opacity,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 1),
                                      pageBuilder: (_, __, ___) => DetailsPage(
                                          coffee.image,
                                          coffees[curntpage.toInt()]
                                              .price
                                              .toString(),
                                          coffees[curntpage.toInt()]
                                              .name
                                              .toString())));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DetailsPage(
                              //             coffee.image,
                              //             coffees[curntpage.toInt()]
                              //                 .price
                              //                 .toString(),
                              //             coffees[curntpage.toInt()]
                              //                 .name
                              //                 .toString())
                              //                 )
                              //       );
                            },
                            child: Hero(
                              tag: coffee.image,
                              child: Image.asset(
                                coffee.image,
                                width: MediaQuery.of(context).size.width * 0.9,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )));
                }),
          ),
          Positioned(
              height: 100,
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Expanded(
                      child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      ' ${coffees[curntpage.toInt()].name.toString()}',
                      key: Key(coffees[curntpage.toInt()].name),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  )),
                  // Expanded(
                  //     child: PageView.builder(
                  //         controller: _controller1,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemBuilder: (context, index) {
                  //           final coffee = coffees[index];
                  //           final opactiy = (1 - textpage).abs()
                  //             ..clamp(0.0, 1.0);
                  //           return Opacity(
                  //               opacity: opactiy, child: Text(coffee.name));
                  //         })),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      '\$ ${coffees[curntpage.toInt()].price.toString()}',
                      key: Key(coffees[curntpage.toInt()].name),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
