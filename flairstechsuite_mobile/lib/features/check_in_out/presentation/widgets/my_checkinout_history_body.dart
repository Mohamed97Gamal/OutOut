import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/date_utils.dart' as date_utils;
import '../../../../utils/navigation.dart';
import '../../../../widgets/basic/future_builder.dart';
import '../../../../widgets/basic/refreshable.dart';
import '../../data/model/check_in_out_dto.dart';
import '../manager/my_checkinout_history_provider.dart';
import 'my_checkinout_history/no_data_widget.dart';
import 'my_checkinout_history/time_widget.dart';

class MyCheckInOutHistoryBody extends StatelessWidget {
  final Future<CheckInOutHistoryDTOResponse> Function() getCheckInOutHistory;
  const MyCheckInOutHistoryBody({Key? key, required this.getCheckInOutHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkInOutProvider =
        Provider.of<MyCheckInOutHistoryProvider>(context);

    return Refreshable(
      key: checkInOutProvider.refreshableKey,
      child: RefreshIndicator(
        onRefresh: () async => checkInOutProvider.refresh(),
        child: CustomFutureBuilder<CheckInOutHistoryDTOResponse>(
          initFuture: () => getCheckInOutHistory(),
          onSuccess: (context, snapshot) {
            if (snapshot.data!.result!.isEmpty) {
              return Center(
                child: Text("No Results"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.result!.length,
              //separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = snapshot.data!.result![index];
                if (item.checkInOutDurations!.isEmpty) {
                  return NoDataWidget(
                    date: item.date,
                  );
                }
                DateTime? firstCheckInDateTime;
                DateTime? lastCheckInDateTime;
                DateTime? from;
                DateTime? to;
                if (item.checkInOutDurations!.isNotEmpty) {
                
                  firstCheckInDateTime =
                     item.checkInOutDurations!.first.checkInDTO?.creationDate;
                  lastCheckInDateTime =
                     item.checkInOutDurations!.last.checkOutDTO?.creationDate;
                  from = item.startShiftDate;
                  if (item.endShiftDate != null) to = item.endShiftDate;
               
                }
                return InkWell(
                  onTap: () =>
                      Navigation.navToMyCheckInOutHistoryDetails(context, item),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                  to != null && from!.day != to.day
                                        ? "${date_utils.DateUtils.dateFormat.format(from)} \n\n${date_utils.DateUtils.dateFormat.format(to)}"
                                        : "${date_utils.DateUtils.dateFormat.format(from!)}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MyColors.lightGrayColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          VerticalDivider(
                              color: Colors.black, indent: 4, endIndent: 4),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: <Widget>[
                                TimeWidget(
                                  checkInDateTime: firstCheckInDateTime,
                                ),
                                TimeWidget(
                                  checkInDateTime: lastCheckInDateTime,
                                  isFrom: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
