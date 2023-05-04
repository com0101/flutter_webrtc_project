import 'dart:ui';

class DoubleShade {
  final Color lightShade;
  final Color darkShade;

  DoubleShade(this.lightShade, this.darkShade);
}

const Color backgroundColor = Color(0xFFFFFFFF);
const Color greenColor = Color(0xFF5CE27F);
const Color yellowColor = Color(0xFFFFE120);
const Color redColor = Color(0xFFE25C5C);
const Color lightGrey = Color(0xFFB1B1B1);
const Color darkGrey = Color(0xFF121212);
const Color superLightGrey = Color(0xFFEFEFEF);
DoubleShade greenGradient = DoubleShade(const Color(0xFF5CE27F), const Color(0xFF5CABE2));
DoubleShade blackColor = DoubleShade(const Color(0xFF313131), const Color(0xFF121212));
DoubleShade grayColor = DoubleShade(const Color(0xFF818181), const Color(0xFFEFEFEF));
