import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/models/enums/type_for.dart';
import 'package:out_out/data/view_models/category/category_response_list_operation_result.dart';
import 'package:out_out/views/event/pages/events_all_page.dart';
import 'package:out_out/views/event/pages/events_featured_events_page.dart';
import 'package:out_out/views/event/pages/events_near_you_page.dart';
import 'package:out_out/views/event/pages/events_today_page.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/custom_chip.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  final List<String>? initialFilterCategoriesIds;

  const EventsScreen({
    this.initialFilterCategoriesIds,
    Key? key,
  }) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<String> _selectedCategoriesIds = [];

  @override
  void initState() {
    super.initState();
    _selectedCategoriesIds = widget.initialFilterCategoriesIds ?? [];
  }

  RefreshNotifier refreshNotifier = RefreshNotifier();

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => refreshNotifier,
      child: CustomTabViewScaffold(
        searchFieldText: "Search for Events",
        items: [
          EventsTodayPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
          EventsNearYouPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
          EventsFeaturedEventsPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
          EventsAllPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
        ],
        headerHeight: 160.0,
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              width: double.infinity,
              height: 30.0,
              child: CustomFutureBuilder<CategoryResponseListOperationResult>(
                initFuture: () => ApiRepo().categoryClient.getActiveCategories(TypeFor.event.value),
                onLoading: (context) {
                  return FittedBox(
                    alignment: Alignment.center,
                    child: AdaptiveProgressIndicator(),
                  );
                },
                onSuccess: (context, snapshot) {
                  final result = snapshot.data?.result ?? [];
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: result.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    itemBuilder: (context, index) {
                      final item = result[index];
                      return CustomChip(
                        label: Text(item.name),
                        avatar: UniversalImage.category(
                          item.icon,
                          selected: _selectedCategoriesIds.contains(item.id),
                        ),
                        selected: _selectedCategoriesIds.contains(item.id),
                        onSelected: (newSelected) {
                          setState(() {
                            if (newSelected) {
                              _selectedCategoriesIds.add(item.id);
                            } else {
                              _selectedCategoriesIds.remove(item.id);
                            }
                            refreshNotifier.refresh();
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            HorizontallyPaddedTitleText("Choose your Event"),
             const SizedBox(height: 10.0),

          ],
        ),
      ),
    );
  }
}
