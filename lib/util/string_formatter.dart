String capitalizeString(String string) {
  if (string.isEmpty) {
    return '';
  } else {
    return string[0].toUpperCase() + string.substring(1);
  }
}
