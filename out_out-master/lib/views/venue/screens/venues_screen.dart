import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/models/enums/type_for.dart';
import 'package:out_out/data/view_models/category/category_response_list_operation_result.dart';
import 'package:out_out/views/venue/pages/venues_all_page.dart';
import 'package:out_out/views/venue/pages/venues_deals_now_page.dart';
import 'package:out_out/views/venue/pages/venues_open_now_page.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/custom_chip.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class VenuesScreen extends StatefulWidget {
  final List<String>? initialFilterCategoriesIds;

  const VenuesScreen({
    this.initialFilterCategoriesIds,
    Key? key,
  }) : super(key: key);

  @override
  _VenuesScreenState createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
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
        searchFieldText: "Search for Venues",
        items: [
          VenuesOpenNowPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
          VenuesDealsNowPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
          VenuesAllPage(
            filterCategoriesIds: _selectedCategoriesIds,
          ),
        ],
        headerHeight: 140.0,
        header: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              width: double.infinity,
              height: 30.0,
              child: CustomFutureBuilder<CategoryResponseListOperationResult>(
                initFuture: () => ApiRepo().categoryClient.getActiveCategories(TypeFor.venue.value),
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
            const SizedBox(height: 10.0),
            HorizontallyPaddedTitleText("Choose your Venue"),
          ],
        ),
      ),
    );
  }
}
