# Login Presenter

> ## Regras

1. ✅ Deve chamar Validation ao alterar o email
2. ✅ Deve notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
3. Deve notificar o emailErrorStream com null, caso o Validation não retorne erro
4. Não deve notificar o emailErrorStream se o valor for igual ao último
5. Deve notificar o isFormValidStream após alterar o email
6. Deve chamar Validation ao alterar a senha
7. Deve notificar o passwordErrorStream com o mesmo erro do Validation, caso retorne erro
8. Deve notificar o passwordErrorStream com null, caso o Validation não retorne erro
9. Não deve notificar o passwordErrorStream se o valor for igual ao último
10. Deve notificar o isFormValidStream após alterar a senha
11. Deve validar que para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios
12. Não deve notificar o isFormValidStream se o valor for igual ao último
13. Deve chamar o Authentication com email e senha corretos
14. Deve notificar o isLoadingStream como true antes de chamar o Authentication
15. Deve notificar o isLoadingStream como false no fim do Authentication
16. Deve notificar o mainErrorStream caso o Authentication retorne um DomainError
17. Deve fechar todos os Streams no dispose
19. ⛔ Deve levar o usuário pra tela de Enquetes em caso de sucesso
