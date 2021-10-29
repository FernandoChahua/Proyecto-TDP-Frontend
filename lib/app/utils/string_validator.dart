String validateName(String value) {
  RegExp regExp = new RegExp(r"^[a-zA-Z ]*$");
  if (value.length == 0) {
    return "El nombre es necesario";
  } else if (!regExp.hasMatch(value)) {
    return "El nombre debe de ser a-z y A-Z";
  }
  return "";
}

String validateEmail(String value) {
  RegExp regExp = new RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
  if (value.length == 0) {
    return "El correo electrónico es necesario";
  } else if (!regExp.hasMatch(value)) {
    return "Ingresar correo electrónico valido";
  }
  return "";
}
