class AppConfig {
  static const String appName = 'Upgrade';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'https://api.example.com';

  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheExpiry = Duration(hours: 1);
  static const int maxRetries = 3;
  static const int itemsPerPage = 20;

  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = false;
  static const bool enableCloudSync = false;
}
