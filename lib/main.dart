// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:async';
import "funcs.dart";
import "classes.dart";

void main() {
  runApp(const MyFirstApp());
}

class MyFirstApp extends StatefulWidget {
  const MyFirstApp({super.key});

  @override
  State<MyFirstApp> createState() => _MyFirstAppState();
}

class _MyFirstAppState extends State<MyFirstApp> {
  double antimatter = 10;

  double tickFactor = 0.1;
  int tickCost = 1000;
  double defaultTickFactor = 0.1;
  double tickIncrement = 1.11;
  int dimBoost = 0;
  int _selectedIndex = 0;
  int dimGal = 0;

  Dimension dim1 = Dimension(10.toDouble(), 1000);
  Dimension dim2 = Dimension(100.toDouble(), 10000);
  Dimension dim3 = Dimension(10000.toDouble(), 100000);
  Dimension dim4 = Dimension(1000000.toDouble(), 1000000);
  Dimension dim5 = Dimension(1000000000.toDouble(), 100000000);
  Dimension dim6 = Dimension(10000000000000.toDouble(), 10000000000);
  Dimension dim7 = Dimension(1000000000000000000.toDouble(), 1000000000000);
  Dimension dim8 =
      Dimension(double.parse("1000000000000000000000000"), 1000000000000000);

  UIMode lightMode = UIMode("light", {
    "navBackgroundColor": const Color.fromARGB(255, 38, 143, 132),
    "navIconColor": const Color.fromARGB(255, 255, 255, 255)
  }, {
    "buttonBackgroundColor": const Color.fromARGB(255, 180, 180, 180),
    "buttonTextColor": const Color.fromARGB(255, 0, 0, 0),
    "buttonBorderColor": const Color.fromARGB(255, 117, 0, 0),
    "buttonGlowBackgroundColor": const Color.fromARGB(255, 84, 161, 101),
    "buttonGlowBorderColor": const Color.fromARGB(255, 9, 87, 22)
  }, {
    "appBarBackgroundColor": const Color.fromARGB(255, 38, 143, 132),
    "appBarTextColor": const Color.fromARGB(255, 255, 255, 255)
  }, {
    "bodyBackgroundColor": const Color.fromARGB(255, 255, 255, 255),
    "bodyTextColor": const Color.fromARGB(255, 0, 0, 0)
  });
  UIMode darkMode = UIMode("dark", {
    "navBackgroundColor": const Color.fromARGB(255, 0, 0, 0),
    "navIconColor": const Color.fromARGB(255, 255, 255, 255)
  }, {
    "buttonBackgroundColor": const Color.fromARGB(255, 51, 51, 51),
    "buttonTextColor": const Color.fromARGB(255, 255, 255, 255),
    "buttonBorderColor": const Color.fromARGB(255, 241, 103, 103),
    "buttonGlowBackgroundColor": const Color.fromARGB(255, 9, 87, 22),
    "buttonGlowBorderColor": const Color.fromARGB(255, 84, 161, 101)
  }, {
    "appBarBackgroundColor": const Color.fromARGB(255, 0, 0, 0),
    "appBarTextColor": const Color.fromARGB(255, 255, 255, 255)
  }, {
    "bodyBackgroundColor": const Color.fromARGB(255, 41, 39, 39),
    "bodyTextColor": const Color.fromARGB(255, 255, 255, 255)
  });

  late UIMode uiMode = lightMode;

  late List<Dimension> dimList = [
    dim1,
    dim2,
    dim3,
    dim4,
    dim5,
    dim6,
    dim7,
    dim8
  ];
  late Timer timer;
  int timerStart = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: uiMode.appBarColors["appBarBackgroundColor"],
          title: Text(
            'Antimatter Dimensions',
            style: TextStyle(
              color: uiMode.appBarColors["appBarTextColor"],
            ),
          ),
        ),
        backgroundColor: uiMode.bodyColors["bodyBackgroundColor"],
        body: IndexedStack(index: _selectedIndex, children: [
          Center(
            child: Column(
              children: [
                ButtonBar(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (antimatter >= tickCost) {
                          setState(() {
                            antimatter -= tickCost;
                            tickFactor = (tickFactor * tickIncrement);
                            tickCost *= 10;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: uiMode.buttonColors["buttonBorderColor"],
                            width: 2,
                          ),
                          color: uiMode.buttonColors["buttonBackgroundColor"],
                        ),
                        child: Text(
                          'Tick Speed: ${(10 * tickFactor).toStringAsPrecision(3)} Times a second Cost ${i2n(tickCost)} \nEach purchase increases the factor by 11% ',
                          style: TextStyle(
                            color: uiMode.buttonColors["buttonTextColor"],
                          ),
                        ),
                      ),
                    ),
                    const Text("\n"),
                    TextButton(
                      onPressed: () {
                        if (timerStart < 1) {
                          timer = Timer.periodic(
                              const Duration(milliseconds: 100), (timer) {
                            setState(() {
                              antimatter += timerCalcs(dimList, tickFactor);
                            });
                          });
                          timerStart++;
                        }
                        setState(() {
                          antimatter -= dim1.onPressedCalculations(antimatter);
                        });
                      },
                      child: dimContent(dim1, "1st", uiMode),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          antimatter -= dim2.onPressedCalculations(antimatter);
                        });
                      },
                      child: dimContent(dim2, "2nd", uiMode),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          antimatter -= dim3.onPressedCalculations(antimatter);
                        });
                      },
                      child: dimContent(dim3, "3rd", uiMode),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          antimatter -= dim4.onPressedCalculations(antimatter);
                        });
                      },
                      child: dimContent(dim4, "4th", uiMode),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (dimBoost >= 1) {
                            antimatter -=
                                dim5.onPressedCalculations(antimatter);
                          }
                        });
                      },
                      child: Req().checkDimBoosts(
                        dimBoost,
                        1,
                        dimContent(dim5, "5th", uiMode),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (dimBoost >= 2) {
                            antimatter -=
                                dim6.onPressedCalculations(antimatter);
                          }
                        });
                      },
                      child: Req().checkDimBoosts(
                        dimBoost,
                        2,
                        dimContent(dim6, "6th", uiMode),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (dimBoost >= 3) {
                            antimatter -=
                                dim7.onPressedCalculations(antimatter);
                          }
                        });
                      },
                      child: Req().checkDimBoosts(
                        dimBoost,
                        3,
                        dimContent(dim7, "7th", uiMode),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (dimBoost >= 4) {
                            antimatter -=
                                dim8.onPressedCalculations(antimatter);
                          }
                        });
                      },
                      child: Req().checkDimBoosts(
                        dimBoost,
                        4,
                        dimContent(dim8, "8th", uiMode),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (Req().dimBoostReq(dimBoost, dimList)) {
                            dimBoost++;
                            Adj().dimBoostAdjustment(dimBoost, dimList);
                            antimatter = 10;
                            tickFactor = defaultTickFactor;
                            tickCost = 1000;
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: uiMode.buttonColors["buttonBackgroundColor"],
                          border: Border.all(
                            color: uiMode.buttonColors["buttonBorderColor"],
                            width: 2,
                          ),
                        ),
                        child: Texts().dimBoostText(dimBoost, uiMode),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (Req().dimGalReq(dimGal, dimList)) {
                            dimGal++;
                            Adj().dimGalAdjustment(dimGal, dimList);
                            antimatter = 10;
                            tickIncrement += 0.02;
                            tickFactor = defaultTickFactor;
                            tickCost = 1000;
                          }
                        });
                      },
                      child: Texts().dimGalText(dimGal, uiMode),
                    ),
                  ],
                ),
                Text(
                  'Antimatter: ${i2n(antimatter)}',
                  style: TextStyle(
                    color: uiMode.bodyColors['bodyTextColor'],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: (() {
                        setState(() {
                          if (uiMode.name == "light") {
                            uiMode = darkMode;
                          } else if (uiMode.name == "dark") {
                            uiMode = lightMode;
                          }
                        });
                      }),
                      child: Texts().optionButtonText(
                          "Current Mode: \n${uiMode.name}", uiMode),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "",
                icon: Text(
                  'D',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Text(
                  'O',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                ),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.black),
      ),
    );
  }
}
