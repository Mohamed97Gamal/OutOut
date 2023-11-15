import 'package:flutter/material.dart';
import 'package:out_out/config.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/memory/providers/search_provider.dart';
import 'package:out_out/data/models/enums/payment_status.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

class TelrPaymentScreen extends StatefulWidget {
  final String url;
  final String bookingId;

  const TelrPaymentScreen({
    Key? key,
    required this.url,
    required this.bookingId,
  }) : super(key: key);

  @override
  _TelrPaymentScreenState createState() => _TelrPaymentScreenState();
}

class _TelrPaymentScreenState extends State<TelrPaymentScreen> {
  bool canGoBack = true;

  @override
  Widget build(BuildContext context) {
    WebViewController webViewController=WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (value) async {
          if (value.startsWith("${apiBaseUrl}Payment/Paid")) {
            await showFutureProgressDialog<String>(
              context: context,
              initFuture: () async {
                return await ApiRepo().paymentClient.paid(widget.bookingId);
              },
            );
            Navigator.of(context).pop(PaymentStatus.paid);
          } else if (value.contains("${apiBaseUrl}Payment/Cancelled")) {
            await showFutureProgressDialog<String>(
              context: context,
              initFuture: () async {
                return await ApiRepo().paymentClient.cancelled(widget.bookingId);
              },
            );
            Navigator.of(context).pop(PaymentStatus.cancelled);
          } else if (value.contains("${apiBaseUrl}Payment/Declined")) {
            await showFutureProgressDialog<String>(
              context: context,
              initFuture: () async {
                return await ApiRepo().paymentClient.declined(widget.bookingId);
              },
            );
            Navigator.of(context).pop(PaymentStatus.declined);
          }
        },
        onPageStarted: (value) async {
          if (value.startsWith("${apiBaseUrl}Payment/Paid")) {
            setState(() {
              canGoBack = false;
            });
          } else if (value.contains("${apiBaseUrl}Payment/Cancelled")) {
            setState(() {
              canGoBack = false;
            });
          } else if (value.contains("${apiBaseUrl}Payment/Declined")) {
            setState(() {
              canGoBack = false;
            });
          } else {
            setState(() {
              canGoBack = true;
            });
          }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      )
    )
    ..loadRequest(Uri.parse(widget.url));
    return WillPopScope(
      onWillPop: () async {
        if (!canGoBack) return false;

        var bottomNavProvider = context.read<BottomNavigationBarProvider>();
        bottomNavProvider.back();
        context.read<SearchProvider>().pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: WebViewWidget(
            controller: webViewController,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
