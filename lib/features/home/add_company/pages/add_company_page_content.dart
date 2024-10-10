import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manul/features/home/add_company/pages/cubit/add_company_cubit.dart';
import 'package:manul/repository/company_repository.dart';

class AddCompanyPageContent extends StatefulWidget {
  const AddCompanyPageContent({
    super.key,
  });

  @override
  State<AddCompanyPageContent> createState() => _AddCompanyPageContentState();
}

class _AddCompanyPageContentState extends State<AddCompanyPageContent> {
  String? _businessName;
  String? _webside;
  String? _location;
  String? _city;
  String? _district;
  bool isdistrickt = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCompanyCubit(CompanyRepository()),
      child: BlocListener<AddCompanyCubit, AddCompanyState>(
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
        child: BlocBuilder<AddCompanyCubit, AddCompanyState>(
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
                    hintText: 'Nazwa firmy',
                    label: Row(
                      children: const [
                        Text('Podaj nazwę firmy'),
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
                      _businessName = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Strona www',
                    label: Row(
                      children: const [
                        Text('Podaj stronę internetową'),
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
                      _webside = newValue;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Lokalizacja',
                    ),
                    Switch(
                      value: isdistrickt,
                      onChanged: (newValue) {
                        setState(() {
                          isdistrickt = newValue;
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
                          hintText: 'np.: Warszawa',
                          label: Row(
                            children: const [
                              Text('Podaj miasto'),
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
                            _city = newValue;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: isdistrickt,
                      child: const Text('-'),
                    ),
                    Visibility(
                      visible: isdistrickt,
                      child: SizedBox(
                        width: 150,
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'np. Bielany',
                            label: Text('Podaj dzielnicę'),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _district = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Strona www',
                    label: Row(
                      children: const [
                        Text('Podaj link do lokalizacji'),
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
                      _location = newValue;
                    });
                  },
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
                      _businessName == null || _webside == null || _city == null
                          ? null
                          : () {
                              context.read<AddCompanyCubit>().add(
                                    _businessName!,
                                    _webside!,
                                    _location!,
                                    _city!,
                                    _district ?? '',
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
