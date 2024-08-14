import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';

class RetseptList extends StatelessWidget {
  const RetseptList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RetseptBloc, RetseptState>(
      builder: (context, state) {
        if (state is RetseptLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RetseptLoaded) {
          return ListView.builder(
            itemCount: state.retsepts.length,
            itemBuilder: (context, index) {
              final retsept = state.retsepts[index];
              return ListTile(
                title: Text(retsept['name'] ?? 'Unknown'),
                subtitle: Text(retsept['description'] ?? 'No description'),
              );
            },
          );
        } else if (state is RetseptError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
