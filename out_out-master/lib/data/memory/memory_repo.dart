import 'package:out_out/data/models/tokens_data.dart';
import 'package:package_info/package_info.dart';

class MemoryRepo {
  static final MemoryRepo _singleton = MemoryRepo._internal();

  factory MemoryRepo() => _singleton;

  MemoryRepo._internal();

  late PackageInfo packageInfo;

  Future ensureInitialized() async {
    packageInfo = await PackageInfo.fromPlatform();
    return true;
  }

  TokensData? _tokensData;

  TokensData? get tokensData => _tokensData;

  void updateTokensData(TokensData tokens_data) {
    _tokensData = tokens_data;
  }

  void deleteTokensData() {
    _tokensData = null;
  }
}
