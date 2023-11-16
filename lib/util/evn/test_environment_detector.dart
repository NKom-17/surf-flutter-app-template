import 'dart:io';

/// Class to provide function for test environment detection
abstract class TestEnvironmentDetector {
  /// Is test environment using now.
  static bool get isTestEnvironment {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}
