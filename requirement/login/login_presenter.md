# Login Presenter

> ## Regras de email
01. ✅ Deve chamar EmailValidation ao alterar o email
02. ✅ Deve notificar o emailErrorStream com o mesmo erro do EmailValidation, caso retorne erro
03. ✅ Deve notificar o emailErrorStream com null, caso o EmailValidation não retorne erro
04. ✅ Não deve notificar o emailErrorStream se o valor for igual ao último
05. ✅ Deve notificar o isFormValidStream após alterar o email

> ## Regras de senha
06. ✅ Deve chamar PasswordValidation ao alterar o senha
07. ✅ Deve notificar o passwordErrorStream com o mesmo erro do PasswordValidation, caso retorne erro
08. ✅ Deve notificar o passwordErrorStream com null, caso o PasswordValidation não retorne erro
09. ✅ Não deve notificar o passwordErrorStream se o valor for igual ao último
10. ✅ Deve notificar o isFormValidStream após alterar a senha

> ## Regras de autenticação
11. ✅ Deve validar que para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
12. ✅ Deve chamar o Authentication com email e senha corretos
13. ✅ Deve notificar o isLoadingStream como true antes de chamar o Authentication
14. ✅ Deve notificar o isLoadingStream como false no fim do Authentication
15. ✅ Deve notificar o mainErrorStream caso o Authentication retorne um DomainError
16. ✅ Deve fechar todos os Streams no dispose
17