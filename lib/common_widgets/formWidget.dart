import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/styles.dart';

class FormWidget extends StatelessWidget {
  final String text;
  final String hText;
  final TextEditingController? controller;
  const FormWidget({
    required this.text,
    required this.hText,
    this.controller,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.0.r, bottom: 7.0.r),
          child: Text(text, style: kFirstN,),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 46.h,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          child: TextFormField(
            controller: controller,
            decoration:  InputDecoration(
              fillColor: kWhite,
              hintStyle: kDetailAccount,
              hintText: hText,
              // contentPadding: EdgeInsets.symmetric(vertical: 48.0.h, horizontal: 167.0.w),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kBlack),
                borderRadius: BorderRadius.circular(12.0.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
