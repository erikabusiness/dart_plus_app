class UtilsFunctions {
  static List<String?> genreMap(List<int> ids) {
    Map<int, String> genreMap = {
      28: 'Ação',
      12: 'Aventura',
      16: 'Animação',
      35: 'Comédia',
      80: 'Crime',
      99: 'Documentário',
      18: 'Drama',
      10751: 'Família',
      14: 'Fantasia',
      36: 'História',
      27: 'Terror',
      10402: 'Música',
      9648: 'Mistério',
      10749: 'Romance',
      878: 'Ficção científica',
      10770: 'Cinema TV',
      53: 'Thriller',
      10752: 'Guerra',
      37: 'Faroeste',
      10759: 'Ação e Aventura',
      10762: 'Infantil',
      10763: 'Notícias',
      10764: 'Reality',
      10765: 'Ficção científica e Fantasia',
      10766: 'Novela',
      10767: 'Entrevista',
      10768: 'Guerra e Política',
    };

    List<int> genreIds = ids;

    List<String?> genreNames = genreIds
        .map((id) => genreMap[id])
        .where((name) => name != null)
        .toList();
    return genreNames;
  }

  static Map<int, String> genre = {
    28: 'Ação',
    12: 'Aventura',
    16: 'Animação',
    35: 'Comédia',
    80: 'Crime',
    99: 'Documentário',
    18: 'Drama',
    10751: 'Família',
    14: 'Fantasia',
    36: 'História',
    27: 'Terror',
    10402: 'Música',
    9648: 'Mistério',
    10749: 'Romance',
    878: 'Ficção científica',
    10770: 'Cinema TV',
    53: 'Thriller',
    10752: 'Guerra',
    37: 'Faroeste',
    10759: 'Ação e Aventura',
    10762: 'Infantil',
    10763: 'Notícias',
    10764: 'Reality',
    10765: 'Ficção científica e Fantasia',
    10766: 'Novela',
    10767: 'Entrevista',
    10768: 'Guerra e Política',
  };
}
