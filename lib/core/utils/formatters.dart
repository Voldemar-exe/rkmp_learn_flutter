class Formatters {
  static String capitalizeWords(String text) {
    return text
        .toLowerCase()
        .split(' ')
        .map((word) => word.isEmpty
        ? ''
        : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}