import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/models/content_parsing.dart';

Uri? parseExternalUrl(String? raw) {
  final value = raw?.trim();
  if (value == null || value.isEmpty || value == missingTextPlaceholder) {
    return null;
  }

  final parsed = Uri.tryParse(value);
  if (parsed == null) {
    return null;
  }

  if (parsed.scheme.isEmpty) {
    return Uri.tryParse('https://$value');
  }

  return parsed;
}

Uri? buildEmailUri(String email) {
  final value = email.trim();
  if (value.isEmpty || value == missingTextPlaceholder) {
    return null;
  }
  return Uri(scheme: 'mailto', path: value);
}

Uri? buildPhoneUri(String phone) {
  final value = phone.trim();
  if (value.isEmpty || value == missingTextPlaceholder) {
    return null;
  }
  return Uri(scheme: 'tel', path: value);
}

Uri? buildWhatsAppUri(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty || trimmed == missingTextPlaceholder) {
    return null;
  }

  if (trimmed.startsWith('http')) {
    return parseExternalUrl(trimmed);
  }

  final digits = trimmed.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) {
    return null;
  }

  return Uri.parse('https://wa.me/$digits');
}

Uri? buildMapsUri(String location) {
  final value = location.trim();
  if (value.isEmpty || value == missingTextPlaceholder) {
    return null;
  }

  return Uri.https('www.google.com', '/maps/search/', <String, String>{
    'api': '1',
    'query': value,
  });
}

Future<bool> launchExternalUri(Uri? uri) async {
  if (uri == null) {
    return false;
  }

  return launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
    webOnlyWindowName: '_blank',
  );
}
