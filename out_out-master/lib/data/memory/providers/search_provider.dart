import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:out_out/widgets/loading/future_builder.dart';

class SearchProvider with ChangeNotifier, DiagnosticableTreeMixin {
  static final SearchProvider instance = SearchProvider();

  final RefreshNotifier refreshNotifier = RefreshNotifier();
  final TextEditingController controller = TextEditingController();
  Timer? _debounce;
  final List<String> history = [];

  SearchProvider();

  bool _searchVisible = false;
  bool _filterVisible = false;

  String _text = "";

  String get text => controller.text.trim();

  bool get searchVisible => _searchVisible;

  bool get filterVisible => _filterVisible;

  void onChanged() {
    if (controller.text == _text) {
      return;
    }
    _text = controller.text;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      refreshNotifier.refresh();
    });
  }

  void reset() {
    _debounce?.cancel();
    _text = "";
    controller.text = "";
    notifyListeners();
  }

  void show() {
    _searchVisible = true;
    _filterVisible = false;
    _debounce?.cancel();
    notifyListeners();
  }

  void showWithFilter() {
    _searchVisible = true;
    _filterVisible = true;
    _debounce?.cancel();
    notifyListeners();
  }

  void hide() {
    _searchVisible = false;
    _filterVisible = false;
    _debounce?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }

  void stack() {
    history.add(controller.text);
    controller.clear();
  }

  void pop() {
    if(history.isEmpty)
      return;
    final value = history.removeLast();
    controller.text = value;
  }
}
