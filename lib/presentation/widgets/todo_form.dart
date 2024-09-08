import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/presentation/widgets/network_status_widget.dart';

class TodoForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final Function(String, String) onSubmit;

  const TodoForm({
    super.key,
    this.initialTitle,
    this.initialDescription,
    required this.onSubmit,
  });

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
                labelText: (AppLocalizations.of(context).title)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
                labelText: (AppLocalizations.of(context).description)),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          
          ElevatedButton(
            onPressed: () {
              widget.onSubmit(
                _titleController.text,
                _descriptionController.text,
              );
            },
            child: Text(AppLocalizations.of(context).save),
          ),
        ],
      ),
    );
  }
}
