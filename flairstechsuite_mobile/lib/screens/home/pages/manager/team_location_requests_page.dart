import 'dart:async';

import 'package:flairstechsuite_mobile/models/api/requests.dart';
import 'package:flairstechsuite_mobile/enums/location_status.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/screens/home/pages/admin/location_requests_page.dart';
import 'package:flairstechsuite_mobile/utils/load_more_delegate.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';


class TeamLocationRequestsPage extends StatefulWidget {
  static const _PAGE_SIZE = 5;

  @override
  _TeamLocationRequestsPageState createState() =>
      _TeamLocationRequestsPageState();
}

class _TeamLocationRequestsPageState extends State<TeamLocationRequestsPage> {
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
            title: Text("Team Location Requests".toUpperCase()),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {});
                                if (_debounce?.isActive ?? false)
                                  _debounce!.cancel();
                                _debounce = Timer(
                                    const Duration(milliseconds: 700), () {
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
                                        color: Colors.black.withOpacity(0.6)),
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
                                        const Duration(milliseconds: 500), () {
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
                          PopupMenuButton<LocationStatus>(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            offset: Offset(0, 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(FontAwesomeIcons.filter,
                                    size: 20, color: Colors.black87),
                                const SizedBox(width: 2),
                                FaIcon(FontAwesomeIcons.angleDown,
                                    size: 16, color: Colors.black87),
                              ],
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
      final response = await Repository().getAllLocationsForManager(
        pageNumber:
            ((_locations?.length ?? 0) / TeamLocationRequestsPage._PAGE_SIZE)
                .ceil(),
        pageSize: TeamLocationRequestsPage._PAGE_SIZE,
        filter: AllLocationFilterRequest(
          statuses: selectedStatuses,
          searchQueries: [_searchController.text.trim()],
        ),
      );
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
