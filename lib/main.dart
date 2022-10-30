import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animated Burger Icon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double upperRotateValue =
      0; // The rotate value of the upper line (the angle)!
  double bottomRotateValue =
      0; // The rotate calue of the bottom line (the angle)!
  double middleLineMovement =
      0; // To move the middle line when the animation is started!
  double opacity = 1.0; // the opacity of the middle line.

  /*
   * let's define a color to change it when the icon is clicked!
   */
  Color color = Colors.green;

  /*
   * We need this cariable to start the animation
   * and to stop it as well!!!
   */
  bool isPlayed = false;
  void startAnimation() {
    setState(() {
      if (!isPlayed) {
        color = Colors.red;
        opacity = 0.0;
        upperRotateValue = pi / 4;
        bottomRotateValue = -pi / 4;
        middleLineMovement = -50;
      } else {
        color = Colors.green;
        opacity = 1.0;
        upperRotateValue = 0;
        bottomRotateValue = 0;
        middleLineMovement = 0;
      }
      isPlayed = !isPlayed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      /**
       * We use the 'Align' Widget to align the menu icon "Burger-Icon"
       * to the top-right corner!!
       */
      body: Align(
        alignment: Alignment.topRight,
        /**
         * We use the 'InkWell' Widget to make the "Burger-Icon" clickable!!
         */
        child: InkWell(
          onTap: () {
            startAnimation();
          },
          child: Container(
            margin: const EdgeInsets.all(10.0),
            height: 25,
            width: 28,
            child: Column(
              children: [
                /**
                 * We use 'TweenAnimationBuilder' to animate the movement of the lines!!
                 */
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0,
                    end: upperRotateValue,
                  ),
                  duration: const Duration(milliseconds: 500),
                  builder: (_, val, child) => Transform.rotate(
                    angle: val,
                    alignment: Alignment.centerLeft,
                    child: child,
                  ),
                  /**
                   * The first line of the 'Burger-Icon'
                   */
                  child: Container(
                    width: double.infinity,
                    height: 5,
                    color: color,
                  ),
                ),
                /**
                 * Blank space between the upper and the middle lines
                 */
                const SizedBox(
                  height: 5,
                ),
                /**
                 * The second line of the 'Burger-Icon'
                 */
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0,
                    end: middleLineMovement,
                  ),
                  duration: const Duration(milliseconds: 500),
                  builder: (_, val, child) => Transform.translate(
                    offset: Offset(val, 0),
                    child: child,
                  ),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: double.infinity,
                      height: 5,
                      color: Colors.green,
                    ),
                  ),
                ),
                /**
                 * Blank space between the middle and the bottom lines
                 */
                const SizedBox(
                  height: 5,
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(
                    begin: 0,
                    end: bottomRotateValue,
                  ),
                  duration: const Duration(milliseconds: 500),
                  builder: (_, val, child) => Transform.rotate(
                    angle: val,
                    alignment: Alignment.centerLeft,
                    child: child,
                  ),
                  /**
                   * The third line of the 'Burger-Icon'
                   */
                  child: Container(
                    width: double.infinity,
                    height: 5,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
