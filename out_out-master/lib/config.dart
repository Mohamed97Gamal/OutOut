enum Environment { development, staging, uat, production }

extension EnvironmentExtension on Environment {
  String get name {
    switch (this) {
      case Environment.development:
        return "Development";
      case Environment.staging:
        return "Staging";
      case Environment.uat:
        return "User Acceptance Testing";
      case Environment.production:
        return "Production";
    }
  }
}

const Environment kEnvironment = Environment.uat;

String get geoApiKey {
  if (kEnvironment == Environment.production) {
    return "AIzaSyBqylCMhwCPepgZBIx-mgtgjSaiFbfFnUo";
  }
  return "AIzaSyBqylCMhwCPepgZBIx-mgtgjSaiFbfFnUo";
}

String get apiBaseUrl {
  switch (kEnvironment) {
    case Environment.development:
      return "https://192.168.54.200:20231/api/";
    case Environment.staging:
      return "https://192.168.54.200:2023/api/";
    case Environment.uat:
      return "https://api.outout.com/api/";
    case Environment.production:
      //TODO: update production apiBaseUrl
      return "";
  }
}

String get androidPackageName => "com.outout.mobile";

String get iOSBundleId => "com.outout.ios";

String get appStoreId => "1580266037";

String get dynamicLinksUriPrefix {
  if (kEnvironment == Environment.production) {
    //TODO: update production dynamicLinksUriPrefix
    return "";
  }
  return "https://outoutstaging.page.link";
}

//TODO: update dynamicLinksBaseUrl
String get websiteUrl {
  switch (kEnvironment) {
    case Environment.uat:
      return "https://uat.outout.com/";
    case Environment.production:
    case Environment.development:
    case Environment.staging:
      return "https://outout.com/";
  }
}

String get dynamicLinksBaseUrl {
  return websiteUrl;
}
