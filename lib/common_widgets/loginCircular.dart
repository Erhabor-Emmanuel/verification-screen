import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../const/styles.dart';

class LoginCircular extends StatelessWidget {
  final String text;
  final TextStyle style;
  const LoginCircular({
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
            color: kLoginB,
            borderRadius: BorderRadius.circular(12.0.r)
        ),
        child: const Center(child: CircularProgressIndicator(color: kWhite,)));
  }
}

