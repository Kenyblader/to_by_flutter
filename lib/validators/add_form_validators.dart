String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Veuillez entrer un nom.";
  }
  return null;
}

String? validatePrice(String? value) {
  if (value == null || value.isEmpty) {
    return "Veuillez entrer un prix.";
  }
  if (double.tryParse(value) == null) {
    return "Veuillez entrer un nombre valide.";
  }
  return null;
}

String? validateQuantity(String? value) {
  if (value == null || value.isEmpty) {
    return "Veuillez entrer une quantité.";
  }
  if (int.tryParse(value) == null) {
    return "Veuillez entrer un nombre entier.";
  }
  return null;
}
