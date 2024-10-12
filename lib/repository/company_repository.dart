import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manul/models/company_model.dart';

class CompanyRepository {
  Stream<List<CompanyModel>> getCompaniesStream() {
    return FirebaseFirestore.instance
        .collection('company')
        //.orderBy('prize')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return CompanyModel(
            id: doc.id,
            businessName: doc['business_name'],
            webside: doc['webside'],
            location: doc['location'],
            city: doc['city'],
            district: doc['district'],
          );
        },
      ).toList();
    });
  }

  Future<void> deleteCompany({required String id}) {
    return FirebaseFirestore.instance.collection('company').doc(id).delete();
  }

  Future<void> addCompany(
    String businessName,
    String webside,
    String location,
    String city,
    String district,
  ) async {
    await FirebaseFirestore.instance.collection('company').add({
      'business_name': businessName,
      'webside': webside,
      'location': location,
      'city': city,
      'district': district,
    });
  }
}
