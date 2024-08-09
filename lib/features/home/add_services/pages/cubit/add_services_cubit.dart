import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_services_state.dart';

class AddServicesCubit extends Cubit<AddServicesState> {
  AddServicesCubit() : super(const AddServicesState());

  Future<void> add(
    String service,
    String company,
    String prize,
    String maxprize,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('services').add(
        {
          'service': service,
          'company': company,
          'prize': prize,
          'maxprize': maxprize,
        },
      );
      emit(const AddServicesState(saved: true));
    } catch (error) {
      emit(AddServicesState(
        errorMessage: error.toString(),
      ));
    }
  }
}
