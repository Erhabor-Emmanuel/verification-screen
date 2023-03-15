import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:verification/verification/verification.dart';

import '../common_widgets/shortButton.dart';
import '../const/styles.dart';
import '../models/avis_model.dart';
import '../repository/remote_data/queries.dart';

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
                  height: 300.h,
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
                              debugPrint('avisId==========> $avisId');
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
                                        padding: EdgeInsets.only(left: 10.r, right: 10.r, top: 10.r),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Agent Name: ', style: kFirstTN,),
                                                Text('${listed?.agentName}', style: kFirstN,),
                                              ],
                                            ),
                                            SizedBox(height: 10.h,),
                                            Row(
                                              children: [
                                                Text('Phone no: ', style: kFirstTN,),
                                                Text('${listed?.agentPhone}', style: kFirstN,),
                                              ],
                                            ),
                                            SizedBox(height: 10.h,),
                                            listed?.verified == '0'? GestureDetector(
                                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (builder)=> VerificationScreen(avsId: '$avisId',))),
                                                child: Center(child: ShortLoginB(text: 'Verify now', style: kLoginButton,))) :
                                            GestureDetector(
                                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (builder)=> VerificationScreen(avsId: '$avisId',))),
                                                child: Center(child: ShortLoginB(text: 'Verify now', style: kLoginButton,))),
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
                        }else if(dList==null){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50.h,
                            color: kDarkBlue,
                            child: Center(child: Text('Checking for available request.....', style: kFirstN,)),
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
