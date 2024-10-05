import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_services_state.dart';

class AddServicesCubit extends Cubit<AddServicesState> {
  AddServicesCubit() : super(const AddServicesState());

  Future<void> add(
    String title,
    String company,
    String prize,
    String maxPrize,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('services').add(
        {
          'title': title,
          'company': company,
          'prize': prize,
          'max_prize': maxPrize,
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
