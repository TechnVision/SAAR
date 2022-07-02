import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/outstanding_details_provider.dart';
import '../../utils/string_utils.dart';

class OutstandingDetails extends StatefulWidget {
  final String mobileNo;
  final String partyName;
  final String compGSTno;

  const OutstandingDetails(
      {Key? key,
      required this.mobileNo,
      required this.partyName,
      required this.compGSTno})
      : super(key: key);

  @override
  State<OutstandingDetails> createState() => _OutstandingDetailsState();
}

class _OutstandingDetailsState extends State<OutstandingDetails> {
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<OutstandingDetailsProvider>(context, listen: false);
      await detailsProvider.callOutstandingDetails(
        context,
        mobileNo: widget.mobileNo,
        partyName: widget.partyName,
        compGSTno: widget.compGSTno,
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

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(StringUtils.outstandingDetails),
    );
  }

  @override
  Widget build(BuildContext context) {
    var detailsProvider = Provider.of<OutstandingDetailsProvider>(context);
    return Scaffold(
      appBar: appBar(),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    "${StringUtils.totalOutstanding}: ${detailsProvider.outstandingDetailsList.length}",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount:
                            detailsProvider.outstandingDetailsList.length,
                        itemBuilder: (context, index) {
                          String val = detailsProvider
                              .outstandingDetailsList[index]!.billDate
                              .substring(6, 19);
                          Timestamp t = Timestamp.fromMillisecondsSinceEpoch(
                              int.parse(val));
                          DateTime date = DateTime.parse(t.toDate().toString());
                          var recentMsgDate =
                              DateFormat('dd/MMM/yyyy').format(date);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(child: Text("Party Name: ")),
                                    Expanded(
                                      child: Text(detailsProvider
                                          .outstandingDetailsList[index]!
                                          .party),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(child: Text("Bill No: ")),
                                    Expanded(
                                        child: Text(detailsProvider
                                            .outstandingDetailsList[index]!
                                            .billNo)),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Bill Date: ")),
                                      Expanded(
                                        flex: 1,
                                        child: Text(recentMsgDate),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Bill Amount: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${detailsProvider.outstandingDetailsList[index]!.billAmt}"))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        child:
                                            Text(StringUtils.dueAmount + ":")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${detailsProvider.outstandingDetailsList[index]!.dueAmt}")),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 1.0,
                              ),
                            ],
                          );
                        })),
              ],
            ),
    );
  }
}
