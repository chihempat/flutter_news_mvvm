class Constants {
  static const api_key = "28fd11a721614f89bac1f4557a3854ad";
  static const headlines_url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=$api_key";

  static String countryUrl(country) {
    return "https://newsapi.org/v2/top-headlines?country=$country&apiKey=${Constants.api_key}";
  }

  static const Map<String, String> Countries = {
    "US": "us",
    "China": "ch",
    "India": "in",
    "UK": "uk"
  };
}
