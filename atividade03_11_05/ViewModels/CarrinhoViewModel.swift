//
//  CarrinhoViewModel.swift
//  Atividade_03_MVVM
//

import SwiftUI
import Observation

@Observable
@MainActor
final class CarrinhoViewModel {

    init() {}

    // MARK: - Produtos disponíveis
    let produtos: [Produto] = [
        // Pães
        Produto(nome: "Pão de Sal",      preco: 0.75,  descricao: "Pão fresquinho feito no dia",       emoji: "🍞", categoria: "Pães"),
        Produto(nome: "Baguete",         preco: 4.50,  descricao: "Baguete francesa crocante",         emoji: "🥖", categoria: "Pães"),
        Produto(nome: "Pão de Queijo",   preco: 2.50,  descricao: "Pão de queijo mineiro tradicional", emoji: "🧇", categoria: "Pães"),
        Produto(nome: "Pão Doce",        preco: 3.00,  descricao: "Pão doce com recheio de creme",     emoji: "🥐", categoria: "Pães"),
        // Frios
        Produto(nome: "Mussarela",       preco: 8.90,  descricao: "Fatiada na hora – 100 g",           emoji: "🧀", categoria: "Frios"),
        Produto(nome: "Presunto",        preco: 6.50,  descricao: "Presunto cozido – 100 g",           emoji: "🥩", categoria: "Frios"),
        Produto(nome: "Mortadela",       preco: 5.00,  descricao: "Mortadela italiana – 100 g",        emoji: "🍖", categoria: "Frios"),
        Produto(nome: "Salame",          preco: 9.90,  descricao: "Salame tipo italiano – 100 g",      emoji: "🥓", categoria: "Frios"),
        // Doces
        Produto(nome: "Bolo de Chocolate", preco: 18.90, descricao: "Bolo artesanal com cobertura",   emoji: "🎂", categoria: "Doces"),
    ]

    // MARK: - Carrinho
    var itensCarrinho: [ItemCarrinho] = []

    // MARK: - Computed
    var totalCarrinho: Double {
        itensCarrinho.reduce(0) { $0 + $1.subtotal }
    }

    var quantidadeTotalItens: Int {
        itensCarrinho.reduce(0) { $0 + $1.quantidade }
    }

    // MARK: - Ações
    func adicionarAoCarrinho(produto: Produto) {
        if let indice = itensCarrinho.firstIndex(where: { $0.produto.id == produto.id }) {
            itensCarrinho[indice].quantidade += 1
        } else {
            itensCarrinho.append(ItemCarrinho(produto: produto))
        }
    }

    func removerDoCarrinho(item: ItemCarrinho) {
        itensCarrinho.removeAll { $0.id == item.id }
    }

    func aumentarQuantidade(item: ItemCarrinho) {
        guard let indice = itensCarrinho.firstIndex(where: { $0.id == item.id }) else { return }
        itensCarrinho[indice].quantidade += 1
    }

    func diminuirQuantidade(item: ItemCarrinho) {
        guard let indice = itensCarrinho.firstIndex(where: { $0.id == item.id }) else { return }
        if itensCarrinho[indice].quantidade > 1 {
            itensCarrinho[indice].quantidade -= 1
        } else {
            removerDoCarrinho(item: item)
        }
    }

    func finalizarCompra() {
        itensCarrinho.removeAll()
    }
}
