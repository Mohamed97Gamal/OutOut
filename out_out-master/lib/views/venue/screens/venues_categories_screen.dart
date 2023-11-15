import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/models/enums/type_for.dart';
import 'package:out_out/data/view_models/category/category_response_list_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/custom_chip.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:out_out/widgets/universal_image.dart';

class VenuesCategoriesScreen extends StatefulWidget {
  const VenuesCategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _VenuesCategoriesScreenState createState() => _VenuesCategoriesScreenState();
}

class _VenuesCategoriesScreenState extends State<VenuesCategoriesScreen> {
  final List<String> _selectedCategoriesIds = [];

  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      body: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontallyPaddedTitleText("Choose Your Venue Category"),
            CustomFutureBuilder<CategoryResponseListOperationResult>(
              initFuture: () => ApiRepo().categoryClient.getActiveCategories(TypeFor.venue.value),
              onSuccess: (context, snapshot) {
                final result = snapshot.data!.result;
                return GridView.builder(
                  padding: const EdgeInsets.only(left: 32.0, top: 16.0),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: result.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final item = result[index];
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: CustomChip(
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
                          });
                        },
                      ),
                    );
                  },
                );
              },
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                child: Text("Search"),
                onPressed: () {
                  Navigation().navToVenuesScreen(
                    context,
                    initialFilterCategoriesIds: _selectedCategoriesIds,
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
