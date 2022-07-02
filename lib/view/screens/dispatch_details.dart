import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saar/services/routes.dart';
import 'package:saar/view/screens/dispatch_body.dart';
import '../../providers/dispatch_info_provider.dart';
import '../../utils/string_utils.dart';
import 'package:flutter/services.dart';

class DispatchDetails extends StatefulWidget {
  final String compMobile;
  final String partyName;
  final String compGSTno;

  const DispatchDetails({
    Key? key,
    required this.compGSTno,
    required this.compMobile,
    required this.partyName,
  }) : super(key: key);

  @override
  State<DispatchDetails> createState() => _DispatchDetailsState();
}

class _DispatchDetailsState extends State<DispatchDetails> {
  bool loading = true;

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(StringUtils.dispatchDetails),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<DispatchInfoProvider>(context, listen: false);
      await detailsProvider.callDispatchInfoDetails(context,
          compMobile: widget.compMobile,
          partyName: widget.partyName,
          comGSTno: widget.compGSTno,
      );
      Future.delayed(const Duration(seconds: 1),(){
        if(mounted){
          setState((){
            loading = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var detailsProvider =
        Provider.of<DispatchInfoProvider>(context, listen: false);
    return Scaffold(
      appBar: appBar(),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${StringUtils.totalDispatch}: ${detailsProvider.dispatchInfoDetailsList.length}",
                          style: const TextStyle(fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: const [
                  //     Text(StringUtils.party),
                  //     Text(StringUtils.dueAmount),
                  //   ],
                  // ),
                  const Divider(
                    thickness: 1.0,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount:
                              detailsProvider.dispatchInfoDetailsList.length,
                          itemBuilder: (context, index) {
                            String val = detailsProvider
                                .dispatchInfoDetailsList[index]!.billDate
                                .substring(6, 19);
                            Timestamp t = Timestamp.fromMillisecondsSinceEpoch(
                                int.parse(val));
                            DateTime date =
                                DateTime.parse(t.toDate().toString());
                            var recentMsgDate =
                                DateFormat('dd/MMM/yyyy').format(date);
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesPath.dispatchBody,
                                    arguments: DispatchBody(
                                      billNo: detailsProvider
                                          .dispatchInfoDetailsList[index]!
                                          .billNo,
                                      compGSTNo: detailsProvider
                                          .dispatchInfoDetailsList[index]!
                                          .compGsTno,
                                      fvNo: detailsProvider
                                          .dispatchInfoDetailsList[index]!.fvno,
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Text("Party: "),
                                        ),
                                        Expanded(flex: 1, child: Text(detailsProvider
                                            .dispatchInfoDetailsList[index]!
                                            .party)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text("Bill No: "),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(detailsProvider
                                                .dispatchInfoDetailsList[index]!
                                                .billNo)),
                                      ],
                                    ),
                                    // Text("Bill No: " + detailsProvider
                                    //     .dispatchInfoDetailsList[index]!
                                    //     .billNo),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Text("Bill Date: "),
                                        ),
                                        Expanded(flex: 1, child: Text(recentMsgDate))
                                      ],
                                    ),
                                    // Text("Bill Date: " + recentMsgDate),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text("Ac of Name: "),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(detailsProvider
                                            .dispatchInfoDetailsList[index]!
                                            .acofName))
                                      ],
                                    ),

                                    // Text("Ac of Name: " + detailsProvider
                                    //     .dispatchInfoDetailsList[index]!
                                    //     .acofName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(child: Text("Transport: ")),
                                        Expanded(
                                          flex: 1,
                                          child: Text(detailsProvider
                                              .dispatchInfoDetailsList[index]!
                                              .transport),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Text("Dispatch: "),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(detailsProvider
                                              .dispatchInfoDetailsList[index]!
                                              .despatch),
                                        ),
                                      ],
                                    ),
                                    // Text("Dispatch: " + detailsProvider
                                    //     .dispatchInfoDetailsList[index]!
                                    //     .despatch),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child:
                                            Text(StringUtils.netAmount + ":"),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${detailsProvider.dispatchInfoDetailsList[index]!.netAmount}"),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                  ),
                                ],
                              ),
                            );
                          })),
                ],
              ),
            ),
    );
  }
}
