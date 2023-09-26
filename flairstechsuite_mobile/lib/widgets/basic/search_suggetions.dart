import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  final List<String>? suggestions;
  final String? query;
  final ValueChanged<String>? onSelected;

  const SuggestionList({this.suggestions, this.query, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions!.length,
      itemBuilder: (context, i) {
        final suggestion = suggestions![i];
        if (suggestion.contains(query!)) {
          return ListTile(
            leading: query!.isEmpty ? const Icon(Icons.history) : const Icon(null),
            title: RichText(
              text: TextSpan(
                text: suggestion.substring(0, suggestion.indexOf(query!)),
                style: theme.textTheme.subtitle1,
                children: <TextSpan>[
                  TextSpan(
                    text: query,
                    style: theme.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: suggestion.substring(query!.length + suggestion.indexOf(query!)),
                    style: theme.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            onTap: () {
              onSelected!(suggestion);
            },
          );
        } else {
          return ListTile(
            leading: query!.isEmpty ? const Icon(Icons.history) : const Icon(null),
            title: Text(
              suggestion,
              style: theme.textTheme.subtitle1,
            ),
            onTap: () {
              onSelected!(suggestion);
            },
          );
        }
      },
    );
  }
}
