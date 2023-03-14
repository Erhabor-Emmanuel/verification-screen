import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/styles.dart';

class AvisList extends StatefulWidget {
  const AvisList({Key? key}) : super(key: key);

  @override
  State<AvisList> createState() => _AvisListState();
}

class _AvisListState extends State<AvisList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: kBlack),
        ),
        backgroundColor: kLoanCard,
        elevation: 0.0,
      ),
      backgroundColor: kLoanCard,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.height,
                      child: Card(
                        elevation: 0.0,
                        color: kWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Agent Name: ', style: kFirstTN,),
                                  Text('kola wole', style: kFirstN,),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Phone no: ', style: kFirstTN,),
                                  Text('08097778655', style: kFirstN,),
                                ],
                              ),
                              SizedBox(height: 15.h,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                        right: 8,
                        child: Container(
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: kLogout,
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(child: Text(' not verified ', style: kFirstN,)),
                          ),
                        ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
