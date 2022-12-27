import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> mailTo(String mail) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: mail,
  );
  await launchUrl(launchUri);
}

Future<void> directionTo(double lat, double lng) async {
  final Uri launchUri = Uri(
    scheme: 'geo',
    path: "$lat,$lng",
  );
  await launchUrl(launchUri);
}

Future<void> copyToClipboard(String text, {BuildContext? context}) async {
  await Clipboard.setData(ClipboardData(text: text)).then((value) {
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Copied to clipboard")),
      );
    }
  });
}
