import 'package:bmi_calculator/application/components/bottom_button.dart';
import 'package:bmi_calculator/application/components/icon_content.dart';
import 'package:bmi_calculator/application/components/reusable_card.dart';
import 'package:bmi_calculator/application/components/round_icon_button.dart';
import 'package:bmi_calculator/domain/calculator_brain.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/application/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier gendernotifier = ValueNotifier(Gender);
    ValueNotifier heightnotifier = ValueNotifier(180);
    ValueNotifier weightnotifier = ValueNotifier(60);
    ValueNotifier agenotifier = ValueNotifier(20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: gendernotifier,
                builder: (context, value, _) => ReusableCard(
                  onPress: () {
                    gendernotifier.value = Gender.male;
                  },
                  colour: gendernotifier.value == Gender.male
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: const IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: 'MALE',
                  ),
                ),
              )),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: gendernotifier,
                builder: (context, value, _) => ReusableCard(
                  onPress: () {
                    gendernotifier.value = Gender.female;
                  },
                  colour: gendernotifier.value == Gender.female
                      ? kActiveCardColour
                      : kInactiveCardColour,
                  cardChild: const IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: 'FEMALE',
                  ),
                ),
              )),
            ],
          )),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      ValueListenableBuilder(
                        valueListenable: heightnotifier,
                        builder: (context, value, _) => Text(
                          // height.toString(),
                          heightnotifier.value.toString(),
                          style: kNumberTextStyle,
                        ),
                      ),
                      const Text(
                        'cm',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  Expanded(
                    child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: Color(0xFF8D8E98),
                          activeTrackColor: Colors.white,
                          thumbColor: Color(0xFFEB1555),
                          overlayColor: Color(0x29EB1555),
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: heightnotifier,
                          builder: (context, value, _) => Slider(
                            value: heightnotifier.value.toDouble(),
                            min: 120.0,
                            max: 220.0,
                            onChanged: (double newValue) {
                              heightnotifier.value = newValue.round();
                            },
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        ValueListenableBuilder(
                          valueListenable: weightnotifier,
                          builder: (context, value, child) => Text(
                            weightnotifier.value.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  weightnotifier.value--;
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                weightnotifier.value++;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        ValueListenableBuilder(
                          valueListenable: agenotifier,
                          builder: (context, value, child) => Text(
                            agenotifier.value.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                agenotifier.value--;
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  agenotifier.value++;
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(
                  height: heightnotifier.value, weight: weightnotifier.value);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
