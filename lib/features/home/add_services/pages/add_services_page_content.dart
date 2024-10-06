import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manul/features/home/add_services/pages/cubit/add_services_cubit.dart';
import 'package:manul/repository/service_repository.dart';

class AddServicesPageContent extends StatefulWidget {
  const AddServicesPageContent({
    super.key,
  });

  @override
  State<AddServicesPageContent> createState() => _AddServicesPageContentState();
}

class _AddServicesPageContentState extends State<AddServicesPageContent> {
  String? _title;
  String? _company;
  String? _prize;
  String? _maxPrize;
  bool ispricebracket = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServicesCubit(ServiceRepository()),
      child: BlocListener<AddServicesCubit, AddServicesState>(
        listener: (context, state) {
          if (state.saved) {
            // \\ czyszczenie odpowiednich tekstfieldów
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<AddServicesCubit, AddServicesState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Podaj nazwę usługi',
                    label: Row(
                      children: const [
                        Text('Nazwa usługi'),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _title = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Podaj nazwę firmy',
                    label: Row(
                      children: const [
                        Text('Nazwa firmy'),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _company = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Przedział cenowy',
                    ),
                    Switch(
                      value: ispricebracket,
                      onChanged: (newValue) {
                        setState(() {
                          ispricebracket = newValue;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'np.: 50',
                          label: Row(
                            children: [
                              Text(ispricebracket
                                  ? 'Cena min. w zł'
                                  : 'Cena w zł'),
                              const Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            _prize = newValue;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: ispricebracket,
                      child: const Text('-'),
                    ),
                    Visibility(
                      visible: ispricebracket,
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'np. 150',
                            label: Text('Cena max. w zł'),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _maxPrize = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Wymagane pola do odblokowania przycisku "DODAJ".',
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed:
                      _title == null || _company == null || _prize == null
                          ? null
                          : () {
                              context.read<AddServicesCubit>().add(
                                    _title!,
                                    _company!,
                                    _prize!,
                                    _maxPrize ?? '',
                                  );
                            },
                  child: const Text('Dodaj'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
