import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saar/providers/user_profile_provider.dart';
import 'package:saar/services/routes.dart';
import 'package:saar/view/screens/dispatch_details.dart';
import '../../providers/dispatch_info_provider.dart';
import '../../utils/string_utils.dart';

class DispatchSummary extends StatefulWidget {
  const DispatchSummary({Key? key}) : super(key: key);

  @override
  State<DispatchSummary> createState() => _DispatchSummaryState();
}

class _DispatchSummaryState extends State<DispatchSummary> {
  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(StringUtils.dispatch),
      bottom: const TabBar(
        tabs: [
          Tab(text: StringUtils.lastTwo),
          Tab(text: StringUtils.lastSeven),
          Tab(text: StringUtils.allDays),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var detailsProvider = Provider.of<DispatchInfoProvider>(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: appBar(),
          body: const TabBarView(
            children: [
              LastTwoDays(),
              LastSevenDays(),
              AllDays(),
            ],
          ),
        ));
  }
}

class LastTwoDays extends StatefulWidget {
  const LastTwoDays({Key? key}) : super(key: key);

  @override
  State<LastTwoDays> createState() => _LastTwoDaysState();
}

class _LastTwoDaysState extends State<LastTwoDays> {
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<DispatchInfoProvider>(context, listen: false);
      var userProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await detailsProvider.callDispatchSummary(context,
          type: '2', compMobileNo: userProvider.userProfile!.compMobile);
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
    return loading
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
                  "${StringUtils.totalDispatch}: ${detailsProvider.dispatchSummaryList.length}",
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
                itemCount: detailsProvider.dispatchSummaryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      var userProvider = Provider.of<UserDetailsProvider>(
                          context,
                          listen: false);
                      Navigator.pushNamed(context, RoutesPath.dispatchDetails,
                          arguments: DispatchDetails(
                            compGSTno: detailsProvider
                                .dispatchSummaryList[index]!.compGstNo,
                            compMobile: userProvider.userProfile!.compMobile,
                            partyName: detailsProvider
                                .dispatchSummaryList[index]!.party,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Text("Party Name: "),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(detailsProvider
                                        .dispatchSummaryList[index]!.party),
                                  ),
                                ],
                              )),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 10.0),
                          //   child: Text(detailsProvider
                          //       .dispatchSummaryList[index]!.compName),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 10.0),
                          //   child: Text(detailsProvider
                          //       .dispatchSummaryList[index]!.compGstNo),
                          // ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(StringUtils.dueAmount + ":"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    "${detailsProvider.dispatchSummaryList[index]!.netAmount}"),
                              ),
                            ],
                          ),
                          // const Divider(
                          //   thickness: 1.0,
                          // ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1.0,
                  );
                },
              )),
        ],
      ),
    );
  }
}

class LastSevenDays extends StatefulWidget {
  const LastSevenDays({Key? key}) : super(key: key);

  @override
  State<LastSevenDays> createState() => _LastSevenDaysState();
}

class _LastSevenDaysState extends State<LastSevenDays> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<DispatchInfoProvider>(context, listen: false);
      var userProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await detailsProvider.callDispatchSummary(context,
          type: '7', compMobileNo: userProvider.userProfile!.compMobile);
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
    return loading
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
                  "${StringUtils.totalDispatch}: ${detailsProvider.dispatchSummaryList.length}",
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
                itemCount: detailsProvider.dispatchSummaryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      var userProvider = Provider.of<UserDetailsProvider>(
                          context,
                          listen: false);
                      Navigator.pushNamed(context, RoutesPath.dispatchDetails,
                          arguments: DispatchDetails(
                            compGSTno: detailsProvider
                                .dispatchSummaryList[index]!.compGstNo,
                            compMobile: userProvider.userProfile!.compMobile,
                            partyName: detailsProvider
                                .dispatchSummaryList[index]!.party,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Text("Party Name: "),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(detailsProvider
                                        .dispatchSummaryList[index]!.party),
                                  ),
                                ],
                              )),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 10.0),
                          //   child: Text(detailsProvider
                          //       .dispatchSummaryList[index]!.compName),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 10.0),
                          //   child: Text(detailsProvider
                          //       .dispatchSummaryList[index]!.compGstNo),
                          // ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(StringUtils.dueAmount + ":"),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    "${detailsProvider.dispatchSummaryList[index]!.netAmount}"),
                              ),
                            ],
                          ),
                          // const Divider(
                          //   thickness: 1.0,
                          // ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1.0,
                  );
                },
              )),
        ],
      ),
    );
  }
}

class AllDays extends StatefulWidget {
  const AllDays({Key? key}) : super(key: key);

  @override
  State<AllDays> createState() => _AllDaysState();
}

class _AllDaysState extends State<AllDays> {
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var detailsProvider =
          Provider.of<DispatchInfoProvider>(context, listen: false);
      var userProvider =
          Provider.of<UserDetailsProvider>(context, listen: false);
      await detailsProvider.callDispatchSummary(context,
          type: 'All', compMobileNo: userProvider.userProfile!.compMobile);
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
    return loading
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
                        "${StringUtils.totalDispatch}: ${detailsProvider.dispatchSummaryList.length}",
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
                  itemCount: detailsProvider.dispatchSummaryList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        var userProvider = Provider.of<UserDetailsProvider>(
                            context,
                            listen: false);
                        Navigator.pushNamed(context, RoutesPath.dispatchDetails,
                            arguments: DispatchDetails(
                              compGSTno: detailsProvider
                                  .dispatchSummaryList[index]!.compGstNo,
                              compMobile: userProvider.userProfile!.compMobile,
                              partyName: detailsProvider
                                  .dispatchSummaryList[index]!.party,
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: Text("Party Name: "),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(detailsProvider
                                          .dispatchSummaryList[index]!.party),
                                    ),
                                  ],
                                )),

                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 10.0),
                            //   child: Text(detailsProvider
                            //       .dispatchSummaryList[index]!.compName),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       vertical: 10.0),
                            //   child: Text(detailsProvider
                            //       .dispatchSummaryList[index]!.compGstNo),
                            // ),
                            Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(StringUtils.dueAmount + ":"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      "${detailsProvider.dispatchSummaryList[index]!.netAmount}"),
                                ),
                              ],
                            ),
                            // const Divider(
                            //   thickness: 1.0,
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1.0,
                    );
                  },
                )),
              ],
            ),
          );
  }
}
