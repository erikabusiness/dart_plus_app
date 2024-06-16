class ApiConnectionsUrl {
  static const String _apiKey = "a736660cb0e120a75501df7ef999b789";

  static String getPopularMoviesUrl({int pageId = 1}) {
    return "https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=pt-BR&page=$pageId";
  }

  static String getTopRatedMoviesUrl({int pageId = 1}) {
    return "https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey&language=pt-BR&page=$pageId";
  }

  static String getPopularSeriesUrl({int pageId = 1}) {
    return "https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey&language=pt-BR&page=$pageId";
  }

  static String getTrendingMoviesUrl() {
    return "https://api.themoviedb.org/3/trending/movie/day?api_key=$_apiKey&language=pt-BR";
  }

  static String getTrailerUrl(String videoId) {
    return "https://api.themoviedb.org/3/movie/$videoId/videos?api_key=$_apiKey&language=pt-BR";
  }
}
