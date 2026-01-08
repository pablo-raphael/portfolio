import 'package:portfolio/models/about_content.dart';
import 'package:portfolio/models/contact_content.dart';
import 'package:portfolio/models/content_parsing.dart';
import 'package:portfolio/models/experience_content.dart';
import 'package:portfolio/models/footer_content.dart';
import 'package:portfolio/models/header_content.dart';
import 'package:portfolio/models/hero_content.dart';
import 'package:portfolio/models/portfolio_content.dart';
import 'package:portfolio/models/skills_content.dart';
import 'package:portfolio/models/testimonials_content.dart';

class SiteContent {
  const SiteContent({
    required this.header,
    required this.hero,
    required this.about,
    required this.skills,
    required this.portfolio,
    required this.experience,
    required this.testimonials,
    required this.contact,
    required this.footer,
  });

  final HeaderContent header;
  final HeroContent hero;
  final AboutContent about;
  final SkillsContent skills;
  final PortfolioContent portfolio;
  final ExperienceContent experience;
  final TestimonialsContent testimonials;
  final ContactContent contact;
  final FooterContent footer;

  factory SiteContent.fromJson(Map<String, dynamic> json) {
    return SiteContent(
      header: HeaderContent.fromJson(readMap(json['header'])),
      hero: HeroContent.fromJson(readMap(json['hero'])),
      about: AboutContent.fromJson(readMap(json['about'])),
      skills: SkillsContent.fromJson(readMap(json['skills'])),
      portfolio: PortfolioContent.fromJson(readMap(json['portfolio'])),
      experience: ExperienceContent.fromJson(readMap(json['experience'])),
      testimonials: TestimonialsContent.fromJson(readMap(json['testimonials'])),
      contact: ContactContent.fromJson(readMap(json['contact'])),
      footer: FooterContent.fromJson(readMap(json['footer'])),
    );
  }
}
