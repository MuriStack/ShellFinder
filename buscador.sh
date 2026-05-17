#!/bin/bash

while true; do

    echo "1 - Buscar por nome"
    echo "2 - Buscar por conteúdo"
    echo "3 - Sair"

    read -p "Escolha uma opção: " OPCAO

    if [ $OPCAO -eq 3 ]; then
        echo "Encerrando..."
        break
    fi

    while true; do
        read -p "Digite o diretório: " DIRETORIO

        if [ -d "$DIRETORIO" ]; then
            break
        else
            echo "Diretório inválido"
        fi
    done

    if [ $OPCAO -eq 1 ]; then

        read -p "Digite o nome do arquivo: " NOME

        RESULTADO=$(find "$DIRETORIO" -name "*$NOME*")

        TOTAL=$(echo "$RESULTADO" | wc -l)

        > relatorio.txt

        echo "--------------------------------" >> relatorio.txt
        echo "RELATÓRIO DE BUSCA" >> relatorio.txt
        echo "Data: $(date)" >> relatorio.txt
        echo "Diretório: $DIRETORIO" >> relatorio.txt
        echo "Busca por nome: $NOME" >> relatorio.txt
        echo "Total de arquivos encontrados: $TOTAL" >> relatorio.txt
        echo "--------------------------------" >> relatorio.txt

        SOMA=0

        for ARQUIVO in $RESULTADO; do

            TAMANHO=$(stat --format="%s" "$ARQUIVO")

            SOMA=$((SOMA + TAMANHO))

            stat --format="%n | %s bytes | %y" "$ARQUIVO" >> relatorio.txt

        done

        echo "--------------------------------" >> relatorio.txt
        echo "Tamanho total: $SOMA bytes" >> relatorio.txt
        echo "--------------------------------" >> relatorio.txt

        cat relatorio.txt

    elif [ $OPCAO -eq 2 ]; then

        read -p "Digite a palavra que deseja procurar: " PALAVRA

        RESULTADO=$(grep -r "$PALAVRA" "$DIRETORIO" 2>/dev/null)

        TOTAL=$(echo "$RESULTADO" | wc -l)

        > relatorio.txt

        echo "--------------------------------" >> relatorio.txt
        echo "RELATÓRIO DE BUSCA" >> relatorio.txt
        echo "Data: $(date)" >> relatorio.txt
        echo "Diretório: $DIRETORIO" >> relatorio.txt
        echo "Busca por conteúdo: $PALAVRA" >> relatorio.txt
        echo "Ocorrências encontradas: $TOTAL" >> relatorio.txt
        echo "--------------------------------" >> relatorio.txt

        echo "$RESULTADO" >> relatorio.txt

        echo "--------------------------------" >> relatorio.txt

        cat relatorio.txt

    else
        echo "Opção inválida"
    fi

    echo

done
