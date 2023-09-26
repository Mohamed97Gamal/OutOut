import 'dart:async';

import 'package:flairstechsuite_mobile/models/api/requests.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/providers/manger_team.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/load_more_delegate.dart';
import 'package:flairstechsuite_mobile/utils/navigation.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/enums/location_status.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/views/location_status_icon.dart';
import 'package:flairstechsuite_mobile/views/location_tile.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

class LocationRequestsPage extends StatefulWidget {
  static const _PAGE_SIZE = 5;

  @override
  _LocationRequestsPageState createState() => _LocationRequestsPageState();
}

class _LocationRequestsPageState extends State<LocationRequestsPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  Set<LocationStatus> selectedStatuses = {};
  List<LocationRequestDTO>? _locations;
  int? _recordsTotalCount;

  bool get _hasData => _recordsTotalCount != null && _locations != null;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return menu.DrawerScaffold(
      builder: (context) {
        return NotificationScaffold(
          bottomNavigationBar: const MyBottomNavigationBar(),
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(ResourcesUtils.menu),
              ),
              onPressed: () =>
                  Provider.of<menu.MenuController>(context, listen: false).toggle(),
            ),
            title: Text("Location Requests".toUpperCase()),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48 + 4.0 + 12),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 4, bottom: 12, start: 12, end: 12),
                child: SizedBox(
                  height: 48,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: _searchController,
                              onEditingComplete: () =>
                                  Focus.of(context).unfocus(),
                              onSubmitted: (value) =>
                                  Focus.of(context).unfocus(),
                              onChanged: (value) {
                                setState(() {});
                                if (_debounce?.isActive ?? false)
                                  _debounce!.cancel();
                                _debounce = Timer(
                                    const Duration(milliseconds: 500), () {
                                  _refresh();
                                });
                              },
                              style: Theme.of(context).textTheme.subtitle1,
                              decoration: InputDecoration.collapsed(
                                hintText: "Employee Name",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkResponse(
                            child: Icon(
                              _searchController.text.isEmpty
                                  ? Icons.search
                                  : Icons.clear,
                            ),
                            onTap: _searchController.text.isEmpty
                                ? null
                                : () {
                                    _searchController.clear();
                                    setState(() {});
                                    FocusScope.of(context).unfocus();
                                    if (_debounce?.isActive ?? false)
                                      _debounce!.cancel();
                                    _debounce = Timer(
                                        const Duration(milliseconds: 700), () {
                                      _refresh();
                                    });
                                  },
                          ),
                          VerticalDivider(
                            endIndent: 8,
                            indent: 8,
                            color: Theme.of(context).primaryColor,
                            thickness: 1,
                          ),
                          const SizedBox(width: 8),
                          PopupMenuButton<LocationStatus>(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            offset: Offset(0, 50.0),
                            child: IconButton(
                              onPressed: null,
                              icon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FaIcon(FontAwesomeIcons.filter,
                                      size: 20, color: Colors.black87),
                                  const SizedBox(width: 2),
                                  FaIcon(FontAwesomeIcons.angleDown,
                                      size: 16, color: Colors.black87),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return [
                                for (final status in LocationStatus.values)
                                  PopupMenuItem<LocationStatus>(
                                    value: status,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IgnorePointer(
                                          child: Checkbox(
                                            value: selectedStatuses
                                                .contains(status),
                                            onChanged: (_) {},
                                          ),
                                        ),
                                        Text(status.name!),
                                      ],
                                    ),
                                  ),
                              ];
                            },
                            onSelected: (status) {
                              if (selectedStatuses.contains(status)) {
                                // if (selectedStatuses.length == 1) return;
                                selectedStatuses.remove(status);
                              } else {
                                selectedStatuses.add(status);
                              }
                              _refresh();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: LoadMore(
              delegate: const MyLoadMoreDelegate(),
              onLoadMore: _load,
              isFinish:
                  _hasData ? _locations!.length >= _recordsTotalCount! : false,
              child: ListView.builder(
                padding: const EdgeInsetsDirectional.only(
                    top: 8, bottom: 20, start: 16, end: 16),
                itemCount: _locations?.length ?? 0,
                itemBuilder: (context, index) {
                  return UserLocationRequestsTile(
                    request: _locations![index],
                    onRefresh: _refresh,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _load() async {
    try {
      final response = await Repository().getAllLocationsForAdmin(
        pageNumber:
            ((_locations?.length ?? 0) / LocationRequestsPage._PAGE_SIZE)
                .ceil(),
        pageSize: LocationRequestsPage._PAGE_SIZE,
        filter: AllLocationFilterRequest(
          statuses: selectedStatuses,
          searchQueries: [_searchController.text.trim()],
        ),
      );
      print(response);

      setState(() {
        _recordsTotalCount = response.result!.recordsTotalCount;
        _locations = (_locations ?? []).toList()
          ..addAll(response.result!.records!);
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  _refresh() {
    if (!mounted) return;
    setState(() {
      _recordsTotalCount = null;
      _locations = null;
    });
  }
}

class UserLocationRequestsTile extends StatelessWidget {
  final LocationRequestDTO request;
  final VoidCallback onRefresh;

  UserLocationRequestsTile({
    required this.request,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
  Provider.of<Manager>(context, listen: false).setMyTeam = false;

    final theme = Theme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        buttonTheme: theme.buttonTheme.copyWith(height: 38.0),
      ),
      child: Card(
        margin: const EdgeInsetsDirectional.only(top: 12),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Colors.grey, width: 0.7),
        ),
        child: Container(
          alignment: Alignment.center,
          child: ListTile(
            onTap: () async {
              final result = await Navigation.navToViewEmployeeProfile(
                  context, request.employeeId);
              if (result == true) onRefresh?.call();
            },
            contentPadding:
                EdgeInsetsDirectional.only(start: 16, end: 16, top: 8),
            title: Text(
              request.locations!.first.employee!.fullName!,
              style: theme.textTheme.subtitle1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  request?.locations?.first?.employee?.title ?? "",
                  style: theme.textTheme.subtitle2,
                ),
                for (final location in request.locations!)
                  LocationRequestTile(
                    location: location,
                    onRefresh: onRefresh,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationRequestTile extends StatelessWidget {
  LocationRequestTile({
    Key? key,
    required this.location,
    required this.onRefresh,
  }) : super(key: key);

  final LocationDTO location;
  final VoidCallback onRefresh;
  final GlobalKey<PopupMenuButtonState> _popupKey =
      GlobalKey<PopupMenuButtonState>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -1.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LocationTile(
            location: location,
            bottom: Row(
              children: [
                const Text("Status"),
                const SizedBox(width: 8),
                Stack(
                  children: [
                    Positioned.fill(
                      child: PopupMenuButton<LocationStatus>(
                        key: _popupKey,
                        offset: Offset(0.0, 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(),
                        itemBuilder: (context) {
                          return <PopupMenuItem<LocationStatus>>[
                            if (location.status != LocationStatus.approved)
                              PopupMenuItem(
                                value: LocationStatus.approved,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LocationStatusIcon(LocationStatus.approved,
                                        colored: false),
                                    const SizedBox(width: 8.0),
                                    Text("Approve".toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                            if (location.status != LocationStatus.rejected)
                              PopupMenuItem(
                                value: LocationStatus.rejected,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LocationStatusIcon(LocationStatus.rejected,
                                        colored: false),
                                    const SizedBox(width: 8.0),
                                    Text("Reject".toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                          ];
                        },
                        onSelected: (status) async {
                          final response =
                              await showFutureProgressDialog<BoolResponse>(
                            context: context,
                            initFuture: () async {
                              if (status == LocationStatus.approved) {
                                return Repository()
                                    .approveLocation(location.id);
                              } else if (status == LocationStatus.rejected) {
                                return Repository().rejectLocation(location.id);
                              }
                              return null;
                            },
                          );
                          if (response?.status ?? false) {
                            await showAdaptiveAlertDialog(
                              context: context,
                              content: Text(
                                  "You have successfully ${status.name} the location."),
                            );
                            onRefresh?.call();
                          } else {
                            await showErrorDialog(context, response);
                          }
                        },
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      color: location.status.color,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.keyboard_arrow_down),
                          Text(location.status.name!.toUpperCase()),
                        ],
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        await Future.delayed(
                          Duration(milliseconds: 500),
                          () => _popupKey.currentState!.showButtonMenu(),
                        );
                      },
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
