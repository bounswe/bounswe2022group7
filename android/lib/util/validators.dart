String? validateEmail(String? value) {
  String? msg;
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    msg = "Your email is required";
  } else if (!regex.hasMatch(value)) {
    msg = "Please provide a valid email address";
  }
  return msg;
}

String? validatePassword(String? value) {
  String? msg;
  var minLength = 8;
  if (value == null) {
    msg = "Password can't be empty";
  } else if (value.length < minLength) {
    msg = 'Password must be at least $minLength characters';
  } else if (!value.contains(RegExp(r'[A-Z]'))) {
    msg = 'Password must contain uppercase letters';
  } else if (!value.contains(RegExp(r'[a-z]'))) {
    msg = 'Password must contain lowercase letters';
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

String? validateUserType(String? value) {
  String? msg;
  if (value == null || value == "") {
    msg = "You must select a user type";
  }
  return msg;
}

String? validateEventCategory(String? value) {
  String? msg;
  if (value == null || value == "") {
    msg = "You must select a event type";
  }
  return msg;
}

String? validateEventTitle(String? value) {
  String? msg;
  if (value!.isEmpty) {
    msg = "Title can't be empty";
  }
  return msg;
}

String? validateEventPoster(String? value) {
  String? msg;
  RegExp regex = RegExp(
      r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
  if (value!.isEmpty) {
    msg = "Event poster is required";
  } else if (!regex.hasMatch(value)) {
    msg = "Please provide a valid URL address";
  }
  return msg;
}

String? validateEventDate(String? value) {
  String? msg;
  if (value == null || value == "") {
    msg = "You must select a date";
  }
  return msg;
}
