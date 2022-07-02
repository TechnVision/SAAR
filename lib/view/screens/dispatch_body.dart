import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/dispatch_info_provider.dart';
import 'package:saar/services/routes.dart';
import '../../utils/string_utils.dart';
import 'pack_info.dart';

class DispatchBody extends StatefulWidget {
  final String billNo;
  final String fvNo;
  final String compGSTNo;

  const DispatchBody(
      {Key? key,
      required this.billNo,
      required this.compGSTNo,
      required this.fvNo})
      : super(key: key);

  @override
  State<DispatchBody> createState() => _DispatchBodyState();
}

class _DispatchBodyState extends State<DispatchBody> {
  bool loading = true;

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(StringUtils.dispatchBody + " (${widget.billNo})"),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<DispatchInfoProvider>(context, listen: false);
      await detailsProvider.callDispatchInfoBody(context,
          fvNo: widget.fvNo,
          billNo: widget.billNo,
          compGSTno: widget.compGSTNo);
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
    var detailsProvider = Provider.of<DispatchInfoProvider>(context);
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
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${StringUtils.totalDispatch}: ${detailsProvider.dispatchInfoBodyList.length}",
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
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  thickness: 1.0,
                                );
                              },
                              itemCount:
                                  detailsProvider.dispatchInfoBodyList.length,
                              itemBuilder: (context, index) {
                                String val = detailsProvider
                                    .dispatchInfoBodyList[index]!.s1.billDate
                                    .substring(6, 19);
                                Timestamp t =
                                    Timestamp.fromMillisecondsSinceEpoch(
                                        int.parse(val));
                                DateTime date =
                                    DateTime.parse(t.toDate().toString());
                                var recentMsgDate =
                                    DateFormat('dd/MMM/yyyy').format(date);
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesPath.packInfo,
                                      arguments: PackingInfo(
                                        caseNo: detailsProvider
                                            .dispatchInfoBodyList[index]!
                                            .s1
                                            .caseno,
                                        compGSTno: detailsProvider
                                            .dispatchInfoBodyList[index]!
                                            .s1
                                            .compGsTno,
                                        billNo: detailsProvider
                                            .dispatchInfoBodyList[index]!
                                            .s1
                                            .billNo,
                                        bookCode:
                                            "${detailsProvider.dispatchInfoBodyList[index]!.s1.bookCode}",
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Row(
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text("Party Name: "),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(detailsProvider
                                                      .dispatchInfoBodyList[
                                                          index]!
                                                      .partyName),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("Case No: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(detailsProvider
                                                      .dispatchInfoBodyList[
                                                          index]!
                                                      .s1
                                                      .caseno))
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
                                                child: Text("Bill No: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(detailsProvider
                                                      .dispatchInfoBodyList[
                                                          index]!
                                                      .s1
                                                      .billNo))
                                            ],
                                          ),
                                          // Text("Bill No: " +
                                          //     detailsProvider
                                          //         .dispatchInfoBodyList[index]!
                                          //         .s1
                                          //         .billNo),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("Date: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(recentMsgDate))
                                            ],
                                          ),
                                          // Text("Date: " + recentMsgDate),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("Ac of Name: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(detailsProvider
                                                              .dispatchInfoBodyList[
                                                                  index]!
                                                              .s1
                                                              .acofName ==
                                                          null
                                                      ? ""
                                                      : "${detailsProvider.dispatchInfoBodyList[index]!.s1.acofName}"))
                                            ],
                                          ),

                                          // Text(detailsProvider
                                          //             .dispatchInfoBodyList[
                                          //                 index]!
                                          //             .s1
                                          //             .acofName ==
                                          //         null
                                          //     ? "Ac of Name: "
                                          //     : "Ac of Name: ${detailsProvider.dispatchInfoBodyList[index]!.s1.acofName}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("Item Name: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(detailsProvider
                                                      .dispatchInfoBodyList[
                                                          index]!
                                                      .s1
                                                      .item))
                                            ],
                                          ),
                                          // Text("Item Name: " +
                                          //     detailsProvider
                                          //         .dispatchInfoBodyList[index]!
                                          //         .s1
                                          //         .item),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("No of Pieces: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      "${detailsProvider.dispatchInfoBodyList[index]!.s1.noPcs}"))
                                            ],
                                          ),
                                          // Text(
                                          //     "No of Pieces: ${detailsProvider.dispatchInfoBodyList[index]!.s1.noPcs}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("Quantity: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      "${detailsProvider.dispatchInfoBodyList[index]!.s1.qty}"))
                                            ],
                                          ),
                                          // Text(
                                          //     "Quantity: ${detailsProvider.dispatchInfoBodyList[index]!.s1.qty}"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Text("Rate: "),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      "${detailsProvider.dispatchInfoBodyList[index]!.s1.rate}"))
                                            ],
                                          ),
                                          // Text(
                                          //     "Rate: ${detailsProvider.dispatchInfoBodyList[index]!.s1.rate}"),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                  StringUtils.amount + ":"),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                  "${detailsProvider.dispatchInfoBodyList[index]!.s1.amount}"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
    );
  }
}
