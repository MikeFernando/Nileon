# SignUp Requirements

Este diretório contém todos os requirements relacionados ao fluxo de cadastro (SignUp) da aplicação Nileon.

## 📋 Arquivos de Requirement

### 1. [SignUp Presenter](./signup_presenter.md)
Contém todas as regras de negócio e validações que o presenter de SignUp deve implementar, incluindo:
- Validação de campos (nome, email, telefone, senha)
- Gerenciamento de estado e streams
- Tratamento de erros
- Navegação
- **46 regras detalhadas**

### 2. [AddAccount Use Case](./add_account_use_case.md)
Contém as regras do caso de uso de criação de conta, incluindo:
- Validação de entrada de dados
- Regras de negócio
- Tratamento de erros específicos
- Segurança
- **30 regras detalhadas**

### 3. [SignUp Page](./signup_page.md)
Contém as regras de interface e experiência do usuário, incluindo:
- Layout e componentes visuais
- Validação visual
- Interações do usuário
- Acessibilidade
- Responsividade
- **56 regras detalhadas**

## 🎯 Campos do Formulário

Baseado na análise da tela de registro, o formulário deve conter:

1. **Nome** - Campo obrigatório com validação de mínimo 2 caracteres
2. **Email** - Campo obrigatório com validação de formato
3. **Telefone** - Campo obrigatório com código do país e validação de formato
4. **Senha** - Campo obrigatório com validação de força em três níveis:
   - 🔴 **Fraca** (não permitir): Menos de 8 caracteres, apenas letras minúsculas ou apenas números, sequências óbvias
   - 🟡 **Média** (permitir, mas avisar): 8-11 caracteres com pelo menos 2 categorias (maiúscula, minúscula, número, especial)
   - 🟢 **Forte** (permitir e recomendar): 12+ caracteres com pelo menos 3 categorias

## 🔄 Fluxo de Validação

1. **Validação em tempo real** - Campos são validados conforme o usuário digita
2. **Validação no foco perdido** - Campos são revalidados quando o usuário sai do campo
3. **Validação do formulário** - Formulário só é válido quando todos os campos estão corretos
4. **Validação no servidor** - Dados são validados novamente no caso de uso

## 🚨 Tratamento de Erros

- **Campos obrigatórios** - Mensagens específicas para cada campo
- **Formato inválido** - Validação de email, telefone e senha
- **Email em uso** - Verificação de duplicidade
- **Senha fraca** - Bloqueio automático de senhas fracas
- **Senha média** - Aviso de que pode melhorar
- **Erro de rede** - Tratamento de falhas de comunicação

## 📱 Funcionalidades da Tela

- **Registro tradicional** - Com validação completa
- **Registro com Google** - Integração com OAuth
- **Navegação para login** - Link para usuários existentes
- **Feedback visual** - Indicadores de loading e erro
- **Indicador de força da senha** - Barra de progresso colorida (vermelha, laranja, verde)
- **Acessibilidade** - Suporte a leitores de tela

## 🔐 Regras de Força da Senha

### 🔴 Senha Fraca (NÃO PERMITIR)
- Menos de 8 caracteres
- Apenas letras minúsculas ou apenas números
- Sequências óbvias (ex: 123456, abcdef)

### 🟡 Senha Média (PERMITIR, MAS AVISAR)
- 8 a 11 caracteres
- Contém pelo menos duas categorias entre:
  - Letras maiúsculas (A-Z)
  - Letras minúsculas (a-z)
  - Números (0-9)
  - Caracteres especiais (!@#$%&* etc.)

### 🟢 Senha Forte (PERMITIR E RECOMENDAR)
- 12 ou mais caracteres
- Contém pelo menos três categorias (maiúscula, minúscula, número, especial)
- Não deve conter apenas palavras comuns de dicionário
- Quanto mais imprevisível, melhor

## ✅ Status de Implementação

- [ ] SignUp Presenter
- [ ] AddAccount Use Case
- [ ] SignUp Page
- [ ] Validações específicas
- [ ] Testes unitários
- [ ] Testes de integração
- [ ] Testes de UI
