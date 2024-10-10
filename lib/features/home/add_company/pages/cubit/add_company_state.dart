part of 'add_company_cubit.dart';

class AddCompanyState {
  const AddCompanyState({
    this.saved = false,
    this.errorMessage = '',
  });
  final bool saved;
  final String errorMessage;
}
