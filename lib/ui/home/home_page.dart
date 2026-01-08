import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/app_durations.dart';
import 'package:portfolio/models/site_content.dart';
import 'package:portfolio/ui/home/sections/about_section.dart';
import 'package:portfolio/ui/home/sections/contact_section.dart';
import 'package:portfolio/ui/home/sections/experience_section.dart';
import 'package:portfolio/ui/home/sections/footer_section.dart';
import 'package:portfolio/ui/home/sections/hero_section.dart';
import 'package:portfolio/ui/home/sections/portfolio_section.dart';
import 'package:portfolio/ui/home/sections/skills_section.dart';
import 'package:portfolio/ui/home/sections/testimonial_section.dart';
import 'package:portfolio/ui/home/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
    required this.isEnglish,
    required this.onToggleLanguage,
    required this.content,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final bool isEnglish;
  final Future<void> Function() onToggleLanguage;
  final SiteContent content;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, GlobalKey> _sectionKeys = {
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'portfolio': GlobalKey(),
    'experience': GlobalKey(),
    'testimonials': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollToSection(String targetId) {
    final key = _sectionKeys[targetId];
    final context = key?.currentContext;
    if (context == null) {
      return;
    }
    Scrollable.ensureVisible(
      context,
      duration: AppDurations.scroll,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        themeMode: widget.themeMode,
        onToggleTheme: widget.onToggleTheme,
        isEnglish: widget.isEnglish,
        onToggleLanguage: widget.onToggleLanguage,
        anchors: widget.content.header.anchors,
        onAnchorTap: _scrollToSection,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              content: widget.content.hero,
              socialLinks: widget.content.contact.socialLinks,
              onContactTap: () => _scrollToSection('contact'),
            ),
            _wrapSection('about', AboutSection(content: widget.content.about)),
            _wrapSection(
              'skills',
              SkillsSection(content: widget.content.skills),
            ),
            _wrapSection(
              'portfolio',
              PortfolioSection(content: widget.content.portfolio),
            ),
            _wrapSection(
              'experience',
              ExperienceSection(content: widget.content.experience),
            ),
            _wrapSection(
              'testimonials',
              TestimonialSection(content: widget.content.testimonials),
            ),
            _wrapSection(
              'contact',
              ContactSection(content: widget.content.contact),
            ),
            FooterSection(content: widget.content.footer),
          ],
        ),
      ),
    );
  }

  Widget _wrapSection(String id, Widget child) {
    final key = _sectionKeys[id];
    if (key == null) {
      return child;
    }
    return KeyedSubtree(key: key, child: child);
  }
}
