import 'dart:convert';

void main() {
  String jsonString = '''
  {
    "popularMovies": [
      {
        "popularity": 2157.099,
        "title": "Macaco vs. Máquina",
        "overview": "Reconhecendo o poder destrutivo de seu macaco gigante, o exército americano decide criar um macaco robô. Mas o primeiro teste acaba dando terrivelmente errado e obriga o exército a soltar o animal de verdade para enfrentar a máquina.",
        "poster_path": "/isXDRoaeOm7BJVXVwPzPTnKWKqi.jpg"
      },
      // Adicione mais filmes conforme necessário
    ],
    "popularTvSeries": [
      {
        "popularity": 2157.099,
        "title": "Nome da Série",
        "overview": "Descrição da série",
        "poster_path": "/caminho/do/poster.jpg"
      },
      // Adicione mais séries conforme necessário
    ],
    "trending": [
      {
        "popularity": 2157.099,
        "title": "Título do Item Trending",
        "overview": "Descrição do item trending",
        "poster_path": "/caminho/do/poster.jpg"
      },
      // Adicione mais itens trending conforme necessário
    ]
  }
  ''';

  Map<String, dynamic> data = jsonDecode(jsonString);

  // Processar filmes populares
  List<dynamic> popularMovies = data['popularMovies'];
  for (var movie in popularMovies) {
    print('Título do Filme: ${movie['title']}');
    print('Descrição: ${movie['overview']}');
    print(
        'Poster URL: https://image.tmdb.org/t/p/w500/${movie['poster_path']}');
    print('');
  }

  // Processar séries populares
  List<dynamic> popularTvSeries = data['popularTvSeries'];
  for (var series in popularTvSeries) {
    print('Título da Série: ${series['title']}');
    print('Descrição: ${series['overview']}');
    print(
        'Poster URL: https://image.tmdb.org/t/p/w500/${series['poster_path']}');
    print('');
  }

  // Processar itens trending
  List<dynamic> trendingItems = data['trending'];
  for (var item in trendingItems) {
    print('Título do Item Trending: ${item['title']}');
    print('Descrição: ${item['overview']}');
    print('Poster URL: https://image.tmdb.org/t/p/w500/${item['poster_path']}');
    print('');
  }
}
