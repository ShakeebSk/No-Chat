import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchButton extends ConsumerStatefulWidget {
  final TabController tabController;
  final Widget child;
  final Function(String) onSearchChanged;
  final VoidCallback onSearchToggle;
  final bool isSearching;

  const SearchButton({
    super.key,
    required this.tabController,
    required this.child,
    required this.onSearchChanged,
    required this.onSearchToggle,
    required this.isSearching,
  });

  @override
  ConsumerState<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends ConsumerState<SearchButton> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      widget.onSearchChanged(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          scrolledUnderElevation: 0,
          title:
              widget.isSearching
                  ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search chats, groups or contacts...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey[400]),
                    ),
                    style: const TextStyle(color: Colors.white),
                  )
                  : const Text(
                    'NoChat',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          actions: [
            IconButton(
              onPressed: widget.onSearchToggle,
              icon: Icon(
                widget.isSearching ? Icons.close : Icons.search,
                color: Colors.grey,
              ),
            ),
            if (!widget.isSearching)
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(child: Text('Create Group')),
                    ],
              ),
          ],
          bottom:
              widget.isSearching
                  ? null
                  : TabBar(
                    controller: widget.tabController,
                    indicatorColor: Colors.teal,
                    indicatorWeight: 4,
                    labelColor: Colors.teal,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'CHATS'),
                      Tab(text: 'STATUS'),
                      Tab(text: 'CALLS'),
                    ],
                  ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
