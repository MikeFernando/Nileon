# Scripts de Automação

## Commit Automatizado

O script `commit.sh` ajuda a criar mensagens de commit padronizadas seguindo o padrão Conventional Commits.

### Como usar

1. Primeiro, torne o script executável:
```bash
chmod +x scripts/commit.sh
```

2. Para fazer um commit, execute:
```bash
./scripts/commit.sh
```

3. Siga as instruções interativas:
   - Escolha o tipo de commit (feat, fix, docs, etc.)
   - Digite uma descrição curta
   - Adicione detalhes (opcional) - pressione Enter duas vezes para finalizar
   - Confirme o commit

### Tipos de Commit

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Documentação
- `style`: Formatação de código
- `refactor`: Refatoração de código
- `test`: Testes
- `chore`: Tarefas de manutenção

### Exemplo de Uso

```bash
$ ./scripts/commit.sh

Escolha o tipo de commit:
1) feat: nova funcionalidade
2) fix: correção de bug
3) docs: documentação
4) style: formatação de código
5) refactor: refatoração de código
6) test: testes
7) chore: tarefas de manutenção
8) Sair

Escolha uma opção (1-8): 2
Digite a descrição do commit: corrige status de abertura da barbearia ao navegar entre telas

Digite os detalhes do commit (pressione Enter duas vezes para finalizar):
- Corrige o problema onde o status de abertura da barbearia era perdido
- Adiciona parâmetros isOpen e workingHours para manter consistência

Preview da mensagem de commit:
fix: corrige status de abertura da barbearia ao navegar entre telas

- Corrige o problema onde o status de abertura da barbearia era perdido
- Adiciona parâmetros isOpen e workingHours para manter consistência

Confirmar commit? (s/n): s
```

### Dicas

1. Você pode adicionar um alias no seu `.bashrc` ou `.zshrc`:
```bash
alias cc='./scripts/commit.sh'
```

2. Para commits simples, você pode usar o git normalmente:
```bash
git commit -m "fix: mensagem curta"
```

3. Para commits mais detalhados, use o script para manter a consistência. 

Para usar o alias `cc`, você precisa adicionar a seguinte linha ao seu arquivo `.bashrc` ou `.zshrc`:

```bash
alias cc='./scripts/commit.sh'
```

Depois de adicionar o alias, você precisa recarregar seu arquivo de configuração do shell:

```bash
source ~/.bashrc  # se estiver usando bash
# ou
source ~/.zshrc   # se estiver usando zsh
```

Agora você pode simplesmente digitar `cc` no terminal para executar o script de commit. Por exemplo:

```bash
git add .
cc
```

E o script será executado com o alias `cc`. É mais curto e mais fácil de digitar que o comando completo! 