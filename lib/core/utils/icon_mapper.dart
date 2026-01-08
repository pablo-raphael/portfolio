import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/theme/app_colors.dart';

IconData mapSkillIcon(String key) {
  switch (key) {
    case 'python':
      return FontAwesomeIcons.python;
    case 'flutter':
      return FontAwesomeIcons.flutter;
    case 'dart':
      return FontAwesomeIcons.dartLang;
    case 'android':
      return FontAwesomeIcons.android;
    case 'code':
      return FontAwesomeIcons.code;
    case 'codeBranch':
      return FontAwesomeIcons.codeBranch;
    case 'ubuntu':
      return FontAwesomeIcons.ubuntu;
    case 'linux':
      return FontAwesomeIcons.linux;
    case 'gitAlt':
      return FontAwesomeIcons.gitAlt;
    case 'github':
      return FontAwesomeIcons.github;
    case 'firebase':
      return FontAwesomeIcons.fire;
    case 'googlePlay':
      return FontAwesomeIcons.googlePlay;
    case 'apple':
      return FontAwesomeIcons.apple;
    case 'server':
      return FontAwesomeIcons.server;
    case 'database':
      return FontAwesomeIcons.database;
    case 'html5':
      return FontAwesomeIcons.html5;
    case 'js':
      return FontAwesomeIcons.js;
    case 'layerGroup':
      return FontAwesomeIcons.layerGroup;
    case 'flask':
      return FontAwesomeIcons.flask;
    case 'shapes':
      return FontAwesomeIcons.shapes;
    case 'kotlin':
      return FontAwesomeIcons.code;
    case 'gopher':
      return FontAwesomeIcons.golang;
    case 'xcode':
      return FontAwesomeIcons.laptopCode;
    case 'fileLines':
      return FontAwesomeIcons.fileLines;
    case 'aws':
      return FontAwesomeIcons.aws;
    case 'dotCircle':
      return Icons.circle;
    default:
      return Icons.extension;
  }
}

Color mapSkillColor(String key) {
  switch (key) {
    case 'python':
      return const Color(0xFF3776AB);
    case 'flutter':
      return const Color(0xFF53C5F6);
    case 'dart':
      return const Color(0xFF0175C2);
    case 'android':
      return const Color(0xFF3DDC84);
    case 'code':
      return const Color(0xFF4A5568);
    case 'codeBranch':
      return const Color(0xFF2D7FF9);
    case 'ubuntu':
      return const Color(0xFFE95420);
    case 'linux':
      return const Color(0xFFFCC624);
    case 'gitAlt':
      return const Color(0xFFF05133);
    case 'github':
      return const Color(0xFF181717);
    case 'firebase':
      return const Color(0xFFFFCA28);
    case 'googlePlay':
      return const Color(0xFF34A853);
    case 'apple':
      return const Color(0xFFB1B1B1);
    case 'server':
      return const Color(0xFF6C63FF);
    case 'database':
      return const Color(0xFF3FA037);
    case 'html5':
      return const Color(0xFFE44D26);
    case 'js':
      return const Color(0xFFF7DF1E);
    case 'layerGroup':
      return const Color(0xFF00BFFF);
    case 'dotCircle':
      return const Color(0xFF7C4DFF);
    case 'flask':
      return const Color(0xFFEDEDED);
    case 'shapes':
      return const Color(0xFF9B51E0);
    case 'kotlin':
      return const Color(0xFF7F52FF);
    case 'gopher':
      return const Color(0xFF00ADD8);
    case 'xcode':
      return const Color(0xFF0A84FF);
    case 'fileLines':
      return const Color(0xFF94A3B8);
    case 'aws':
      return const Color(0xFFFF9900);
    default:
      return AppColors.accent;
  }
}

IconData mapSocialIcon(String key) {
  switch (key) {
    case 'facebook':
      return FontAwesomeIcons.facebook;
    case 'twitter':
      return FontAwesomeIcons.twitter;
    case 'linkedin':
      return FontAwesomeIcons.linkedin;
    case 'instagram':
      return FontAwesomeIcons.instagram;
    case 'github':
      return FontAwesomeIcons.github;
    case 'whatsapp':
      return FontAwesomeIcons.whatsapp;
    default:
      return FontAwesomeIcons.link;
  }
}

IconData mapContactMethodIcon(String type) {
  switch (type) {
    case 'email':
      return Icons.email_outlined;
    case 'phone':
      return Icons.phone;
    case 'whatsapp':
      return FontAwesomeIcons.whatsapp;
    case 'location':
      return Icons.location_on_outlined;
    default:
      return Icons.info_outline;
  }
}
