import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/package_info_provider.dart';
import 'package:saar/utils/string_utils.dart';

class PackingInfo extends StatefulWidget {
  final String billNo;
  final String caseNo;
  final String compGSTno;
  final String bookCode;

  const PackingInfo(
      {Key? key,
      required this.billNo,
      required this.caseNo,
      required this.compGSTno,
      required this.bookCode})
      : super(key: key);

  @override
  State<PackingInfo> createState() => _PackingInfoState();
}

class _PackingInfoState extends State<PackingInfo> {
  bool loading = true;
  PreferredSizeWidget appBar() {
    return AppBar(
      title:
          Text(StringUtils.packInfo + " (${widget.billNo} : ${widget.caseNo})"),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var packInfoProvider =
          Provider.of<PackageInfoProvider>(context, listen: false);
      await packInfoProvider.callPackageInfoDetails(
          bookCode: widget.bookCode,
          compGSTno: widget.compGSTno,
          caseNo: widget.caseNo);
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
    var packInfoProvider = Provider.of<PackageInfoProvider>(context);
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
                          "${StringUtils.totalPackage}: ${packInfoProvider.packageInfoDetailsList.length}",
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
                  // const Divider(
                  //   thickness: 1.0,
                  // ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: packInfoProvider.packageInfoDetailsList.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 1.0,
                        );
                      },
                      itemBuilder: (context, index) {
                        String val = packInfoProvider
                            .packageInfoDetailsList[index]!.orderDate
                            .substring(6, 19);
                        Timestamp t = Timestamp.fromMillisecondsSinceEpoch(
                            int.parse(val));
                        DateTime date = DateTime.parse(t.toDate().toString());
                        var recentMsgDate =
                            DateFormat('dd/MMM/yyyy').format(date);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
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
                                        child: Text(packInfoProvider
                                            .packageInfoDetailsList[index]!
                                            .party)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Case No: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(packInfoProvider
                                            .packageInfoDetailsList[index]!
                                            .caseno)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Order Date: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(recentMsgDate,
                                        ),
                                    ),
                                  ],
                                ),
                                // Text(recentMsgDate),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Bill No: ")),
                                    Expanded(
                                        flex: 1, child: Text(widget.billNo)),
                                  ],
                                ),
                                // Text(widget.billNo),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Dispatch: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(packInfoProvider
                                            .packageInfoDetailsList[index]!
                                            .despatch)),
                                  ],
                                ),
                                // Text(packInfoProvider.packageInfoDetailsList[index]!.despatch),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Item Name: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(packInfoProvider
                                            .packageInfoDetailsList[index]!
                                            .itemName)),
                                  ],
                                ),
                                // Text(packInfoProvider.packageInfoDetailsList[index]!.itemName),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("No of Pieces: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${packInfoProvider.packageInfoDetailsList[index]!.noPcs}")),
                                  ],
                                ),
                                // Text("${packInfoProvider.packageInfoDetailsList[index]!.noPcs}"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Quantity: ")),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${packInfoProvider.packageInfoDetailsList[index]!.qty}")),
                                  ],
                                ),
                                // Text("${packInfoProvider.packageInfoDetailsList[index]!.qty}"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
