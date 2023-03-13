import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:verification/const/styles.dart';

void showingSnacks(BuildContext context, String text){
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Success',
      message: text,
      contentType: ContentType.success,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showingErrorSnacks(BuildContext context, String text){
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Error',
      message: text,
      contentType: ContentType.failure,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}