validInput(String val, int min, int max) {
  if (val.length > max) {
    return "required this failed mor than$max";
  }
  if (val.length < min) {
    return "required this failed less than$min";
  }
  if (val.isEmpty) {
    return "required this failed is Not Empty";
  }
}
