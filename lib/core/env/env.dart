class Env {
  static EnvValue? envValue;

  static String get baseUrl {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return "";
      case EnvValue.STAGING:
        return "";
      case EnvValue.PRODUCTION:
        return "";
      default:
        return ""; // development url
    }
  }

  static bool get isDevelopment {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return false;
      case EnvValue.STAGING:
        return true;
      case EnvValue.PRODUCTION:
        return false;
      default:
        return true;
    }
  }

  static String get apiMKey {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return "";
      case EnvValue.STAGING:
        return "";
      case EnvValue.PRODUCTION:
        return "";
      default:
        return "";
    }
  }

  static String get mapsToken {
    switch (envValue) {
      case EnvValue.DEVELOPMENT:
        return "";
      case EnvValue.STAGING:
        return "";
      case EnvValue.PRODUCTION:
        return "";
      default:
        return "";
    }
  }
}

enum EnvValue { DEVELOPMENT, STAGING, PRODUCTION }
