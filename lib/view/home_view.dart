import 'package:count1/core/functions.dart';
import 'package:count1/model/entry_model.dart';
import 'package:count1/wigdets/display_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _titletextEditingController =
      TextEditingController();
  final TextEditingController _valuetextEditingController =
      TextEditingController();

  bool validDataEntered() {
    return _titletextEditingController.text.isNotEmpty &&
        _valuetextEditingController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titletextEditingController.dispose();
    _valuetextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = EntryProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text("Count1"),
        actions: [
          PopupMenuButton(
            itemBuilder:
                (context) => [
                  PopupMenuItem<int>(value: 0, child: Text("Switch Mode")),
                  PopupMenuItem<int>(value: 1, child: Text("About")),
                ],
            onSelected: (item) => selectedButton(context, item),
          ),
        ],
      ),
      body: FutureBuilder<List<EntryModel>>(
        future: provider.getAllEntries(), // Fetch entries from the provider
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No entries found.'));
          } else {
            List<EntryModel> entries = snapshot.data!;

            return ListView.separated(
              cacheExtent: 5,
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return DisplayWidgets(
                  title: entries[index].title,
                  value: entries[index].initialValue,
                );
              },
              separatorBuilder:
                  (BuildContext context, int index) => SizedBox(height: 20),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder:
                (builder) => Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: _titletextEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Title',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _valuetextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Initial value',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (validDataEntered()) {
                            await provider.open();
                            EntryModel newEntry = EntryModel();
                            newEntry.title = _titletextEditingController.text;
                            newEntry.initialValue = int.parse(
                              _valuetextEditingController.text,
                            ); // Convert to int
                            await provider.insert(newEntry);
                            _titletextEditingController
                                .clear(); // Clear the text fields
                            _valuetextEditingController.clear();
                            Navigator.pop(context); // Close the bottom sheet
                            setState(() {}); // Refresh the FutureBuilder
                          } else {
                            // Show an error message if data is invalid
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter valid data.'),
                              ),
                            );
                          }
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
