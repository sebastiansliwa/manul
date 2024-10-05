part of 'search_cubit.dart';

@immutable
class SearchState {
  const SearchState({
    this.services = const [],
     this.isLoading = false,
     this.errorMessage = '',
  });
  final List<ServiceModel> services;
  final bool isLoading;
  final String errorMessage;
}
