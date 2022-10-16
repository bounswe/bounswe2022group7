String? validateEmail(String? value) {
  String? msg;
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    msg = "Your email is required";
  } else if (!regex.hasMatch(value)) {
    msg = "Please provide a valid email address";
  } else if (value.contains(" ")) {
    msg = "Email cannot have spaces"; // different prompt for space
  }
  return msg;
}
