import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manul/features/home/search/cubit/search_cubit.dart';

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..start(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Text(
                'Wystąpił nieoczekiwany problem: ${state.errorMessage}');
          }
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = state.documents;
          return ListView(
            children: [
              for (final document in documents) ...[
                Dismissible(
                  key: ValueKey(document.id),
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
                    context.read<SearchCubit>().remove(documentID: document.id);
                  },
                  child: ListViewItem(
                    document['service'],
                    document['company'],
                    document['prize'],
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

class ListViewItem extends StatelessWidget {
  const ListViewItem(
    this.service,
    this.company,
    this.prize, {
    super.key,
  });
  final String service;
  final String company;
  final String prize;
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
              Text(service),
              Text(company),
            ],
          ),
          Row(
            children: [
              Text(prize),
              const Text('zł'),
            ],
          )
        ],
      ),
    );
  }
}
