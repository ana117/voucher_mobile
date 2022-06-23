import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Common {
  static Color darkBlue =  const Color.fromRGBO(39, 38, 67, 1);
  static Color white =  const Color.fromRGBO(255, 255, 255, 1);
  static Color gray =  const Color.fromRGBO(150, 150, 150, 1);
  static Color lightBlue1 = const Color.fromRGBO(227, 246, 245, 1);
  static Color lightBlue2 = const Color.fromRGBO(186, 232, 232, 1);
  static Color lightBlue3 = const Color.fromRGBO(44, 105, 141, 1);

  static String localhost = "http://10.0.2.2";

  static Text createWhiteText(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(color: white, fontSize: 20),
      ),
      textAlign: TextAlign.center,
    );
  }

  static Text createDarkBlueText(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(color: darkBlue, fontSize: 20)
      ),
      textAlign: TextAlign.center,
    );
  }
}