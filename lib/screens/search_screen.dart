import 'package:flutter/material.dart';

import 'package:todo/screens/pending_tasks_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchResults = []; // Example list of search results

  void _performSearch(String query) {
    // Example: Perform search operation
    // Replace this with your actual search logic
    setState(() {
      _searchResults.clear(); // Clear previous results
      if (query.isNotEmpty) {
        // Example: Search logic (replace with your actual search logic)
        const PendingTasksScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                _performSearch(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                  // Add more details or functionality as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
