import 'dart:async';

import 'package:flairstechsuite_mobile/main.dart';
import 'package:flairstechsuite_mobile/models/api/responses.dart';
import 'package:flairstechsuite_mobile/models/notification.dart';
import 'package:flairstechsuite_mobile/providers/my_profile_provider.dart';
import 'package:flairstechsuite_mobile/repo/repository.dart';
import 'package:flairstechsuite_mobile/utils/notifier_utils.dart';
import 'package:flairstechsuite_mobile/utils/resources_utils.dart';
import 'package:flairstechsuite_mobile/widgets/basic/adaptive_alert_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/bottom_bar.dart';
import 'package:flairstechsuite_mobile/widgets/basic/confirmation_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_builder.dart';
import 'package:flairstechsuite_mobile/widgets/basic/future_dialog.dart';
import 'package:flairstechsuite_mobile/widgets/basic/refreshable.dart';
import 'package:flairstechsuite_mobile/widgets/basic/drawer_scaffold.dart' as menu;
import 'package:flairstechsuite_mobile/widgets/notification_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class TenroxTasksPage extends StatefulWidget {
  @override
  _TenroxTasksPageState createState() => _TenroxTasksPageState();
}

class _TenroxTasksPageState extends State<TenroxTasksPage>
    // ignore: prefer_mixin
    with
        WidgetsBindingObserver {
  final _refreshableKey = GlobalKey<RefreshableState>();
  StreamSubscription? _notificationSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _notificationSub = localNotificationStream.listen((notification) {
      if (notification.type != NotificationType.tasksStatusChanged) return;
      _refreshableKey.currentState!.refresh();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _notificationSub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed)
      _refreshableKey.currentState!.refresh();
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
            title: Text("My Tenrox Tasks".toUpperCase()),
          ),
          body: Refreshable(
            key: _refreshableKey,
            child: RefreshIndicator(
              onRefresh: () async => _refreshableKey.currentState!.refresh(),
              child: CustomFutureBuilder<TenroxTaskDTOListResponse>(
                initFuture: () => Repository().getMyTasks(),
                onError: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        Repository().getMyTasks();
                      },
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.account_circle),
                            const SizedBox(height: 4.0),
                            Text(snapshot.data!.errorMessage!,
                                textAlign: TextAlign.center),
                            Text("Tap to try again"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                onSuccess: (context, snapshot) {
                  final tasks = snapshot.data!.result;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
                    itemCount: tasks?.length ?? 0,
                    itemBuilder: (context, index) {
                      final task = tasks![index];
                      return TenroxTaskTile(
                        task: task,
                        hasARunningTask:
                            tasks.indexWhere((e) => e.isRunning!) != -1,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class TenroxTaskTile extends StatelessWidget {
  const TenroxTaskTile({
    Key? key,
    required this.task,
    required this.hasARunningTask,
  }) : super(key: key);

  final TenroxTaskDTO task;
  final bool hasARunningTask;

  @override
  Widget build(BuildContext context) {
    final taskStartTimeFormat = DateFormat("dd MMM").add_jm();
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: Colors.grey, width: 0.7),
      ),
      color: !task.isRunning! ? Theme.of(context).scaffoldBackgroundColor : null,
      elevation: !task.isRunning! ? 0.0 : 3.0,
      child: Container(
        alignment: Alignment.center,
        color: task.isRunning! ? Colors.black.withOpacity(0.05) : null,
        height: 70,
        child: ListTile(
          title: Text(
            task.taskTitle!,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: task.isRunning!
              ? Text("Started at ${taskStartTimeFormat.format(task.startedOn!)}")
              : null,
          trailing: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: MaterialButton(
              color: task.isRunning!
                  ? Theme.of(context).primaryColor
                  : Color(0xff73bfc7),
              child: Text(task.isRunning! ? "STOP" : "START"),
              onPressed: () async {
                if (task.isRunning!) {
                  final now = DateTime.now();
                  final settings =
                      await Repository().getMyOrganizationSettings();
                  final difference = now.difference(task.startedOn??now).inMinutes;
                  if (settings.result?.minimumTaskTime !=null && difference < settings.result!.minimumTaskTime!) {
                    final confirmation = await showConfirmationDialog(
                      context: context,
                      title: "Discard task progress",
                      actionText:
                          "The task progress is less than ${settings.result!.minimumTaskTime} minutes"
                          " (minimum allowed time). Do you want to discard the task?",
                      icon: Icons.cancel,
                    );
                    if (!confirmation) {
                      return;
                    }
                  }
                }
                if (!task.isRunning! && hasARunningTask) {
                  await showAdaptiveAlertDialog(
                    context: context,
                    title: Text("Error"),
                    content: Text(
                        "You still have an ongoing task. Stop it before starting another one."),
                  );
                  return;
                }
                final response = await (showFutureProgressDialog<BoolResponse?>(
                  context: context,
                  initFuture: () async {
                    BoolResponse response;
                    if (task.isRunning!) {
                      response = await Repository().endTask(task.id);
                    } else {
                      response =
                          await Repository().startTask(task.id, task.taskTitle);
                    }
                    return response;
                  },
                ) as FutureOr<BoolResponse?>);
                if ( response?.status!=null && !response!.status) {
                  await showErrorDialog(context, response);
                } else {
                  Refreshable.of(context)!.refresh();
                  Provider.of<MyProfileProvider>(context, listen: false)
                      .refresh();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
