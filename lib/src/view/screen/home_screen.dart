import 'package:flutter/material.dart';
import 'package:rest_api_demo/src/service/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final jobController = TextEditingController();

  String? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        children: [
          /// Fields
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) => value == null || value == ''
                        ? 'Add name properly'
                        : null,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      filled: true,
                    ),
                  ),
                ),
                TextFormField(
                  controller: jobController,
                  validator: (value) =>
                      value == null || value == '' ? 'Add job properly' : null,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    label: Text('Job'),
                    filled: true,
                  ),
                ),
              ],
            ),
          ),

          /// Buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final service = MyService();

                    final _result = await service.fetchUsers();

                    result = _result.toString();

                    setState(() {});
                  },
                  child: const Text('GET'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      final service = MyService();

                      final _result = await service.createUser(
                        name: nameController.text.trim(),
                        job: jobController.text.trim(),
                      );

                      result = _result.toString();

                      setState(() {});
                    }
                  },
                  child: const Text('POST'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      final service = MyService();

                      final _result = await service.updateUser(
                        name: nameController.text.trim(),
                        job: jobController.text.trim(),
                      );

                      result = _result.toString();

                      setState(() {});
                    }
                  },
                  child: const Text('PUT'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final service = MyService();

                    final _result = await service.deleteUser();

                    result = _result.toString();
                    
                    setState(() {});
                  },
                  child: const Text('DELETE'),
                ),
              ],
            ),
          ),

          /// Text (Result)
          const Text(
            'Result',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text((result ?? '-').toString()),
        ],
      ),
    );
  }
}
