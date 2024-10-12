part of 'my_account_cubit.dart';

@immutable
class MyAccountState {
  const MyAccountState({
    this.companies = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });
  final List<CompanyModel> companies;
  final bool isLoading;
  final String errorMessage;
}
