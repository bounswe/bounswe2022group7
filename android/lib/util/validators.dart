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

String? validatePassword(String? value) {
  // TODO these values are temporary, change after backend implementation
  String? msg;
  var maxLength = 37;
  var minLength = 8;
  if (value == null) {
    msg = "Password can't be empty";
  } else if (value.length < minLength) {
    msg = 'Password must be at least $minLength characters';
  } else if (value.length > maxLength) {
    msg = "Password can't be longer than $maxLength characters";
  }
  return msg;
}

String? validateUsername(String? value) {
  String? msg;
  if (value!.isEmpty) {
    msg = "Username can't be empty";
  }
  return msg;
}
