import 'package:flutter/material.dart';
import '../models/cat_image.dart';
import '../services/cat_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CatImage>> futureCatImages;

  @override
  void initState() {
    super.initState();
    futureCatImages = CatApiService().getImages();
  }

  Future<void> _fetchNewCatImage() async {
    setState(() {
      futureCatImages = CatApiService().getImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catos'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<CatImage>>(
        future: futureCatImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: (CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao buscar as imagens.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma imagem encontrada!'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    snapshot.data![0].url,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchNewCatImage,
                    child: const Text('Buscar'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
