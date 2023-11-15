import 'package:flutter/material.dart';
import 'package:out_out/views/event/pages/my_favourites_events_page.dart';
import 'package:out_out/views/venue/pages/my_favourites_venues_page.dart';
import 'package:out_out/widgets/containers/custom_tab_view_scaffold.dart';
import 'package:out_out/widgets/title_text.dart';

class MyFavouritesScreen extends StatelessWidget {
  const MyFavouritesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabViewScaffold(
      searchFieldText: "Search for Venues,Events",
      headerHeight: 100.0,
      items: [
        MyFavoritesVenuesPage(),
        MyFavouritesEventsPage(),
      ],
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HorizontallyPaddedTitleText("My Favorites"),
        ],
      ),
    );
  }
}
