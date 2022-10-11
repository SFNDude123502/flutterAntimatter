import 'funcs.dart';
import 'package:flutter/material.dart';

class Dimension {
  late num amount;
  late num defaultMult = 1;
  late num mult;
  late double defaultCost;
  late num cost;
  late num pur;
  late num costIncrement;
  Dimension(double costInput, int costIncrementInput) {
    amount = 0;
    mult = 1;
    defaultCost = costInput;
    cost = defaultCost;
    costIncrement = costIncrementInput;
    pur = 0;
  }
  String buttonText(String numText) {
    return "$numText Dimensions: ${i2n(amount)} \nCost: ${i2n(cost)} Multiplier: ${i2n(mult)} \n Purchases til Price Increase: ${10 - pur % 10}";
  }

  num onPressedCalculations(num antimatter) {
    if (antimatter >= cost) {
      amount++;
      pur++;
      num cos = cost;
      if (pur % 10 == 0) {
        cost *= costIncrement;
        mult *= 2;
      }
      return cos;
    }
    return 0;
  }
}

class UIMode {
  late String name;
  late Map navColors;
  late Map buttonColors;
  late Map appBarColors;
  late Map bodyColors;
  UIMode(
    String inputName,
    Map navColours,
    Map buttonColours,
    Map appBarColours,
    Map bodyColours,
  ) {
    name = inputName;
    // navColours = {"navBackgroundColor": Color, "navIconColor": Color}
    navColours = navColours;
    // buttonColours = {"buttonBackgroundColor": Color, "buttonTextColor": Color, "buttonBorderColor": Color, "buttonGlowBackgroundColor": Color, "buttonGlowBorderColor": Color, "buttonGlowBorderColor": Color}
    buttonColors = buttonColours;
    // appBarColours = {"appBarBackgroundColor": Color, "appBarTextColor": Color}
    appBarColors = appBarColours;
    // bodyColours = {"bodyBackgroundColor": Color, "bodyTextColor": Color}
    bodyColors = bodyColours;
  }
}
