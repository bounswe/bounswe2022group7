// converts a string representing a list of strings to a list of strings
// example: "[\"a\", \"b\", \"c\"]" -> ["a", "b", "c"]
List<String> stringToList(String? str) {
  if (str == "[]" || str == null) {
    return [];
  }
  str = str.substring(1, str.length - 1);
  List<String> lst = str.split(", ");
  for (int i = 0; i < lst.length; i++) {
    lst[i] = lst[i].substring(1, lst[i].length - 1);
  }
  return lst;
}