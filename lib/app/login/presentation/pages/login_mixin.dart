mixin LoginMixin {
  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return "El password es requerido ala";
    }
    if (value.length < 5) {
      return "El password debe tener al menos 5 caracteres";
    }
    return null;
  }

  String? validateEmail(value) {
    if (value == null || value.isEmpty) {
      return "El email es requerido";
    }
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_.±]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$');
    if (!regExp.hasMatch(value)) {
      return "El email no es válido";
    }
    if (value.length < 5) {
      return "El email debe tener al menos 5 caracteres";
    }
    return null;
  }
}
