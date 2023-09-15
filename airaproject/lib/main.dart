// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tile View App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TileViewScreen(),
    );
  }
}

class TileViewScreen extends StatefulWidget {
  const TileViewScreen({Key? key}) : super(key: key);

  @override
  _TileViewScreenState createState() => _TileViewScreenState();
}

class _TileViewScreenState extends State<TileViewScreen> {
  String selectedName = '';
  bool showDetails = false;

  final List<Map<String, dynamic>> data = [
    {
      'name': 'E L E P A N T E',
      'image': 'assets/elephant.png',
      'description':
          'Elephants are the largest land mammals on earth and have distinctly massive bodies, large ears, and long trunks. They use their trunks to pick up objects, trumpet warnings, greet other elephants, or suck up water for drinking or bathing, among other uses.',
    },
    {
      'name': 'B A B O Y',
      'image': 'assets/pig.png',
      'description':
          'Pigs are stout-bodied, short-legged, omnivorous mammals, with thick skin usually sparsely coated with short bristles. Their hooves have two functional and two nonfunctional digits. Domestic North American pigs originated from wild stocks still found in European, Asian, and North African forests.',
    },
    {
      'name': 'T I G R E',
      'image': 'assets/tiger.png',
      'description':
          'Tigers have reddish-orange coats with prominent black stripes, white bellies and white spots on their ears. Like a human fingerprint, no two tigers have the exact same markings. Because of this, researchers can use stripe patterns to identify different individuals when studying tigers in the wild.',
    },
  ];

  Widget buildDetailsView() {
    final selectedItem =
        data.firstWhere((element) => element['name'] == selectedName);

    return Column(
      children: [
        Image.asset(
          selectedItem['image'],
          height: 200,
        ),
        Text(
          selectedName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            selectedItem['description'],
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildGridView() {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4, // Adjust this value to control the number of columns
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          setState(() {
            selectedName = data[index]['name'];
            showDetails = true;
          });
        },
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                data[index]['image'],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Text(data[index]['name']),
            ],
          ),
        ),
      ),
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(1, 2), // Adjust this value for tile size
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A N I M A L   A P P'),
      ),
      body: showDetails ? buildDetailsView() : buildGridView(),
      floatingActionButton: showDetails
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  showDetails = false;
                });
              },
              child: const Icon(Icons.arrow_back),
            )
          : null,
    );
  }
}
