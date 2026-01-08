import 'package:flutter/material.dart';
import 'package:portfolio/controllers/site_content_controller.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/core/design_system/app_opacity.dart';
import 'package:portfolio/core/design_system/app_spacing.dart';
import 'package:portfolio/core/theme/app_colors.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/ui/home/home_page.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  late final SiteContentController _contentController;
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool get _isEnglish => _contentController.isEnglish;

  @override
  void initState() {
    super.initState();
    AppColors.setMode(_themeMode);
    _contentController = SiteContentController();
    _contentController.loadInitial();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
      AppColors.setMode(_themeMode);
    });
  }

  Future<bool> _toggleLanguage() async {
    final targetLocale = _isEnglish
        ? const Locale('pt', 'BR')
        : const Locale('en', 'US');
    return _contentController.switchLocale(targetLocale);
  }

  Future<void> _handleToggleLanguage() async {
    final success = await _toggleLanguage();
    if (!success) {
      _messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text(
            'Unable to load the language. Keeping current content.',
          ),
          duration: AppDurations.snackbar,
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _contentController,
      builder: (context, _) {
        final content = _contentController.content;
        final isLoading = _contentController.isLoading;
        final hasError = _contentController.hasError;
        final errorMessage = _contentController.errorMessage;

        Widget home;
        if (content == null) {
          if (hasError) {
            home = _ErrorScreen(
              message: errorMessage ?? 'Unable to load the content.',
              onRetry: () {
                _contentController.loadInitial();
              },
            );
          } else {
            home = const _LoadingScreen();
          }
        } else {
          home = HomePage(
            themeMode: _themeMode,
            onToggleTheme: _toggleTheme,
            isEnglish: _isEnglish,
            onToggleLanguage: _handleToggleLanguage,
            content: content,
          );

          if (isLoading) {
            home = Stack(
              children: [
                home,
                const Positioned.fill(child: _BlockingLoadingOverlay()),
              ],
            );
          }
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: content?.hero.name == null
              ? null
              : '${content!.hero.name} - Portfolio',
          scaffoldMessengerKey: _messengerKey,
          theme: AppTheme.build(
            palette: AppPalette.light,
            brightness: Brightness.light,
          ),
          darkTheme: AppTheme.build(
            palette: AppPalette.dark,
            brightness: Brightness.dark,
          ),
          themeMode: _themeMode,
          home: home,
        );
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BlockingLoadingOverlay extends StatelessWidget {
  const _BlockingLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        color: Colors.black.withValues(alpha: AppOpacity.alpha35),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
