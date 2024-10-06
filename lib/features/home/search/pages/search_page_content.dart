import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manul/features/home/search/cubit/search_cubit.dart';
import 'package:manul/models/service_model.dart';
import 'package:manul/repository/service_repository.dart';

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({
    super.key,
  });

  //final ServiceModel serviceModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(ServiceRepository())..start(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Text(
                'Wystąpił nieoczekiwany problem: ${state.errorMessage}');
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final serviceModels = state.services;
          return ListView(
            children: [
              for (final serviceModel in serviceModels) ...[
                Dismissible(
                  key: ValueKey(serviceModel.id),
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
                        .read<SearchCubit>()
                        .remove(documentID: serviceModel.id);
                  },
                  child: _ListViewItem(
                    serviceModel: serviceModel,
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
  const _ListViewItem({Key? key, required this.serviceModel}) : super(key: key);

  final ServiceModel serviceModel;

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
              Text(serviceModel.title),
              Text(serviceModel.company),
            ],
          ),
          Row(
            children: [
              Text(serviceModel.prize),
              const Text('zł'),
            ],
          )
        ],
      ),
    );
  }
}
