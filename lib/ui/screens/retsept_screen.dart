import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_bloc.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_event.dart';
import 'package:retsept_cherno/bloc/retsept/retsept_state.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/services/firestore/retsept_firestore.dart';

class RetseptScreen extends StatelessWidget {
  const RetseptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retsepts'),
      ),
      body: BlocProvider(
        create: (context) =>
            RetseptBloc(RetseptFirestore())..add(StreamRetseptsEvent()),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<RetseptBloc, RetseptState>(
                builder: (context, state) {
                  if (state is RetseptLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RetseptLoaded) {
                    final retsepts = state.retsepts;
                    return ListView.builder(
                      itemCount: retsepts.length,
                      itemBuilder: (context, index) {
                        final retsept = retsepts[index];
                        return ListTile(
                          title: Text(retsept['name']),
                          subtitle: Text(retsept['category']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Dispatch a delete event
                              context
                                  .read<RetseptBloc>()
                                  .add(DeleteRetseptEvent(retsept['id']));
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is RetseptError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const Center(child: Text('No data available'));
                },
              ),
            ),
            const AddRetseptForm(), // Added form here
          ],
        ),
      ),
    );
  }
}

class AddRetseptForm extends StatefulWidget {
  const AddRetseptForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRetseptFormState createState() => _AddRetseptFormState();
}

class _AddRetseptFormState extends State<AddRetseptForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  // Add other controllers as needed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            // Add other fields similarly
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final newRetsept = RetseptModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _nameController.text,
                    category: _categoryController.text,
                    ingredients: [], // Populate based on your form
                    preparation: [], // Populate based on your form
                    coments: [],
                    likes: 10,
                    image: '',
                    video: '',
                  );
                  context.read<RetseptBloc>().add(AddRetseptEvent(newRetsept));
                }
              },
              child: const Text('Add Retsept'),
            ),
          ],
        ),
      ),
    );
  }
}
