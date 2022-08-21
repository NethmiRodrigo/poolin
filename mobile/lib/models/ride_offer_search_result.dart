class User {
  String name;
  String profilePicture;
  double starRating;
  int noOfRatings;

  User({
    required this.name,
    required this.starRating,
    required this.noOfRatings,
    this.profilePicture = 'https://i.pravatar.cc/300',
  });
}

class RideOfferSearchResult {
  String id;
  User user;
  double price;
  String model;

  RideOfferSearchResult(
      {required this.id,
      required this.price,
      required this.user,
      required this.model});
}
