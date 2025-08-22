String makeApiUrl(String path) {
  const environment = 'dev';

  // URLs base para cada ambiente
  const baseUrls = {
    'dev': 'https://dev.your-api-server.com',
    'test': 'https://test.your-api-server.com',
    'prod': 'https://prod.your-api-server.com',
  };

  final baseUrl = baseUrls[environment] ?? baseUrls['dev']!;

  // Mapeia os paths para os endpoints corretos da API
  switch (path) {
    case 'signup':
      return '$baseUrl/usuario/registrar';
    case 'login':
      return '$baseUrl/usuario/login';
    default:
      return '$baseUrl/$path';
  }
}
