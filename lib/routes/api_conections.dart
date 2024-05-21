class ApiConectionsUrl {
  static const String _apiKey = "a736660cb0e120a75501df7ef999b789";

  static const String getAllPopularMoviesUrl =
      "https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=pt-BR&page=1";
  static const String getAllMoviesTopRatedUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey&language=pt-BR&page=1";
  static const String getAllPopularSeriesUrl =
      "https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey&language=pt-BR&page=1";
  static const String getAllTrhendsMoviesUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=$_apiKey&language=pt-BR";

  static String getTrailerPopularMovieUrl(String videoId) {
    return "https://api.themoviedb.org/3/movie/$videoId/videos?api_key=$_apiKey&language=pt-BR";
  }
}
