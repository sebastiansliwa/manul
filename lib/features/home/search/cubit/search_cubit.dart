import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manul/models/service_model.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const SearchState(
        services: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('services')
        .orderBy('prize')
        .snapshots()
        .listen(
      (services) {
        final serviceModels = services.docs.map((doc) {
          return ServiceModel(
            id: doc.id,
            title: doc['title'],
            company: doc['company'],
            prize: doc['prize'],
            maxPrize: doc['maxprize'],
          );
        }).toList();
        emit(SearchState(services: serviceModels));
      },
    )..onError((error) {
        emit(
          SearchState(
            services: [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

//przenieść
  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('services')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(SearchState(
        services: [],
        isLoading: false,
        errorMessage: error.toString(),
      ));
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
