class CityConstanta{
  static const String ALL = "All";
  static const String ACEH = "Aceh";
  static const String BALI = "Bali";
  static const String BALIKPAPAN = "Balikpapan";
  static const String GORONTALO = "Gorontalo";
  static const String MEDAN = "Medan";
  static const String SURABAYA = "Surabaya";
}

final String baseUrl = "https://restaurant-api.dicoding.dev";
final String list = "/list";
final String detail = "/detail/";
final String search = "/search?q=";
final String addReview = "/review";
final String imageSmall = "images/small";
final String imageMedium = "images/medium";
final String imageLarge = "images/large";

enum ResultState { Loading, NoData, HasData, Error }