import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/outstanding_details_provider.dart';
import 'package:saar/providers/user_profile_provider.dart';
import 'package:saar/services/routes.dart';
import 'package:saar/utils/string_utils.dart';
import 'package:saar/view/screens/outstanding_details.dart';

class OutStanding extends StatefulWidget {
  const OutStanding({Key? key}) : super(key: key);

  @override
  State<OutStanding> createState() => _OutStandingState();
}

class _OutStandingState extends State<OutStanding> {
  bool loading = true;

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(StringUtils.outstanding),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<OutstandingDetailsProvider>(context, listen: false);
      var userProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await detailsProvider.callOutstandingSummary(context,
          compMobileNo: userProvider.userProfile!.compMobile);
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
                    "${StringUtils.totalOutstanding}: ${detailsProvider.outstandingSummaryList.length}",
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                ),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        itemCount:
                            detailsProvider.outstandingSummaryList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              var userProvider =
                                  Provider.of<UserDetailsProvider>(context,
                                      listen: false);
                              Navigator.pushNamed(
                                  context, RoutesPath.outstandingDetails,
                                  arguments: OutstandingDetails(
                                      mobileNo:
                                          userProvider.userProfile!.compMobile,
                                      partyName: detailsProvider
                                          .outstandingSummaryList[index]!.party,
                                      compGSTno: detailsProvider
                                          .outstandingSummaryList[index]!
                                          .compGstNo));
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
                                          child: Text("Party Name: "),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(detailsProvider
                                              .outstandingSummaryList[index]!
                                              .party),
                                        )
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text("Company Name: "),
                                      ),
                                      Expanded(
                                        child: Text(detailsProvider
                                            .outstandingSummaryList[index]!
                                            .compName),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(child: Text("GST No")),
                                        Expanded(
                                          child: Text(detailsProvider
                                              .outstandingSummaryList[index]!
                                              .compGstNo),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(StringUtils.dueAmount),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                            "${detailsProvider.outstandingSummaryList[index]!.dueAmt}"),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 1.0,
                                ),
                              ],
                            ),
                          );
                        }))
              ],
            ),
    );
  }
}
