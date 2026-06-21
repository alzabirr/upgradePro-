// ignore_for_file: avoid_print
import 'dart:io';

void main(List<String> args) {
  if (args.length < 2) {
    print('Usage: dart rename.dart <new_app_name_snake_case> <new_bundle_id_dotted> ["App Display Name"]');
    print('Example: dart rename.dart my_awesome_app com.example.myawesomeapp "My Awesome App"');
    exit(1);
  }

  final newAppName = args[0].trim();
  final newBundleId = args[1].trim();
  final displayName = args.length > 2 ? args[2].trim() : _toDisplayName(newAppName);

  // Validate snake_case app name
  if (!RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(newAppName)) {
    print('Error: App name must be snake_case (e.g. my_awesome_app). Got: $newAppName');
    exit(1);
  }

  // Validate bundle ID
  if (!RegExp(r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$').hasMatch(newBundleId)) {
    print('Error: Bundle ID must be dotted format (e.g. com.example.myapp). Got: $newBundleId');
    exit(1);
  }

  print('Renaming project to:');
  print('  App Name (snake_case): $newAppName');
  print('  Bundle ID:            $newBundleId');
  print('  Display Name:         $displayName');
  print('----------------------------------------');

  try {
    // 1. Rename in pubspec.yaml
    _replaceInFile('pubspec.yaml', 'name: upgrade_flutter_starter_kit', 'name: $newAppName');

    // 2. Rename in Dart files
    _renameDartImports(newAppName);

    // 3. Rename in Android
    _renameAndroid(newBundleId, displayName);

    // 4. Rename in iOS
    _renameIOS(newBundleId, displayName);

    // 5. Rename in macOS
    _renameMacOS(newBundleId, displayName);

    // 6. Rename in Linux
    _renameLinux(newBundleId);

    // 7. Rename in Web
    _renameWeb(newAppName, displayName);

    print('----------------------------------------');
    print('Successfully renamed project! Run "flutter clean" and "flutter pub get" before building.');
  } catch (e) {
    print('An error occurred during renaming: $e');
    exit(1);
  }
}

String _toDisplayName(String snakeCase) {
  return snakeCase
      .split('_')
      .map((word) => word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
      .join(' ');
}

void _replaceInFile(String path, Pattern target, String replacement) {
  final file = File(path);
  if (!file.existsSync()) return;

  final content = file.readAsStringSync();
  final updated = content.replaceAll(target, replacement);
  file.writeAsStringSync(updated);
  print('Updated: $path');
}

void _renameDartImports(String newAppName) {
  final directories = [Directory('lib'), Directory('test')];
  for (final dir in directories) {
    if (!dir.existsSync()) continue;
    dir.listSync(recursive: true).forEach((entity) {
      if (entity is File && entity.path.endsWith('.dart')) {
        _replaceInFile(
          entity.path,
          'package:upgrade_flutter_starter_kit/',
          'package:$newAppName/',
        );
      }
    });
  }
}

void _renameAndroid(String newBundleId, String displayName) {
  // Update AndroidManifest.xml
  _replaceInFile(
    'android/app/src/main/AndroidManifest.xml',
    'android:label="snap"',
    'android:label="$displayName"',
  );

  // Update build.gradle.kts
  _replaceInFile(
    'android/app/build.gradle.kts',
    'namespace = "com.example.snap"',
    'namespace = "$newBundleId"',
  );
  _replaceInFile(
    'android/app/build.gradle.kts',
    'applicationId = "com.example.snap"',
    'applicationId = "$newBundleId"',
  );

  // Update and move Kotlin/Java MainActivity
  final kotlinBaseDir = Directory('android/app/src/main/kotlin');
  if (kotlinBaseDir.existsSync()) {
    // Find MainActivity.kt
    File? mainActivityFile;
    kotlinBaseDir.listSync(recursive: true).forEach((entity) {
      if (entity is File && entity.path.endsWith('MainActivity.kt')) {
        mainActivityFile = entity;
      }
    });

    if (mainActivityFile != null) {
      final oldContent = mainActivityFile!.readAsStringSync();
      
      // Update package statement in MainActivity.kt
      final packageRegex = RegExp(r'package\s+[a-zA-Z0-9_.]+');
      final updatedContent = oldContent.replaceFirst(packageRegex, 'package $newBundleId');
      
      // Create new directory path
      final newPathPart = newBundleId.replaceAll('.', '/');
      final newDir = Directory('android/app/src/main/kotlin/$newPathPart');
      newDir.createSync(recursive: true);
      
      final newFile = File('${newDir.path}/MainActivity.kt');
      newFile.writeAsStringSync(updatedContent);
      print('Created MainActivity.kt at ${newFile.path}');

      // Clean up old directory if different
      if (mainActivityFile!.path != newFile.path) {
        mainActivityFile!.deleteSync();
        print('Deleted old MainActivity.kt');
        
        // Clean up empty parent directories
        var parent = mainActivityFile!.parent;
        while (parent.path != kotlinBaseDir.path) {
          if (parent.listSync().isEmpty) {
            parent.deleteSync();
            print('Deleted empty directory: ${parent.path}');
            parent = parent.parent;
          } else {
            break;
          }
        }
      }
    }
  }
}

void _renameIOS(String newBundleId, String displayName) {
  final pbxprojPath = 'ios/Runner.xcodeproj/project.pbxproj';
  _replaceInFile(
    pbxprojPath,
    'PRODUCT_BUNDLE_IDENTIFIER = com.example.snap;',
    'PRODUCT_BUNDLE_IDENTIFIER = $newBundleId;',
  );
  _replaceInFile(
    pbxprojPath,
    'PRODUCT_BUNDLE_IDENTIFIER = com.example.snap.RunnerTests;',
    'PRODUCT_BUNDLE_IDENTIFIER = $newBundleId.RunnerTests;',
  );

  final plistPath = 'ios/Runner/Info.plist';
  if (File(plistPath).existsSync()) {
    _replaceInFile(
      plistPath,
      '<key>CFBundleDisplayName</key>\n\t<string>Snap</string>',
      '<key>CFBundleDisplayName</key>\n\t<string>$displayName</string>',
    );
    _replaceInFile(
      plistPath,
      '<key>CFBundleName</key>\n\t<string>snap</string>',
      '<key>CFBundleName</key>\n\t<string>$displayName</string>',
    );
  }
}

void _renameMacOS(String newBundleId, String displayName) {
  final pbxprojPath = 'macos/Runner.xcodeproj/project.pbxproj';
  _replaceInFile(
    pbxprojPath,
    'PRODUCT_BUNDLE_IDENTIFIER = com.example.snap.RunnerTests;',
    'PRODUCT_BUNDLE_IDENTIFIER = $newBundleId.RunnerTests;',
  );

  _replaceInFile(
    'macos/Runner/Configs/AppInfo.xcconfig',
    'PRODUCT_BUNDLE_IDENTIFIER = com.example.snap',
    'PRODUCT_BUNDLE_IDENTIFIER = $newBundleId',
  );
}

void _renameLinux(String newBundleId) {
  _replaceInFile(
    'linux/CMakeLists.txt',
    'set(APPLICATION_ID "com.example.snap")',
    'set(APPLICATION_ID "$newBundleId")',
  );
}

void _renameWeb(String newAppName, String displayName) {
  _replaceInFile(
    'web/index.html',
    '<title>Starter Kit</title>',
    '<title>$displayName</title>',
  );
  
  final manifestPath = 'web/manifest.json';
  if (File(manifestPath).existsSync()) {
    _replaceInFile(
      manifestPath,
      '"name": "upgrade_flutter_starter_kit"',
      '"name": "$displayName"',
    );
    _replaceInFile(
      manifestPath,
      '"short_name": "upgrade_flutter_starter_kit"',
      '"short_name": "$displayName"',
    );
  }
}
