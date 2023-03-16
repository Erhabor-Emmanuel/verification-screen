import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/styles.dart';

class InActiveLoginB extends StatelessWidget {
  final String text;
  final TextStyle style;
  const InActiveLoginB({
    required this.text,
    required this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: kDetail,
          borderRadius: BorderRadius.circular(12.0.r)
      ),
      child: Center(
        child: Text(text, style: style),
      ),
    );
  }
}

