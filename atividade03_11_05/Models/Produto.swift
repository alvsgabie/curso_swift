//
//  Produto.swift
//  Atividade_03_MVVM
//

import Foundation

struct Produto: Identifiable, Sendable {
    let id: UUID
    let nome: String
    let preco: Double
    let descricao: String
    let emoji: String
    let categoria: String

    init(nome: String, preco: Double, descricao: String, emoji: String, categoria: String) {
        self.id = UUID()
        self.nome = nome
        self.preco = preco
        self.descricao = descricao
        self.emoji = emoji
        self.categoria = categoria
    }
}
