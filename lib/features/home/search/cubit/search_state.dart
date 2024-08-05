part of 'search_cubit.dart';

@immutable
class SearchState {
  final List<QueryDocumentSnapshot<Object?>> documents;

  SearchState({required this.documents});
}
