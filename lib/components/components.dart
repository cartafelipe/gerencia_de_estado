import 'package:flutter/material.dart';

BoxDecoration lienarGradientBackgroud(List<Color> colors,
    {AlignmentGeometry begin, AlignmentGeometry end}) {
  return BoxDecoration(
    gradient: LinearGradient(
        begin: begin ?? Alignment.topCenter,
        end: end ?? Alignment.bottomCenter,
        colors: colors),
  );
}
