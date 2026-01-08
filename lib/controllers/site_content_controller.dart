import 'package:flutter/material.dart';
import 'package:portfolio/models/site_content.dart';
import 'package:portfolio/services/site_content_service.dart';

class SiteContentController extends ChangeNotifier {
  SiteContentController({SiteContentService? service})
    : _service = service ?? SiteContentService();

  static const Locale _primaryLocale = Locale('pt', 'BR');
  static const Locale _fallbackLocale = Locale('en', 'US');

  final SiteContentService _service;

  SiteContent? _content;
  Locale _locale = _primaryLocale;
  final Map<String, SiteContent> _cache = {};
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;

  SiteContent? get content => _content;

  Locale get locale => _locale;

  bool get isEnglish => _locale.languageCode == 'en';

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  String? get errorMessage => _errorMessage;

  Future<void> loadInitial() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    final primaryContent = await _tryFetch(_primaryLocale);
    if (primaryContent != null) {
      _content = primaryContent;
      _locale = _primaryLocale;
      _isLoading = false;
      notifyListeners();
      return;
    }

    final fallbackContent = await _tryFetch(_fallbackLocale);
    if (fallbackContent != null) {
      _content = fallbackContent;
      _locale = _fallbackLocale;
      _isLoading = false;
      notifyListeners();
      return;
    }

    _content = null;
    _isLoading = false;
    _hasError = true;
    _errorMessage = 'Unable to load the content. Please try again.';
    notifyListeners();
  }

  Future<bool> switchLocale(Locale targetLocale) async {
    if (_isLoading) {
      return false;
    }

    final previousContent = _content;
    final previousLocale = _locale;

    _isLoading = true;
    _hasError = false;
    _errorMessage = null;
    notifyListeners();

    final nextContent = await _tryFetch(targetLocale);
    if (nextContent != null) {
      _content = nextContent;
      _locale = targetLocale;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _content = previousContent;
    _locale = previousLocale;
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<SiteContent?> _tryFetch(Locale locale) async {
    final localeId = _localeId(locale);
    final cached = _cache[localeId];
    if (cached != null) {
      return cached;
    }
    try {
      final content = await _service.fetchContent(localeId);
      _cache[localeId] = content;
      return content;
    } catch (_) {
      return null;
    }
  }

  String _localeId(Locale locale) {
    final country = locale.countryCode;
    if (country == null || country.isEmpty) {
      return locale.languageCode;
    }
    return '${locale.languageCode}-$country';
  }
}
