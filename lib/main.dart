import 'dart:math';

import 'package:card/colors.dart';
import 'package:card/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ndialog/ndialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card.dart';
import 'edit_card_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: const ColorScheme(
              primary: darkGreen,
              primaryVariant: darkGreen,
              secondary: lightBlue,
              secondaryVariant: lightBlue,
              surface: lightBlue,
              background: lightBlue,
              error: confettiRed,
              onPrimary: darkGreen,
              onSecondary: darkGreen,
              onSurface: darkGreen,
              onBackground: darkGreen,
              onError: confettiRed,
              brightness: Brightness.light)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScaffold(),
      },
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

double minSlideHeight = 360.0;
double maxSlideHeight = 530.0;

class _MainAppState extends State<MainApp> {
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        backdropEnabled: true,
        minHeight: minSlideHeight,
        maxHeight: maxSlideHeight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),

        //=============== Slide Panel ===============
        panel: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 70,
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  //=============== Edit Card ===============
                  GestureDetector(
                    onTap: () {
                      // ignore: avoid_print
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditCardScreen()),
                      );
                      // ignore: avoid_print
                      print("Edit Card");
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ),
                        color: darkGreen,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.credit_card_rounded,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                            child: Text(
                              "Edit your card",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              //=============== Spenden Card ===============

              GestureDetector(
                onTap: () {
                  //=============== Alert Code ===============
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: alertBlue,
                    content: SizedBox(
                      height: 270,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: const Icon(Icons.clear_rounded),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40.0,
                                  child: Icon(
                                    Icons.public,
                                    color: Colors.black,
                                    size: 80.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Thanks for your help!",
                                          style: TextStyle(
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "With every selled card we spend 10% to the greenpeace safe the forest fundation. ~Greenpeace",
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ConfettiWidget(
                                shouldLoop: false,
                                confettiController: _controllerBottomCenter,
                                blastDirection: -pi / 2,
                                emissionFrequency: 0.01,
                                numberOfParticles: 20,
                                maxBlastForce: 60,
                                particleDrag: 0.06,
                                minBlastForce: 20,
                                gravity: 0.3,
                                colors: const [
                                  confettiBlue,
                                  confettiGreen,
                                  confettiGreen,
                                  confettiGreen,
                                  confettiBlue,
                                  confettiRed,
                                  confettiYellow
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).show(context);

                  _controllerBottomCenter.play();
                  // ignore: avoid_print
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: lightBlue,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 20.0),
                          child: SizedBox(
                            child: Center(child: Icon(Icons.public)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "You support the enviourment!",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              width: 245,
                              child: Text(
                                "With every selled card we spend 10% to the greenpeace safe the forest fundation",
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //=============== QR Code ===============
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  // ignore: avoid_print
                  print(
                    "QR-Code",
                  );
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Colors.white,
                    content: AlertQRCode(),
                  ).show(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 50.0,
                          child: Center(
                            child: Icon(Icons.memory),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "QR Code",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Share your conected page per social media.",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //=============== QR Code ===============
              const SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.lock,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Soon, get even more out of your card!",
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Material(
                      child: InkWell(
                        onTap: () {
                          print("Link tree");
                        },
                        child: Ink(
                          child: Container(
                            width: double.infinity,
                            height: 180.0,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('lib/img/card_bg.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          "Link trees are soon availabe.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        child: Icon(
                                          Icons.navigate_next,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Text(
                                    "Soon you can link all your socialmedia plattforms at one space.",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        //=============== Background Panel ===============
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 65.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ignore: prefer_const_constructors
                Text(
                  "Hello,",
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 22),
                ),
                // ignore: prefer_const_constructors
                Text(
                  "Leon Schmidt",
                  style:
                      // ignore: prefer_const_constructors
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                //=============== NFC Card  ===============
                const SizedBox(
                  height: 25.0,
                ),
                FlipCard(
                  fill: Fill
                      .fillBack, // Fill the back side of the card to make in the same size as the front.
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        //=============== front Card  ===============

                        Container(
                          height: double.infinity,
                          width: 120.0,
                          decoration: const BoxDecoration(
                            color: accentCardColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(200),
                              bottomLeft: Radius.circular(200),
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: SizedBox(
                                      width: 50.0,
                                      child: Image.asset(
                                          'lib/img/fluid-white.png'),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      'Leon Schmidt',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    height: 180.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  //=============== back Card  ===============
                  back: Container(
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100.0,
                                child: Image.asset('lib/img/fluid-white.png'),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Card',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    height: 180.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.help,
                      size: 20.0,
                      color: greenGrey,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(
                      "Hold your card one the back of your Phone.",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertQRCode extends StatelessWidget {
  const AlertQRCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.clear),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
