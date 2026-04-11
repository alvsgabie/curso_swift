# Curso Swift

Repositório de atividades desenvolvidas durante o curso de Swift.

## Autora

**Gabrielle Alves de Almeida**

---

## Atividades

### `atividade_10_04.swift` — Gerenciador de Contatos
**Data de conclusão:** 10/04/2026

Aplicação de linha de comando (CLI) para gerenciamento de contatos, desenvolvida com orientação a objetos em Swift.

**Funcionalidades:**
- Cadastrar novo contato (nome, idade, telefone e e-mail)
- Listar todos os contatos cadastrados
- Alterar dados de um contato existente pelo ID
- Remover um contato pelo ID

**Conceitos utilizados:**
- `enum` para opções do menu
- `class` com encapsulamento (`Contato` e `GerenciadorContatos`)
- `UUID` para identificação única de cada contato
- Validação de entradas com `readLine()` e `guard`
- Navegação recursiva entre menus

**Validações implementadas:**
- Campo vazio: nenhum campo (nome, idade, telefone, e-mail) pode ser deixado em branco
- Nome duplicado: impede o cadastro de dois contatos com o mesmo nome; sugere usar nome + sobrenome para diferenciar
- Opção de menu inválida: entrada não numérica ou fora do intervalo exibe mensagem de erro e retorna ao menu
- Saída a qualquer momento: digitar `0` em qualquer campo encerra a aplicação imediatamente
- ID inexistente: ao alterar ou remover, caso o ID informado não seja encontrado, o usuário é solicitado a tentar novamente

