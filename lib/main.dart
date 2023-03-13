import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verification/repository/remote_data/queries.dart';
import 'package:verification/verification/verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  const Size(360, 690),
        builder: (BuildContext context, child){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => VerificationRepo()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const VerificationScreen(),
          ),
        );
      }
    );
  }
}

