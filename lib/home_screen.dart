import 'package:flutter/material.dart';
import 'package:notes_app/add_update_notes_screen.dart';
import 'package:notes_app/notes_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, child) {
        List<Map<String, dynamic>> allData = notesProvider.getNotes();

        return Scaffold(
          backgroundColor: const Color(0xFFECEAF4),
          appBar: AppBar(
            title: const Text(
              'Notes App',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: allData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(
                            right: 5, left: 0, bottom: 2, top: 5),
                        child: Text(
                          allData[index]['title'],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(
                            right: 5, left: 0, bottom: 2, top: 5),
                        child: Text(allData[index]['desc']),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddUpdateNotesScreen(
                                    isUpdate: true,
                                    id: allData[index]['id'],
                                    title: allData[index]['title'],
                                    description: allData[index]['desc'],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.indigo),
                          ),
                          IconButton(
                            onPressed: () {
                              notesProvider.deletedata(allData[index]['id']);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  margin: EdgeInsets.all(15),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 3),
                                  content: Text('Note Deleted'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddUpdateNotesScreen()));
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
