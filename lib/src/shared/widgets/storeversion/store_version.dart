import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tractorapp/src/core/api/http/client/custom_http_client.dart';
import 'package:tractorapp/src/core/router/config/router_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> checkForUpdate(BuildContext context, WidgetRef ref) async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.buildNumber;
    final buildNumber = packageInfo.version;

    log("Current version: $currentVersion, build number: $buildNumber");

    final apiClient = ref.read(apiClientProvider);
    final response = await apiClient.get('/api/store_version/');

    if (!response.isSuccess) {
      log("Failed to fetch version info: ${response.statusCode}");
      return;
    }

    final latestVersions = response.data;
    log("Latest versions: $latestVersions");

    final latestVersion =
        Platform.isAndroid ? latestVersions["android"] : latestVersions["ios"];

    if (latestVersion == null) {
      log("No version info found for platform: ${Platform.isAndroid ? 'android' : 'ios'}");
      return;
    }

    log("Comparing current: $currentVersion with latest: $latestVersion");

    if (needsUpdate(currentVersion, latestVersion)) {
      log("Showing update dialog");
      final router = ref.read(routerProvider);
      if (router.routerDelegate.navigatorKey.currentContext != null) {
        showUpdateDialog(router.routerDelegate.navigatorKey.currentContext!);
      } else {
        log("Navigator context is null, cannot show dialog");
      }
    }
  } catch (e, stack) {
    log("Error checking for updates: $e");
    log("Stack trace: $stack");
  }
}

bool needsUpdate(String currentVersion, String storeVersion) {
  try {
    // Split versions into components
    final current = currentVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();

    // Ensure both lists have the same length by padding with zeros
    while (current.length < store.length) {
      current.add(0);
    }
    while (store.length < current.length) {
      store.add(0);
    }

    // Compare each component
    for (var i = 0; i < current.length; i++) {
      if (store[i] > current[i]) return true;
      if (store[i] < current[i]) return false;
    }
    return false;
  } catch (e) {
    log("Error comparing versions: $e");
    return false;
  }
}

void showUpdateDialog(BuildContext context) {
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => GestureDetector(
      onTap: () async {
        final url = Platform.isAndroid
            ? 'https://play.google.com/store/apps/details?id=com.tukeapps.tractorapp'
            : "https://apps.apple.com/us/app/tractorapp/id6459458332";

        try {
          if (!await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          )) {
            throw 'Could not launch $url';
          }
        } catch (e) {
          log("Error launching store URL: $e");
          if (context.mounted) {
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('Error'),
                content: Text('Failed to open store: $e'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
        }
      },
      child: CupertinoAlertDialog(
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.arrow_down_circle_fill,
                color: CupertinoColors.activeBlue,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'New Version Available!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: const Text(
          'A new version of tractorapp is available. Update now to get the latest features and improvements.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              final url = Platform.isAndroid
                  ? 'https://play.google.com/store/apps/details?id=com.tukeapps.tractorapp'
                  : "https://apps.apple.com/us/app/tractorapp/id6459458332";

              try {
                if (!await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Could not launch $url';
                }
              } catch (e) {
                log("Error launching store URL: $e");
                if (context.mounted) {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Error'),
                      content: Text('Failed to open store: $e'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.arrow_down_circle_fill,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Update Now',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
