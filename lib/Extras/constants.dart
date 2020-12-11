class Constants {
  static const api_key = "001f3a34fd7d4be6a8420375c2c50a12";
  static const headlines_url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=$api_key";

  static String countryUrl(country) {
    return "https://newsapi.org/v2/top-headlines?country=$country&apiKey=28fd11a721614f89bac1f4557a3854ad";
  }

  static String categoryUrl(category, country) {
    return "https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=${Constants.api_key}";
  }

  static const Map<String, String> Countries = {
    "US": "us",
    "China": "ch",
    "India": "in",
    "UK": "uk",
    "Germany": "de"
  };
  static const List<String> Category = [
    "business",
    "entertainment",
    'general',
    "health",
    "science",
    "sports",
    "technology"
  ];
}
