import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manul/models/service_model.dart';

class ServiceRepository {
  Stream<List<ServiceModel>> getServicesStream() {
    return FirebaseFirestore.instance
        .collection('services')
        .orderBy('prize')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ServiceModel(
            id: doc.id,
            title: doc['title'],
            company: doc['company'],
            prize: doc['prize'],
            maxPrize: doc['max_prize'],
          );
        },
      ).toList();
    });
  }


 Future<void> delete({required String id }) {
  return FirebaseFirestore.instance
          .collection('services')
          .doc(id)
          .delete();
 } 

 Future<void> add(
    String title,
    String company,
    String prize,
    String maxPrize,
  ) async {
      await FirebaseFirestore.instance.collection('services').add(
        {
          'title': title,
          'company': company,
          'prize': prize,
          'max_prize': maxPrize,
        }
      );
  }
}
