import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verification/verification/rent.dart';
import 'package:verification/verification/rentRenewal.dart';
import 'package:verification/verification/verification.dart';

import '../common_widgets/shortButton.dart';
import '../const/styles.dart';
import '../models/avis_model.dart';
import '../repository/remote_data/queries.dart';
import 'bnpl.dart';
import 'merchant.dart';

class AvisList extends StatefulWidget {
  const AvisList({Key? key}) : super(key: key);

  @override
  State<AvisList> createState() => _AvisListState();
}

class _AvisListState extends State<AvisList> {
  final VerificationRepo _repository = VerificationRepo();
  Future<AvisListModel>? _avsRequest;
  List<dynamic>? dRdata;

  @override
  void initState() {
    _repository.getAvisList();
    dRdata = _repository.myData;
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async{
    //   await _repository.getAvisList();
    //   dRdata = await _repository.myData;
    //
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('messagggggggggg');
    return Scaffold(
      appBar: AppBar(
        title: Text('Request', style: kFirstTTN,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: kBlack),
        ),
        backgroundColor: kLoanCard,
        elevation: 0.5
      ),
      backgroundColor: kLoanCard,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height -100.h,
                  child: FutureBuilder<AvisListModel>(
                    future: _repository.getAvisList(),
                      builder: (context, snapshot){
                      var dList = snapshot.data?.data;
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount: snapshot.data?.data?.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index){
                              var listed = snapshot.data?.data![index];
                              String? avisId = listed?.avsId;
                              String? createdAt = listed?.createdAt;
                              String? request = listed?.request;
                              String? verified = listed?.verified;
                              String? vertical = listed?.vertical;
                              String? tenantAddress = listed?.tenantAddress;
                              String? clientAddress = listed?.clientAddress;
                              final resss = jsonDecode(request!);
                              final bg = Map<String, dynamic>.from(resss);
                              debugPrint('avisId==========> $avisId');
                              debugPrint('createdAt==========> $createdAt');
                              debugPrint('request==========> $request');
                              debugPrint('vertical==========> $vertical');
                              debugPrint('verified==========> $verified');
                              debugPrint('ShopName==========> ${bg['shop_name']}');
                              return Stack(
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
                                        padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 20.r),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Name: ', style: kFirstTN,),
                                                Text('${bg['full_name']}', style: kFirstN,),
                                              ],
                                            ),
                                            SizedBox(height: 6.h,),
                                            Row(
                                              children: [
                                                Text('Phone no: ', style: kFirstTN,),
                                                Text('${listed?.agentPhone}', style: kFirstN,),
                                              ],
                                            ),
                                            SizedBox(height: 6.h,),
                                            Row(
                                              children: [
                                                Text('Date: ', style: kFirstTN,),
                                                Text('$createdAt', style: kFirstN,),
                                              ],
                                            ),
                                            SizedBox(height: 10.h,),
                                            listed?.verified == '0'? GestureDetector(
                                              onTap: (){
                                                if(verified == '0' && vertical=='merchant'){
                                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> MerchantScreen(avsId: '$avisId',)));
                                                }else if(verified == '0' && vertical=='rent-renewal'){
                                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> RentRenewalScreen(avsId: '$avisId',)));
                                                }else if(verified == '0' && vertical=='rent-acquisition'){
                                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> RentScreen(avsId: '$avisId',)));
                                                }else if(verified == '0' && vertical=='bnpl'){
                                                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> BnplScreen(avsId: '$avisId',)));
                                                }
                                              },
                                                child: Center(child: ShortLoginB(text: 'Verify now', style: kLoginButton,))) :
                                            const Text(''),
                                            listed?.verified == '0'? SizedBox(height: 15.h,) : SizedBox(height: 0.h,),
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
                                        color: listed?.verified == '0'? kLogout : kSafeGreen,
                                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: listed?.verified == '0'? Center(child: Text(' not verified ', style: kFirstN,)) : Center(child: Text(' verified ', style: kFirstN,)),
                                      ),
                                    ),
                                  )
                                ],
                              );
                              }
                          );
                        } else if(snapshot.hasError){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50.h,
                            color: kDarkBlue,
                            child: Center(child: Text('Checking for available request.....', style: kFirstN,)),
                          );
                        }else if(dRdata==null){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50.h,
                            color: kDarkBlue,
                            child: Center(child: Text('No available request.....', style: kFirstN,)),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }
                  ),
                ),
                // Stack(
                //   children: [
                //     SizedBox(
                //       width: MediaQuery.of(context).size.height,
                //       child: Card(
                //         elevation: 0.0,
                //         color: kWhite,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12.r)
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Text('Agent Name: ', style: kFirstTN,),
                //                   Text('kola wole', style: kFirstN,),
                //                 ],
                //               ),
                //               SizedBox(height: 10.h,),
                //               Row(
                //                 children: [
                //                   Text('Phone no: ', style: kFirstTN,),
                //                   Text('08097778655', style: kFirstN,),
                //                 ],
                //               ),
                //               SizedBox(height: 10.h,),
                //               Center(child: ShortLoginB(text: 'Verify now', style: kLoginButton,)),
                //               SizedBox(height: 15.h,),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       top: 6,
                //         right: 8,
                //         child: Container(
                //           height: 20.h,
                //           decoration: BoxDecoration(
                //             color: kLogout,
                //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.all(4.0),
                //             child: Center(child: Text(' not verified ', style: kFirstN,)),
                //           ),
                //         ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
