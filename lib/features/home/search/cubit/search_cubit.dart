import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
      : super(const SearchState(
          documents: [],
          isLoading: false,
          errorMessage: '',
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const SearchState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('services')
        .orderBy('prize')
        .snapshots()
        .listen((data) {
      emit(
        SearchState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          SearchState(
            documents: [],
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
        documents: [],
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
