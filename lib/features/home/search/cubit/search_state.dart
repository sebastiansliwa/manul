part of 'search_cubit.dart';

@immutable
class SearchState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMessage;

  const SearchState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
