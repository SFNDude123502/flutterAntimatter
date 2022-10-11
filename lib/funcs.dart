import 'classes.dart';
import 'package:flutter/material.dart';

String i2n(num input) {
  late String output = "";
  int cnt = 0;
  double dnput = input.toDouble();
  while (dnput >= 1000) {
    dnput = (dnput / 1000);
    cnt++;
  }

  output += dnput.toStringAsFixed(2);
  switch (cnt) {
    case 0:
      output += "";
      break;
    case 1:
      output += " K";
      break;
    case 2:
      output += " M";
      break;
    case 3:
      output += " B";
      break;
    case 4:
      output += " T";
      break;
    case 5:
      output += " q";
      break;
    case 6:
      output += " Q";
      break;
    default:
      int c = 1;
      while (input > 10) {
        input /= 10;
        c++;
      }
      if (dnput < 1) {
        dnput = 1;
      }
      output = "${(dnput % 10).toStringAsFixed(2)} * e^ $c";
      break;
  }
  return output;
}

void dimAdjustment(int dimBoosts, List<Dimension> dimList) {
  if (dimBoosts <= 8) {
    for (int i = 0; i < dimBoosts; i++) {
      dimList[i].defaultMult *= 2;
    }
  } else {
    for (int i = 0; i < dimList.length; i++) {
      dimList[i].defaultMult *= 2;
    }
  }

  for (int i = 0; i < dimList.length; i++) {
    dimList[i].amount = 0;
    dimList[i].mult = dimList[i].defaultMult;
    dimList[i].pur = 0;
    dimList[i].cost = dimList[i].defaultCost;
  }
}

BoxDecoration dimBox(UIMode uimode) {
  return BoxDecoration(
    color: uimode.buttonColors['buttonBackgroundColor'],
    border:
        Border.all(color: uimode.buttonColors["buttonBorderColor"], width: 2),
  );
}

Container dimContent(Dimension dim, String numText, UIMode uimode) {
  return Container(
    decoration: dimBox(uimode),
    child: Text(
      dim.buttonText(numText),
      style: TextStyle(
        color: uimode.buttonColors["buttonTextColor"],
      ),
    ),
  );
}

Container checkDimBoosts(int dimBoosts, int goal, Container inputWidget) {
  if (dimBoosts >= goal) {
    return inputWidget;
  } else {
    return Container();
  }
}

Text dimBoostText(dimBoosts, UIMode uimode) {
  int dimAmt;
  String dimType;
  if (dimBoosts <= 4) {
    dimAmt = 20;
  } else {
    dimAmt = (20 + ((dimBoosts - 4) * 15)).toInt();
  }
  switch (dimBoosts) {
    case 0:
      dimType = "4th";
      break;
    case 1:
      dimType = "5th";
      break;
    case 2:
      dimType = "6th";
      break;
    case 3:
      dimType = "7th";
      break;
    default:
      dimType = "8th";
      break;
  }
  return Text(
    "Dimension Boosts: $dimBoosts \n Requires: $dimAmt $dimType Dimensions",
    style: TextStyle(color: uimode.buttonColors["buttonTextColor"]),
  );
}

Container optionButtonText(String text, UIMode uimode) {
  return Container(
    decoration: BoxDecoration(
        color: uimode.buttonColors["buttonBackgroundColor"],
        border: Border.all(
            color: uimode.buttonColors["buttonGlowBorderColor"], width: 3)),
    child: Text(
      text,
      style: TextStyle(
        color: uimode.buttonColors["buttonTextColor"],
      ),
    ),
  );
}

bool dimBoostReq(int dimboosts, List<Dimension> dimlist) {
  if (dimboosts < 4) {
    if (dimlist[dimboosts + 3].amount >= 20) {
      return true;
    } else {
      return false;
    }
  } else {
    if (dimlist[7].amount >= (20 + ((dimboosts - 4) * 15)).toInt()) {
      return true;
    } else {
      return false;
    }
  }
}

double timerCalcs(List<Dimension> dimlist, double tickfactor) {
  dimlist[6].amount += (dimlist[7].mult * dimlist[7].amount * tickfactor);
  dimlist[5].amount += (dimlist[6].mult * dimlist[6].amount * tickfactor);
  dimlist[4].amount += (dimlist[5].mult * dimlist[5].amount * tickfactor);
  dimlist[3].amount += (dimlist[4].mult * dimlist[4].amount * tickfactor);
  dimlist[2].amount += (dimlist[3].mult * dimlist[3].amount * tickfactor);
  dimlist[1].amount += (dimlist[2].mult * dimlist[2].amount * tickfactor);
  dimlist[0].amount += (dimlist[1].mult * dimlist[1].amount * tickfactor);
  return (dimlist[0].mult * dimlist[0].amount * tickfactor);
}
