import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/models/enums/type_for.dart';
import 'package:out_out/data/view_models/category/category_response.dart';
import 'package:out_out/data/view_models/category/category_response_list_operation_result.dart';
import 'package:out_out/data/view_models/city/city_response.dart';
import 'package:out_out/data/view_models/city/city_response_list_operation_result.dart';
import 'package:out_out/data/view_models/home/home_page_filteration_request.dart';
import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response.dart';
import 'package:out_out/data/view_models/venue_deal/offer_type_summary_response_list_operation_result.dart';
import 'package:out_out/navigation/navigation.dart';
import 'package:out_out/widgets/fields/custom_date_range_form_field.dart';
import 'package:out_out/widgets/fields/custom_dropdown_form_field.dart';
import 'package:out_out/widgets/fields/custom_multi_select_form_field.dart';
import 'package:out_out/widgets/loading/future_builder.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/popups/adaptive_bottom_sheet.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormBuilderState>();

Future showFilterBottomSheet<T>(BuildContext context) async {
  await showAdaptiveBottomSheet<T>(
    context: context,
    showCloseButton: true,
    backgroundColor: Colors.white,
    content: HomeSheetFilter(),
    actions: <AdaptiveBottomSheetAction>[
      AdaptiveBottomSheetAction(
        title: "Apply",
        isPrimary: true,
        onPressed: () async {
          var formState = _formKey.currentState;
          if (formState == null) return;
          if (!formState.saveAndValidate()) {
            return;
          }

          final deals = formState.value["deals"] as OfferTypeSummaryResponse?;
          final city = formState.value["city"] as CityResponse?;
          final range = formState.value["date"] as DateTimeRange?;

          final from = range?.start;
          final to = range?.end.add(Duration(days: 1));

          final venueCategory =
              formState.value["venue_category"] as List<CategoryResponse>?;
          final eventCategory =
              formState.value["event_category"] as List<CategoryResponse>?;
          final areas = formState.value["areas"] as List<String>?;

          final request = new HomePageFilterationRequest()
            ..searchQuery = null
            ..areas = areas?.cast<String>()
            ..eventCategories =
                (eventCategory)!.map((item) => item.id).cast<String>().toList()
            ..venueCategories =
                (venueCategory)!.map((item) => item.id).cast<String>().toList()
            ..offerTypeId = deals?.id
            ..cityId = city?.id
            ..from = from != null
                ? DateTime.tryParse(
                    DateFormat("yyyy-MM-ddTHH:mm:ss.000'Z'").format(from))
                : from
            ..to = to != null
                ? DateTime.tryParse(
                    DateFormat("yyyy-MM-ddTHH:mm:ss.000'Z'").format(to))
                : to;

          await Navigator.of(context).maybePop();
          Navigation().navToSearchFilterScreen(
            context,
            dateTime: request.from ??
                DateTime.tryParse(DateFormat("yyyy-MM-ddTHH:mm:ss.000'Z'")
                    .format(DateTime.now()))!,
            homePageFilterationRequest: request,
          );
        },
      ),
    ],
  );
}

class HomeSheetFilter extends StatefulWidget {
  const HomeSheetFilter({Key? key}) : super(key: key);

  @override
  _HomeSheetFilterState createState() => _HomeSheetFilterState();
}

class _HomeSheetFilterState extends State<HomeSheetFilter> {
  RefreshNotifier areaRefreshNotifier = RefreshNotifier();
  CityResponse? cityResponse;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontallyPaddedTitleText("Filter By"),
            const SizedBox(height: 8.0),
            Divider(height: .5),
            const SizedBox(height: 16.0),

            CustomFutureBuilder<CategoryResponseListOperationResult>(
              initFuture: () => ApiRepo()
                  .categoryClient
                  .getActiveCategories(TypeFor.venue.value),
              onSuccess: (context, snapshot) {
                final result = snapshot.data?.result ?? [];
                return Card(
                  elevation: 4,
                  shadowColor: Colors.grey[50],
                  child: CustomMultiSelectFormField<CategoryResponse>(
                    border: InputBorder.none,
                    name: "venue_category",
                    hintWidget: Text(
                      "Venue Category",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
                    ),
                    chipBackGroundColor: Colors.white,
                    checkBoxActiveColor: Theme.of(context).primaryColor,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    validator: [],
                    items: result,
                    labelBuilder: (item) => item.name,
                    onSaved: (value) {
                      if (value == null) return;
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            CustomFutureBuilder<CategoryResponseListOperationResult>(
              initFuture: () => ApiRepo()
                  .categoryClient
                  .getActiveCategories(TypeFor.event.value),
              onSuccess: (context, snapshot) {
                final result = snapshot.data?.result ?? [];
                return Card(
                  elevation: 4,
                  shadowColor: Colors.grey[50],
                  child: CustomMultiSelectFormField<CategoryResponse>(
                    name: "event_category",
                    border: InputBorder.none,
                    hintWidget: Text(
                      "Event Category",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
                    ),
                    chipBackGroundColor: Colors.white,
                    checkBoxActiveColor: Theme.of(context).primaryColor,
                    checkBoxCheckColor: Colors.white,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    validator: [],
                    items: result,
                    labelBuilder: (item) => item.name,
                    onSaved: (value) {
                      if (value == null) return;
                    },
                  ),
                );
              },
            ),
                        const SizedBox(height: 8),

            CustomFutureBuilder<OfferTypeSumamryResponseListOperationResult>(
              initFuture: () => ApiRepo().offerClient.getOfferTypes(),
              onSuccess: (context, snapshot) => Card(
                elevation: 4,
                shadowColor: Colors.grey[50],
                child: CustomDropdownFormField<OfferTypeSummaryResponse>(
                  name: "deals",
                  labelText: "",
                  hintText: "Deals",
                  items: snapshot.data!.result,
                  itemBuilder: (context, item) =>
                      Text(item.name, overflow: TextOverflow.ellipsis),
                  validators: [],
                  onChanged: (value) {},
                ),
              ),
            ),
                        const SizedBox(height: 8),

            CustomFutureBuilder<CityResponseListOperationResult>(
              initFuture: () async {
                final citiesResults =
                    await ApiRepo().cityClient.getActiveCities();
                return citiesResults;
              },
              onSuccess: (context, snapshot) {
                final result = snapshot.data?.result ?? [];
                return Column(
                  children: [
                    Card(
                      elevation: 4,
                      shadowColor: Colors.grey[50],
                      child: CustomDropdownFormField<CityResponse>(
                        name: "city",
                        labelText: "",
                        hintText: "City",
                        items: result,
                        itemBuilder: (context, item) => Text(item.name),
                        validators: [],
                        onChanged: (value) async {
                          setState(() {
                            cityResponse = value;
                          });
                          areaRefreshNotifier.refresh();
                        },
                      ),
                    ),
                    if (cityResponse != null)
                      Refreshable(
                        refreshNotifier: areaRefreshNotifier,
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.grey[50],
                          child: CustomMultiSelectFormField<String>(
                            name: "areas",
                            border: InputBorder.none,
                            hintWidget: Text(
                              "Areas",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16.0),
                            ),
                            validator: [],
                            items: cityResponse!.areas,
                            labelBuilder: (item) => item,
                            onSaved: (value) {
                              if (value == null) return;
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
                        const SizedBox(height: 8),

            Card(
               elevation: 4,
              shadowColor: Colors.grey[50],
              child: CustomDateRangeFormField(
                name: "date",
                labelText: "",
                hintText: "Date",
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
