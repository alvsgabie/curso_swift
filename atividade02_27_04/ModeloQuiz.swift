//
//  QuizModel.swift
//  Atividade02-UI
//

import Foundation

struct Pergunta {
    let texto: String
    let opcoes: [String]
    let indiceCorreto: Int
}

struct Tema: Identifiable {
    let id = UUID()
    let nome: String
    let icone: String
    let perguntas: [Pergunta]
}

let todosOsTemas: [Tema] = [
    Tema(
        nome: "Filmes",
        icone: "film",
        perguntas: [
            Pergunta(
                texto: "Qual filme ganhou o Oscar de Melhor Filme em 2020?",
                opcoes: ["1917", "Parasita", "Coringa", "Era Uma Vez em Hollywood"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Quem dirigiu o filme 'O Poderoso Chefão'?",
                opcoes: ["Steven Spielberg", "Martin Scorsese", "Francis Ford Coppola", "Stanley Kubrick"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Em qual país se passa a maior parte de 'Cidade de Deus' (2002)?",
                opcoes: ["Argentina", "México", "Brasil", "Colômbia"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Qual ator interpretou o Coringa no filme de 2019?",
                opcoes: ["Heath Ledger", "Joaquin Phoenix", "Jack Nicholson", "Jared Leto"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Qual é o filme mais rentável de todos os tempos (bilheteria bruta)?",
                opcoes: ["Avengers: Endgame", "Titanic", "Avatar", "Star Wars: O Despertar da Força"],
                indiceCorreto: 2
            )
        ]
    ),
    Tema(
        nome: "Séries",
        icone: "tv",
        perguntas: [
            Pergunta(
                texto: "Em qual cidade se passa a série 'Breaking Bad'?",
                opcoes: ["Los Angeles", "Albuquerque", "Las Vegas", "Phoenix"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Qual série se passa em Westeros e Essos?",
                opcoes: ["Vikings", "The Witcher", "Game of Thrones", "The Last Kingdom"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Quantas temporadas tem a série 'Friends'?",
                opcoes: ["8", "9", "10", "11"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Qual personagem é conhecido por dizer 'How you doin'?' em Friends?",
                opcoes: ["Ross Geller", "Chandler Bing", "Joey Tribbiani", "Mike Hannigan"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Em 'Stranger Things', em qual cidade fictícia a história se passa?",
                opcoes: ["Hawkins", "Derry", "Castle Rock", "Salem's Lot"],
                indiceCorreto: 0
            )
        ]
    ),
    Tema(
        nome: "Livros",
        icone: "book.closed",
        perguntas: [
            Pergunta(
                texto: "Quem escreveu 'Dom Quixote'?",
                opcoes: ["Luís de Camões", "Miguel de Cervantes", "William Shakespeare", "Dante Alighieri"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Em qual livro aparece o personagem Hermione Granger?",
                opcoes: ["O Senhor dos Anéis", "Crônicas de Nárnia", "Harry Potter", "Percy Jackson"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Quem escreveu '1984'?",
                opcoes: ["Aldous Huxley", "Ray Bradbury", "George Orwell", "Philip K. Dick"],
                indiceCorreto: 2
            ),
            Pergunta(
                texto: "Qual é o primeiro livro da saga 'O Senhor dos Anéis'?",
                opcoes: ["As Duas Torres", "A Sociedade do Anel", "O Retorno do Rei", "O Hobbit"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Qual escritor criou o personagem Sherlock Holmes?",
                opcoes: ["Agatha Christie", "Arthur Conan Doyle", "Edgar Allan Poe", "G.K. Chesterton"],
                indiceCorreto: 1
            )
        ]
    ),
    Tema(
        nome: "Documentários",
        icone: "play.rectangle",
        perguntas: [
            Pergunta(
                texto: "Qual documentário explora a fabricação de alimentos da McDonald's?",
                opcoes: ["Food, Inc.", "Super Size Me", "Forks Over Knives", "Fed Up"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "O documentário 'Free Solo' acompanha qual alpinista?",
                opcoes: ["Tommy Caldwell", "Alex Honnold", "Jimmy Chin", "Conrad Anker"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Qual documentário da Netflix aborda o festival Fyre?",
                opcoes: ["The Imposter", "Fyre", "Don't F**k with Cats", "Making a Murderer"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "Quem narrou e apresentou a série 'Planet Earth'?",
                opcoes: ["Morgan Freeman", "David Attenborough", "Neil deGrasse Tyson", "Werner Herzog"],
                indiceCorreto: 1
            ),
            Pergunta(
                texto: "O documentário 'The Social Dilemma' aborda qual tema principal?",
                opcoes: ["Privacidade de dados", "Dependência de redes sociais", "Hackers e segurança", "Fake news na política"],
                indiceCorreto: 1
            )
        ]
    )
]
