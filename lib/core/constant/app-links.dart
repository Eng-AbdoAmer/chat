class AppLinks {
  static String apiKeyGoogleMap = "AIzaSyCSGP2IG1S0M2-Nt9Pr_yDQmrjjysoH4Ek";
  static String urlServer = "https://silver.tag-soft.com/api/";
  static String getCompanySupport = "${urlServer}v1/companySupport";
  static String getCreateRate = "${urlServer}v1/user/rate/createRate";
  static String sessionToken = "6616156156156506516156";
  static String userToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3NpbHZlci50YWctc29mdC5jb20vYXBpL3YxL3VzZXIvbG9naW4iLCJpYXQiOjE2OTUxMzMwNzQsImV4cCI6MTY5NTEzNjY3NCwibmJmIjoxNjk1MTMzMDc0LCJqdGkiOiIxWHhObWFXYW1jSDBMRjVnIiwic3ViIjoiMyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.iFn1QnTOBEef9LsDkj9AttZq51u6W7lOOm_mRAJ6x20";

  static Map<String, String> myHeaders = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $userToken",
  };
  static String notificationApi = "https://fcm.googleapis.com/fcm/send"; //post
  static Map<String, String> myHeadersToNotification = {
    "Content-Type": "application/json",
    "Authorization":
        "key=AAAA4YCJ-e0:APA91bHmc6zjlN4DO5wVpdG86oJ7dSERXEkjg6-Z_ekrbqvStEYM30mwyV_uoyLVMtZCGYgv8zNJ9kE4H0F6sIWDeWp5NG_E95oKK-SwE4JSqi_JyXTks_9MJlHVbHZgck6Duqd0Gb2-",
  };
  static String getPlaceSuggestion =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=cairo&types=address&key=${apiKeyGoogleMap}&components=country:eg&sessiontoken=6616156156156506516156";
}
