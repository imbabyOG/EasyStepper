import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int activeStep = 0;
  int activeStep2 = 0;
  int reachedStep = 0;
  int upperBound = 5;
  double progress = 0.2;
  Set<int> reachedSteps = <int>{0, 2, 4, 5};
  final dashImages = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
  ];

  void increaseProgress() {
    if (progress < 1) {
      setState(() => progress += 0.2);
    } else {
      setState(() => progress = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          backgroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: EasyStepper(
              activeStep: activeStep,
              internalPadding: 8,
              showLoadingAnimation: false,
              stepRadius: 8,
              showStepBorder: true,
              direction: Axis.horizontal,
              alignment: Alignment.centerLeft,
              activeStepTextColor: Colors.black,
              unreachedStepTextColor: Colors.black,
              unreachedStepBackgroundColor: const Color(0xffFFCECE),
              unreachedStepBorderColor: const Color(0xffFFCECE),
              unreachedStepIconColor: const Color(0xffFFCECE),
              activeStepBorderColor: Colors.white,
              activeStepIconColor: Colors.white,
              activeStepBackgroundColor: Colors.red,
              lineStyle: const LineStyle(
                  lineType: LineType.normal,
                  activeLineColor: Colors.red,
                  unreachedLineColor: Color(0xffFFCECE),
                  lineSpace: 0,
                  lineThickness: 2),
              unreachedStepBorderType: BorderType.normal,
              steps: [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
              ]
                  .map((e) => const EasyStep(
                        customStep: CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.white,
                        ),
                        title: "\$50",
                        subTitle: "earning",
                      ))
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: increaseProgress),
      ),
    );
  }

  bool _allowTabStepping(int index, StepEnabling enabling) {
    return enabling == StepEnabling.sequential
        ? index <= reachedStep
        : reachedSteps.contains(index);
  }

  /// Returns the next button.
  Widget _nextStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 < upperBound) {
          setState(() {
            if (enabling == StepEnabling.sequential) {
              ++activeStep2;
              if (reachedStep < activeStep2) {
                reachedStep = activeStep2;
              }
            } else {
              activeStep2 =
                  reachedSteps.firstWhere((element) => element > activeStep2);
            }
          });
        }
      },
      icon: const Icon(Icons.arrow_forward_ios),
    );
  }

  /// Returns the previous button.
  Widget _previousStep(StepEnabling enabling) {
    return IconButton(
      onPressed: () {
        if (activeStep2 > 0) {
          setState(() => enabling == StepEnabling.sequential
              ? --activeStep2
              : activeStep2 =
                  reachedSteps.lastWhere((element) => element < activeStep2));
        }
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }
}

enum StepEnabling { sequential, individual }
