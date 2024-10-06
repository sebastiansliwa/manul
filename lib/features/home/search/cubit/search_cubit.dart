import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:manul/models/service_model.dart';
import 'package:manul/repository/service_repository.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._serviceRepository) : super(const SearchState());

  final ServiceRepository _serviceRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    // emit(
    //   const SearchState(
    //     services: [],
    //     isLoading: true,
    //     errorMessage: '',
    //   ),
    // );

    _streamSubscription = _serviceRepository.getServicesStream().listen(
      (services) {
        emit(SearchState(services: services));
      },
    )..onError((error) {
        emit(
          SearchState(
            services: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

//przenieść
  Future<void> remove({required String documentID}) async {
    try {
      await _serviceRepository.delete(id: documentID);
    } catch (error) {
      emit(SearchState(
        services: const [],
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
