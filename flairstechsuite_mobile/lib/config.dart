import 'package:flairstechsuite_mobile/main.dart';

enum Environment { development, staging, production }

extension EnvironmentExtensions on Environment {
  String get name {
    switch (this) {
      case Environment.development:
        return "Development";
      case Environment.staging:
        return "Staging";
      case Environment.production:
        return "Production";
    }
    throw Exception("Invalid environment");
  }

  bool get isDevelopment => this == Environment.development;

  bool get isStaging => this == Environment.staging;

  bool get isProduction => this == Environment.production;
}

const Environment kEnvironment = FlairstrackerApp.isProduction ? Environment.production : Environment.staging;

String get ssaBaseUrl {
  switch (kEnvironment) {
    case Environment.development:
    case Environment.staging:
      return "https://192.168.54.200:2022/api/";
    case Environment.production:
      return "https://apissa.flairstech.com/api/";
  }
  throw Exception("Invalid environment");
}

String get customerPortalBaseUrl {
  switch (kEnvironment) {
    case Environment.development:
    case Environment.staging:
      return "https://192.168.54.200:2040/api/";
    case Environment.production:
      return "https://apimy.flairstech.com/api/";
  }
  throw Exception("Invalid environment");
}
