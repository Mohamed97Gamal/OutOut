import 'package:flutter/material.dart';
import 'package:out_out/assets/icon_assets.dart';
import 'package:out_out/data/api/api_repo.dart';
import 'package:out_out/data/memory/providers/bottom_navigation_bar_provider.dart';
import 'package:out_out/data/memory/providers/my_account_provider.dart';
import 'package:out_out/data/view_models/basic/boolean_operation_result.dart';
import 'package:out_out/widgets/loading/adaptive_progress_indicator.dart';
import 'package:out_out/widgets/loading/future_dialog.dart';
import 'package:out_out/widgets/popups/adaptive_confirmation_dialog.dart';
import 'package:out_out/widgets/universal_image.dart';
import 'package:provider/provider.dart';

class FavoriteVenueButton extends StatefulWidget {
  final double size;
  final EdgeInsets padding;
  final bool initialIsFavorite;
  final ValueChanged<bool>? onChanged;
  final Function? onFailure;
  final String venueId;
  final String venueName;

  const FavoriteVenueButton({
    Key? key,
    required this.venueId,
    required this.venueName,
    required this.initialIsFavorite,
    this.size = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.onChanged,
    this.onFailure,
  }) : super(key: key);

  @override
  _FavoriteVenueButtonState createState() => _FavoriteVenueButtonState();
}

class _FavoriteVenueButtonState extends State<FavoriteVenueButton> {
  late bool isLoading;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isFavorite = widget.initialIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final myAccountProvider = context.read<MyAccountProvider>();
    if (isLoading) {
      return Padding(
        padding: widget.padding,
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: Center(
            child: AdaptiveProgressIndicator(),
          ),
        ),
      );
    }
    return IconButton(
      iconSize: widget.size,
      padding: widget.padding,
      icon: isFavorite
          ? UniversalImage(IconAssets.fill_heart, width: widget.size, height: widget.size)
          : UniversalImage(IconAssets.heart, width: widget.size, height: widget.size),
      onPressed: () async {
        BottomNavigationBarProvider.instance.selectedIndexesHistory.add(1);
        try {
          if (isFavorite) {
            final confirm = await showAdaptiveConfirmationDialog(
              context: context,
              title: widget.venueName,
              content: "Are you sure you want to unfavorite this venue?",
            );
            if (confirm) {
              final result = await showFutureProgressDialog<BooleanOperationResult>(
                context: context,
                initFuture: () => ApiRepo().venueClient.unFavoriteVenue(widget.venueId),
              );
              if (result != null && result.status) {
                setState(() => isFavorite = false);
                if (widget.onChanged != null) {
                  widget.onChanged!(isFavorite);
                }
                myAccountProvider.favoriteVenuesRefreshNotifier.refresh();
              }
            }
          } else if (!isFavorite) {
            final result = await showFutureProgressDialog<BooleanOperationResult>(
              context: context,
              initFuture: () => ApiRepo().venueClient.favoriteVenue(widget.venueId),
            );
            if (result != null && result.status) {
              setState(() => isFavorite = true);
              if (widget.onChanged != null) {
                widget.onChanged!(isFavorite);
              }
              myAccountProvider.favoriteVenuesRefreshNotifier.refresh();
            }
          }
        } catch (ex) {
          if (widget.onFailure != null) {
            widget.onFailure!();
          }
        } finally {
          setState(() => isLoading = false);
        }
      },
    );
  }
}
