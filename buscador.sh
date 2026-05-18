#!/bin/bash

while true; do

    echo "1 - Buscar por nome"
    echo "2 - Buscar por conteúdo"
    echo "3 - Sair"

    echo

    read -p "Escolha uma opção: " OPCAO

    echo

    if ! [[ "$OPCAO" =~ ^[1-3]$ ]]; then
        echo "Opção inválida"
        echo
        continue
    fi

    if [ $OPCAO -eq 3 ]; then
        echo "Encerrou..."
        break
    fi

    read -p "Digite o diretório: " DIRETORIO

    echo

    if [ ! -d "$DIRETORIO" ]; then
        echo "Diretório inválido"
        echo
        continue
    fi

    if [ $OPCAO -eq 1 ]; then

        read -p "Digite o nome do arquivo: " NOME

        echo

        RESULTADO=$(find "$DIRETORIO" -name "*$NOME*")

        TOTAL=$(find "$DIRETORIO" -name "*$NOME*" | wc -l)

        > relatorio.txt

        echo "--------------------------------" >> relatorio.txt
        echo "RELATÓRIO DE BUSCA" >> relatorio.txt
        echo "Data: $(date)" >> relatorio.txt
        echo "Diretório: $DIRETORIO" >> relatorio.txt
        echo "Busca por nome: $NOME" >> relatorio.txt
        echo "Total de arquivos encontrados: $TOTAL" >> relatorio.txt

        SOMA=0

        if [ $TOTAL -gt 0 ]; then

            echo "--------------------------------" >> relatorio.txt

            for ARQUIVO in $RESULTADO; do

                CAMINHO=$(realpath "$ARQUIVO")

                TAMANHO=$(stat --format="%s" "$ARQUIVO")

                SOMA=$((SOMA + TAMANHO))

                stat --format="$CAMINHO | %s bytes | %y" "$ARQUIVO" >> relatorio.txt

            done

            echo "--------------------------------" >> relatorio.txt
            echo "Tamanho total: $SOMA bytes" >> relatorio.txt

        fi

        echo "--------------------------------" >> relatorio.txt

        cat relatorio.txt

    elif [ $OPCAO -eq 2 ]; then

        read -p "Digite a palavra que deseja procurar: " PALAVRA

        echo

        RESULTADO=$(grep -rl "$PALAVRA" "$DIRETORIO" 2>/dev/null)

        TOTAL=$(grep -rl "$PALAVRA" "$DIRETORIO" 2>/dev/null | wc -l)

        > relatorio.txt

        echo "--------------------------------" >> relatorio.txt
        echo "RELATÓRIO DE BUSCA" >> relatorio.txt
        echo "Data: $(date)" >> relatorio.txt
        echo "Diretório: $DIRETORIO" >> relatorio.txt
        echo "Busca por conteúdo: $PALAVRA" >> relatorio.txt
        echo "Arquivos encontrados: $TOTAL" >> relatorio.txt

        SOMA=0

        if [ $TOTAL -gt 0 ]; then

            echo "--------------------------------" >> relatorio.txt

            for ARQUIVO in $RESULTADO; do

                CAMINHO=$(realpath "$ARQUIVO")

                TAMANHO=$(stat --format="%s" "$ARQUIVO")

                SOMA=$((SOMA + TAMANHO))

                stat --format="$CAMINHO | %s bytes | %y" "$ARQUIVO" >> relatorio.txt

            done

            echo "--------------------------------" >> relatorio.txt
            echo "Tamanho total: $SOMA bytes" >> relatorio.txt

        fi

        echo "--------------------------------" >> relatorio.txt

        cat relatorio.txt

    fi

    echo

done
