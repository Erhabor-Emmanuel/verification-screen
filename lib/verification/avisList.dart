import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late Future<AvisListModel> _avsRequest;

  @override
  void initState() {
    // TODO: implement initState
    _avsRequest = _repository.getAvisList();
    super.initState();
  }

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
                SizedBox(
                  child: FutureBuilder<AvisListModel>(
                    future: _avsRequest,
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return ListView.builder(
                            itemCount: snapshot.data?.data?.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index){
                              var listed = snapshot.data?.data![index];
                              return GestureDetector(
                                onTap: (){
                                  // String? agentName = listed?.agentName;
                                  // String? agentPhone = listed?.agentPhone;
                                  String? avisId = listed?.avsId;
                                  String? verified = listed?.verified;
                                },
                                child: Stack(
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
                                              listed?.verified == '0'? Center(child: ShortLoginB(text: 'Verify now', style: kLoginButton,)) : const Text(''),
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
                                ),
                              );
                              }
                          );
                        } else if(snapshot.hasError){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50.h,
                            color: kDarkBlue,
                            child: Center(child: Text('Loading.....', style: kFirstN,)),
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
