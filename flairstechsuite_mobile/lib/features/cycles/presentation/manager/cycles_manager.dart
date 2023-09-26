import 'package:flairstechsuite_mobile/core/network/failure.dart';
import 'package:flairstechsuite_mobile/features/cycles/data/model/cycle/cycle_dto.dart';
import 'package:flairstechsuite_mobile/features/cycles/data/repository/cycle_repository_impl.dart';
import 'package:flutter/widgets.dart';

class CycleProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final _cycleRepositoryImpl = CycleRepositoryImpl();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addCycle(
      String name,
      DateTime from,
      DateTime to,
      bool? isCurrent,
      int? country,
      Function(Failure) ifLeft,
      Function(CycleDTOResponse) ifRight) async {
    setLoading(true);

    final response = await _cycleRepositoryImpl.addCycle(CycleDTO(
        name: name.trim(),
        from: from,
        to: to,
        isCurrent: isCurrent,
        country: country));
    setLoading(false);

    response.fold(
      (error) => ifLeft(error),
      (cycle) => ifRight(cycle),
    );
  }
}
