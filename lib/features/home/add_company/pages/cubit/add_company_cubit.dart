import 'package:bloc/bloc.dart';
import 'package:manul/repository/company_repository.dart';

part 'add_company_state.dart';

class AddCompanyCubit extends Cubit<AddCompanyState> {
  AddCompanyCubit(this._companyRepository) : super(const AddCompanyState());

  final CompanyRepository _companyRepository;

  Future<void> add(
    String businessName,
    String webside,
    String location,
    String city,
    String district,
  ) async {
    try {
      await _companyRepository.add(
          businessName, webside, location, city, district);
      emit(const AddCompanyState(saved: true));
    } catch (error) {
      emit(AddCompanyState(
        errorMessage: error.toString(),
      ));
    }
  }
}
