# Add Account Presenter

> ## Regras de nome
01. ✅ Deve chamar NameValidation ao alterar o nome
02. ✅ Deve notificar o nameErrorStream com o mesmo erro do NameValidation, caso retorne erro
03. ✅ Deve notificar o nameErrorStream com null, caso o NameValidation não retorne erro
04. ✅ Não deve notificar o nameErrorStream se o valor for igual ao último
05. ✅ Deve notificar o isFormValidStream após alterar o nome

> ## Regras de email
06. ✅ Deve chamar EmailValidation ao alterar o email
07. ✅ Deve notificar o emailErrorStream com o mesmo erro do EmailValidation, caso retorne erro
08. ✅ Deve notificar o emailErrorStream com null, caso o EmailValidation não retorne erro
09. ✅ Não deve notificar o emailErrorStream se o valor for igual ao último
10. ✅ Deve notificar o isFormValidStream após alterar o email

> ## Regras de telefone
11. ✅ Deve chamar PhoneValidation ao alterar o telefone
12. ✅ Deve notificar o phoneErrorStream com o mesmo erro do PhoneValidation, caso retorne erro
13. ✅ Deve notificar o phoneErrorStream com null, caso o PhoneValidation não retorne erro
14. ✅ Não deve notificar o phoneErrorStream se o valor for igual ao último
15. ✅ Deve notificar o isFormValidStream após alterar o telefone

> ## Regras de senha
16. ✅ Deve chamar PasswordValidation ao alterar a senha
17. ✅ Deve notificar o passwordErrorStream com o mesmo erro do PasswordValidation, caso retorne erro
18. ✅ Deve notificar o passwordErrorStream com null, caso o PasswordValidation não retorne erro
19. ✅ Não deve notificar o passwordErrorStream se o valor for igual ao último
20. ✅ Deve notificar o isFormValidStream após alterar a senha



> ## Regras de validação do formulário
21. ✅ Deve validar que para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
22. ✅ Deve validar que nome, email, telefone e senha são campos obrigatórios

> ## Regras de cadastro
23. ✅ Deve chamar o SignUp com nome, email, telefone e senha corretos
24. ✅ Deve notificar o isLoadingStream como true antes de chamar o SignUp
25. ✅ Deve notificar o isLoadingStream como false no fim do SignUp
26. ✅ Deve notificar o mainErrorStream caso o SignUp retorne um DomainError
27. ✅ Deve notificar o navigateToStream com sucesso após cadastro bem-sucedido

> ## Regras de navegação
28. ✅ Deve notificar o navigateToLoginStream quando o usuário clicar em "Já tem uma conta? Login"
29. ✅ Deve notificar o navigateToGoogleAddAccountStream quando o usuário clicar em "Registrar com Google"

> ## Regras de gerenciamento de estado
30. ✅ Deve fechar todos os Streams no dispose
31. ✅ Deve inicializar todos os Streams com valores padrão apropriados
32. ✅ Deve gerenciar o estado de loading durante operações assíncronas

> ## Regras de validação em tempo real
33. ✅ Deve validar campos em tempo real conforme o usuário digita
34. ✅ Deve validar campos quando o usuário perde o foco (onFocusLost)
35. ✅ Deve evitar validações desnecessárias se o valor não mudou

> ## Regras de tratamento de erros
36. ✅ Deve mapear DomainError.invalidCredentials para "Credenciais inválidas"
37. ✅ Deve mapear DomainError.emailInUse para "E-mail já está em uso"
38. ✅ Deve mapear DomainError.invalidEmail para "E-mail inválido"
39. ✅ Deve mapear DomainError.weakPassword para "Senha muito fraca"
40. ✅ Deve mapear DomainError.unexpected para "Erro inesperado"
41. ✅ Deve limpar erros anteriores antes de iniciar nova operação

> ## Regras de validação específicas
42. ✅ Deve validar que o nome tem pelo menos 2 caracteres
43. ✅ Deve validar que o email está em formato válido
44. ✅ Deve validar que o telefone está em formato válido (com código do país)
45. ✅ Deve validar que a senha tem pelo menos 8 caracteres
46. ✅ Deve validar que a senha contém pelo menos uma letra maiúscula, uma minúscula e um número
