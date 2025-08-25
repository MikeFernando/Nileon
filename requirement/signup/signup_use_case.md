# AddAccount Use Case

> ## Regras de entrada
01. ✅ Deve receber AddAccountParams com nome, email, telefone e senha
02. ✅ Deve validar que todos os campos obrigatórios estão preenchidos
03. ✅ Deve validar que o email está em formato válido
04. ✅ Deve validar que a senha não é fraca (menos de 8 caracteres, apenas letras minúsculas ou apenas números, sequências óbvias)
05. ✅ Deve validar que a senha é pelo menos média (8+ caracteres com pelo menos 2 categorias)
06. ✅ Deve validar que o telefone está em formato válido
07. ✅ Deve recomendar senhas fortes (12+ caracteres com pelo menos 3 categorias)

> ## Regras de negócio
08. ✅ Deve verificar se o email já está em uso no sistema
09. ✅ Deve criptografar a senha antes de salvar
10. ✅ Deve gerar um ID único para a conta
11. ✅ Deve criar a conta com os dados fornecidos
12. ✅ Deve retornar AccountEntity com os dados da conta criada
13. ✅ Deve bloquear senhas fracas automaticamente
14. ✅ Deve aceitar senhas médias e fortes

> ## Regras de erro
15. ✅ Deve lançar DomainError.invalidEmail se o email for inválido
16. ✅ Deve lançar DomainError.emailInUse se o email já estiver em uso
17. ✅ Deve lançar DomainError.weakPassword se a senha for muito fraca
18. ✅ Deve lançar DomainError.invalidPhone se o telefone for inválido
19. ✅ Deve lançar DomainError.unexpected se ocorrer erro inesperado

> ## Regras de retorno
20. ✅ Deve retornar AccountEntity com id, nome, email e telefone
21. ✅ Deve retornar Future<AccountEntity> para operação assíncrona
22. ✅ Deve garantir que o AccountEntity retornado contém todos os dados necessários

> ## Regras de validação de dados
23. ✅ Deve validar que o nome tem pelo menos 3 caracteres
24. ✅ Deve validar que o nome não contém caracteres especiais inválidos
25. ✅ Deve validar que o email não está vazio
26. ✅ Deve validar que o telefone não está vazio
27. ✅ Deve validar que a senha não está vazia
28. ✅ Deve validar que a senha não contém sequências óbvias (123456, abcdef, etc.)

> ## Regras de segurança
29. ✅ Deve sanitizar os dados de entrada
30. ✅ Deve validar que não há tentativa de SQL injection
31. ✅ Deve validar que não há tentativa de XSS
32. ✅ Deve garantir que a senha não seja armazenada em texto plano
33. ✅ Deve validar que a senha não contém apenas palavras comuns de dicionário
