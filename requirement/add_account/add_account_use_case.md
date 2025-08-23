# AddAccount Use Case

> ## Regras de entrada
01. ✅ Deve receber AddAccountParams com nome, email, telefone e senha
02. ✅ Deve validar que todos os campos obrigatórios estão preenchidos
03. ✅ Deve validar que o email está em formato válido
04. ✅ Deve validar que a senha tem pelo menos 8 caracteres
05. ✅ Deve validar que a senha contém pelo menos uma letra maiúscula, uma minúscula e um número
06. ✅ Deve validar que o telefone está em formato válido

> ## Regras de negócio
08. ✅ Deve verificar se o email já está em uso no sistema
09. ✅ Deve criptografar a senha antes de salvar
10. ✅ Deve gerar um ID único para a conta
11. ✅ Deve criar a conta com os dados fornecidos
12. ✅ Deve retornar AccountEntity com os dados da conta criada

> ## Regras de erro
13. ✅ Deve lançar DomainError.invalidEmail se o email for inválido
14. ✅ Deve lançar DomainError.emailInUse se o email já estiver em uso
15. ✅ Deve lançar DomainError.weakPassword se a senha for muito fraca
16. ✅ Deve lançar DomainError.invalidPhone se o telefone for inválido
17. ✅ Deve lançar DomainError.unexpected se ocorrer erro inesperado

> ## Regras de retorno
19. ✅ Deve retornar AccountEntity com id, nome, email e telefone
20. ✅ Deve retornar Future<AccountEntity> para operação assíncrona
21. ✅ Deve garantir que o AccountEntity retornado contém todos os dados necessários

> ## Regras de validação de dados
22. ✅ Deve validar que o nome tem pelo menos 3 caracteres
23. ✅ Deve validar que o nome não contém caracteres especiais inválidos
24. ✅ Deve validar que o email não está vazio
25. ✅ Deve validar que o telefone não está vazio
26. ✅ Deve validar que a senha não está vazia

> ## Regras de segurança
28. ✅ Deve sanitizar os dados de entrada
29. ✅ Deve validar que não há tentativa de SQL injection
30. ✅ Deve validar que não há tentativa de XSS
31. ✅ Deve garantir que a senha não seja armazenada em texto plano
