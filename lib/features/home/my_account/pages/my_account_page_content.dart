import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manul/features/home/my_account/cubit/my_account_cubit.dart';
import 'package:manul/models/company_model.dart';
import 'package:manul/repository/company_repository.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAccountCubit(CompanyRepository())..start(),
      child: BlocBuilder<MyAccountCubit, MyAccountState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Text(
                'Wystąpił nieoczekiwany problem: ${state.errorMessage}');
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final companyModels = state.companies;
          return ListView(
            children: [
              for (final companyModel in companyModels) ...[
                Dismissible(
                  key: ValueKey(companyModel.id),
                  background: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 32.0),
                        child: Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    // only from right to left
                    return direction == DismissDirection.endToStart;
                  },
                  onDismissed: (direction) {
                    context
                        .read<MyAccountCubit>()
                        .removeCompany(documentID: companyModel.id);
                  },
                  child: _ListViewItem(
                    companyModel: companyModel,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({Key? key, required this.companyModel}) : super(key: key);

  final CompanyModel companyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: const Color.fromARGB(255, 92, 95, 93),
      padding: const EdgeInsets.only(
        right: 20,
      ),
      margin: const EdgeInsets.only(
        top: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(companyModel.businessName),
              Text(companyModel.city),
            ],
          ),
          Row(
            children: [
              Text(companyModel.district),
            ],
          )
        ],
      ),
    );
  }
}
