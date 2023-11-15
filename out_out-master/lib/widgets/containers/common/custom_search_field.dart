import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class CustomSearchField extends StatelessWidget {
  final Function()? onFilterPressed;
  final String searchFieldText;
  final Function(String)? onSearchFieldSubmitted;

  const CustomSearchField({
    Key? key,
    this.onFilterPressed,
    required this.searchFieldText,
    this.onSearchFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchProvider = context.watch<SearchProvider>();
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Hero(
                tag: "SearchField",
                child: Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        UniversalImage(
                          IconAssets.search,
                          width: 20.0,
                          height: 20.0,
                        ),
                        Expanded(
                          child: TextField(
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: searchProvider.controller,
                            onSubmitted: onSearchFieldSubmitted,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              fillColor: Colors.white,
                              hintText: searchFieldText,
                              hintStyle: TextStyle(
                                color: Color(0xffd5d5d5),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            onChanged: (value) {
                              searchProvider.onChanged();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (onFilterPressed != null)
              Hero(
                tag: "FilterButton",
                child: IconButton(
                  icon: UniversalImage(IconAssets.filter),
                  onPressed: onFilterPressed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
