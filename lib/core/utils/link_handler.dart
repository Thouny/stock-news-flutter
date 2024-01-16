import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class LinkHandler {
  const LinkHandler();

  Future<void> openLink(String link, [BuildContext? context]);
}

class LinkHandlerImpl extends LinkHandler {
  const LinkHandlerImpl({this.urlLauncher = const UrlLauncher()});

  final UrlLauncher urlLauncher;

  @override
  Future<void> openLink(String link, [BuildContext? context]) async {
    final url = Uri.parse(link);
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      throw Exception("Couldn't open link: $link");
    }
  }
}

class UrlLauncher {
  const UrlLauncher();

  Future<bool> canLaunch(Uri url) async {
    return canLaunchUrl(url);
  }

  Future<bool> launch(Uri url) async {
    return launchUrl(url);
  }
}
