import 'dart:convert';

void main() {
  String jsonString = '''
  {
    "popularMovies": [
      {
        "popularity": string,
        "title": "string",
        "overview": "string",
        "poster_path": "/caminho/do/poster.jpg"
      }
    ],
    "popularTvSeries": [
      {
        "popularity": String,
        "title": "Nome da Série",
        "overview": "Descrição da série",
        "poster_path": "/caminho/do/poster.jpg"
      }
    ],
    "trending": [
      {
        "popularity": String,
        "title": "Título do Item Trending",
        "overview": "Descrição do item trending",
        "poster_path": "/caminho/do/poster.jpg"
      }
    ]
  }
  ''';

  Map<String, dynamic> data = jsonDecode(jsonString);

  // Função para processar metadados
  void processMetadata(List<dynamic> items) {
    for (var item in items) {
      print('Título: ${item['title']}');
      print('Descrição: ${item['overview']}');
      print(
          'Poster URL: https://image.tmdb.org/t/p/w500/${item['poster_path']}');
      print('');
    }
  }

  // Processar filmes populares
  processMetadata(data['popularMovies']);

  // Processar séries populares
  processMetadata(data['popularTvSeries']);

  // Processar itens trending
  processMetadata(data['trending']);
}
