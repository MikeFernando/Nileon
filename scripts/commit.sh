#!/bin/bash

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para exibir o menu
show_menu() {
    echo -e "${YELLOW}Escolha o tipo de commit:${NC}"
    echo "1) feat: nova funcionalidade"
    echo "2) fix: correção de bug"
    echo "3) docs: documentação"
    echo "4) style: formatação de código"
    echo "5) refactor: refatoração de código"
    echo "6) test: testes"
    echo "7) chore: tarefas de manutenção"
    echo "8) Sair"
}

# Função para obter o tipo de commit
get_commit_type() {
    case $1 in
        1) echo "feat";;
        2) echo "fix";;
        3) echo "docs";;
        4) echo "style";;
        5) echo "refactor";;
        6) echo "test";;
        7) echo "chore";;
        *) echo "";;
    esac
}

# Função para obter a descrição do commit
get_commit_description() {
    read -p "Digite a descrição do commit: " description
    echo "$description"
}

# Função para obter os detalhes do commit
get_commit_details() {
    echo "Digite os detalhes do commit (pressione Enter duas vezes para finalizar):"
    details=""
    while true; do
        read -p "- " line
        if [ -z "$line" ]; then
            break
        fi
        details="${details}- $line\n"
    done
    echo -e "$details"
}

# Loop principal
while true; do
    show_menu
    read -p "Escolha uma opção (1-8): " choice

    if [ "$choice" = "8" ]; then
        echo "Saindo..."
        exit 0
    fi

    commit_type=$(get_commit_type $choice)
    if [ -z "$commit_type" ]; then
        echo -e "${RED}Opção inválida!${NC}"
        continue
    fi

    description=$(get_commit_description)
    if [ -z "$description" ]; then
        echo -e "${RED}Descrição não pode estar vazia!${NC}"
        continue
    fi

    details=$(get_commit_details)

    # Construir a mensagem do commit
    commit_message="$commit_type: $description\n\n$details"

    # Mostrar preview e confirmar
    echo -e "\n${YELLOW}Preview da mensagem de commit:${NC}"
    echo -e "$commit_message"
    read -p "Confirmar commit? (s/n): " confirm

    if [ "$confirm" = "s" ] || [ "$confirm" = "S" ]; then
        # Fazer o commit
        echo -e "$commit_message" | git commit -F -
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Commit realizado com sucesso!${NC}"
        else
            echo -e "${RED}Erro ao realizar commit!${NC}"
        fi
        break
    else
        echo "Commit cancelado."
    fi
done 