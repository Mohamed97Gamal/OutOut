import 'package:flutter/material.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/view_models/faq/faq_filteration_request.dart';
import 'package:out_out/data/view_models/faq/faq_response.dart';
import 'package:out_out/widgets/containers/custom_flat_scaffold.dart';
import 'package:out_out/widgets/loading/custom_paged_sliver_list_view.dart';
import 'package:out_out/widgets/loading/refreshable.dart';
import 'package:out_out/widgets/title_text.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFlatScaffold(
      searchFieldText: "Search for FAQ",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HorizontallyPaddedTitleText("FAQs"),
          const SizedBox(height: 16.0),
        ],
      ),
      slivers: [
        Refreshable(
          refreshNotifier: context.read<SearchProvider>().refreshNotifier,
          child: CustomPagedSliverListView<FAQResponse>(
            initPageFuture: (pageKey) async {
              final request = new FAQFilterationRequest()..searchQuery = context.read<SearchProvider>().text;
              var faqResult = await ApiRepo().faqClient.getAllFAQ(request, pageKey, 7);
              return faqResult.result.toPagedList();
            },
            itemBuilder: (context, item, index) {
              return FAQItem(faqResponse: item);
            },
          ),
        ),
      ],
    );
  }
}

class FAQItem extends StatefulWidget {
  final FAQResponse faqResponse;

  const FAQItem({
    Key? key,
    required this.faqResponse,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> with SingleTickerProviderStateMixin {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                child: Text("Q${widget.faqResponse.questionNumber}  ${widget.faqResponse.question}"),
              ),
              trailing: IconButton(
                onPressed: () => setState(() => tapped = !tapped),
                icon: Icon(tapped ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right),
              ),
            ),
            Divider(
              height: 1.0,
              indent: 16.0,
            ),
            if (tapped)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0, bottom: 40.0),
                child: Text(
                  widget.faqResponse.answer,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
