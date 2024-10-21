import 'package:flutter/material.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

class AddUpdateNotesScreen extends StatelessWidget {
  bool isUpdate;
  int? id;
  String? title;
  String? description;

  AddUpdateNotesScreen(
      {super.key,
      this.isUpdate = false,
      this.id,
      this.title,
      this.description});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      _titleController.text = title!;
      _descController.text = description!;
    }

    return Scaffold(
      appBar: AppBar(
        title: isUpdate ? const Text('Update Note') : const Text('Add Note'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  hintText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  hintText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Consumer<NotesProvider>(
                builder: (context, notesProvider, child) => ElevatedButton(
                  onPressed: () async {
                    if (isUpdate == false) {
                      await notesProvider.addData(
                          _titleController.text, _descController.text);
                      Navigator.pop(context);
                    } else {
                      await notesProvider.updateData(
                          id!, _titleController.text, _descController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      isUpdate ? 'Update' : 'Add',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
