import 'package:bloc/bloc.dart';
import 'package:manul/repository/service_repository.dart';

part 'add_services_state.dart';

class AddServicesCubit extends Cubit<AddServicesState> {
  AddServicesCubit(this._serviceRepository) : super(const AddServicesState());

  final ServiceRepository _serviceRepository;

  Future<void> add(
    String title,
    String company,
    String prize,
    String maxPrize,
  ) async {
    try {
      await _serviceRepository.add(title, company, prize, maxPrize);
      emit(const AddServicesState(saved: true));
    } catch (error) {
      emit(AddServicesState(
        errorMessage: error.toString(),
      ));
    }
  }
}
