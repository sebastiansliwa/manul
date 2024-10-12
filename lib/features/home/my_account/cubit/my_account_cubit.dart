import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:manul/models/company_model.dart';
import 'package:manul/repository/company_repository.dart';
import 'package:meta/meta.dart';

part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit(this._companyRepository) : super(const MyAccountState());

  final CompanyRepository _companyRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _companyRepository.getCompaniesStream().listen(
      (companies) {
        emit(MyAccountState(companies: companies));
      },
    )..onError((error) {
        emit(
          MyAccountState(
            companies: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

//przenieść
  Future<void> removeCompany({required String documentID}) async {
    try {
      await _companyRepository.deleteCompany(id: documentID);
    } catch (error) {
      emit(MyAccountState(
        companies: const [],
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
