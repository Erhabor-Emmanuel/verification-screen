import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/styles.dart';

class ShortLoginB extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ShortLoginB({
    required this.text,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 35.h,
      decoration: BoxDecoration(
          color: kLoginB,
          borderRadius: BorderRadius.circular(12.0.r)
      ),
      child: Center(
        child: Text(text, style: style),
      ),
    );
  }
}

