// services/movie_service.dart
import 'package:dart_plus_app/models/movie.dart';

class MovieService {
  // Simulação de uma lista de filmes
  static final List<Movie> _movies = [
    Movie(
      titulo: 'Titanic',
      diretor: 'James Cameron',
      datalancamento: '1997',
      posterUrl:
          'https://www.originalfilmart.com/cdn/shop/products/titanic_1997_R2012_original_film_art_a_e4bb6b43-fdc6-48c5-83e8-a73e06c1ce61_1024x1024.jpg?v=1633381608',
    ),
    Movie(
      titulo: 'Avatar',
      diretor: 'James Cameron',
      datalancamento: '2009',
      posterUrl:
          'https://m.media-amazon.com/images/I/71I8gLVW0DL._AC_UF1000,1000_QL80_.jpg',
    ),
    // Adicione mais filmes conforme necessário
  ];

  // Método para buscar filmes por título
  static List<Movie> searchMovies(String query) {
    return _movies
        .where(
            (movie) => movie.titulo.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
