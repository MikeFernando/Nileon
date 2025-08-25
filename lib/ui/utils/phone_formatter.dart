class PhoneFormatter {
  /// Formata um número de telefone brasileiro no padrão (00) 00000-0000
  ///
  /// [text] - O texto contendo apenas números
  /// Retorna o telefone formatado ou string vazia se não houver números
  static String format(String text) {
    // Remove todos os caracteres não numéricos
    final cleanText = text.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanText.isEmpty) return '';

    // Formata o telefone brasileiro no padrão (00) 00000-0000
    if (cleanText.length <= 2) {
      return cleanText;
    } else if (cleanText.length <= 6) {
      return '(${cleanText.substring(0, 2)}) ${cleanText.substring(2)}';
    } else if (cleanText.length <= 10) {
      return '(${cleanText.substring(0, 2)}) ${cleanText.substring(2, 6)}-${cleanText.substring(6)}';
    } else {
      return '(${cleanText.substring(0, 2)}) ${cleanText.substring(2, 7)}-${cleanText.substring(7)}';
    }
  }

  /// Remove a formatação de um telefone, retornando apenas os números
  ///
  /// [text] - O texto formatado do telefone
  /// Retorna apenas os números do telefone
  static String unformat(String text) {
    return text.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Verifica se um telefone está completamente formatado
  ///
  /// [text] - O texto do telefone
  /// Retorna true se o telefone estiver no formato completo (00) 00000-0000
  static bool isFullyFormatted(String text) {
    final cleanText = unformat(text);
    return cleanText.length == 11;
  }
}
