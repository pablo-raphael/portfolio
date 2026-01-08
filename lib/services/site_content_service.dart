import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/models/site_content.dart';

class SiteContentService {
  SiteContentService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<SiteContent> fetchContent(String localeId) async {
    final snapshot = await _firestore
        .collection('siteContent')
        .doc(localeId)
        .get();
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Missing document for locale: $localeId');
    }
    return SiteContent.fromJson(data);
  }
}
