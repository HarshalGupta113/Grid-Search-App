import 'package:flutter/material.dart';

class GridDisplayScreen extends StatefulWidget {
  final int rows;
  final int columns;
  final String letters;

  GridDisplayScreen({
    required this.rows,
    required this.columns,
    required this.letters,
  });

  @override
  State<GridDisplayScreen> createState() => _GridDisplayScreenState();
}

class _GridDisplayScreenState extends State<GridDisplayScreen> {
  List<List<String>> grid = [];
  String searchText = '';
  List<List<bool>> highlights = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    grid = List.generate(
      widget.rows,
      (i) => widget.letters
          .substring(i * widget.columns, (i + 1) * widget.columns)
          .split(''),
    );
    highlights =
        List.generate(widget.rows, (i) => List.filled(widget.columns, false));
  }

  void _searchText() {
    setState(() {
      for (int i = 0; i < widget.rows; i++) {
        for (int j = 0; j < widget.columns; j++) {
          if (_searchFrom(i, j)) return;
        }
      }
    });
  }

  bool _searchFrom(int i, int j) {
    if (grid[i][j] != searchText[0]) return false;

    final directions = [
      [0, 1], // East
      [1, 0], // South
      [1, 1], // South-East
    ];

    for (var dir in directions) {
      int x = i, y = j, index = 0;
      while (index < searchText.length &&
          x < widget.rows &&
          y < widget.columns &&
          grid[x][y] == searchText[index]) {
        x += dir[0];
        y += dir[1];
        index++;
      }

      if (index == searchText.length) {
        _highlightPath(i, j, dir);
        return true;
      }
    }
    return false;
  }

  void _highlightPath(int i, int j, List<int> dir) {
    for (int k = 0; k < searchText.length; k++) {
      highlights[i][j] = true;
      i += dir[0];
      j += dir[1];
    }
  }

  void _reset() {
    setState(() {
      searchText = '';
      searchController.clear();
      _initializeGrid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid Display')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.columns,
              ),
              itemCount: widget.rows * widget.columns,
              itemBuilder: (context, index) {
                int row = index ~/ widget.columns;
                int col = index % widget.columns;
                return Container(
                  margin: const EdgeInsets.all(2),
                  color:
                      highlights[row][col] ? Colors.yellow : Colors.grey[200],
                  child: Center(
                    child: Text(
                      grid[row][col],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  labelText: 'Enter text to search',
                  border: OutlineInputBorder()),
              onChanged: (value) => searchText = value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: _searchText,
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 16),
                  )),
              ElevatedButton(
                  onPressed: _reset,
                  child: const Text(
                    'Reset',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
