String makeApiUrl(String path) {
  const environment = 'dev';

  const baseUrls = {
    'dev': 'https://mock.apidog.com/m1/1046251-1033583-default',
    'test': 'https://test.your-api-server.com',
    'prod': 'https://prod.your-api-server.com',
  };

  final baseUrl = baseUrls[environment] ?? baseUrls['dev']!;

  switch (path) {
    case 'add_account':
      return '$baseUrl/usuario/registrar';
    case 'login':
      return '$baseUrl/usuario/login';
    default:
      return '$baseUrl/$path';
  }
}
