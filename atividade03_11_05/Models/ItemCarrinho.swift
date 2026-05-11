//
//  ItemCarrinho.swift
//  Atividade_03_MVVM
//

import Foundation

struct ItemCarrinho: Identifiable, Sendable {
    let id: UUID
    let produto: Produto
    var quantidade: Int

    var subtotal: Double {
        produto.preco * Double(quantidade)
    }

    init(produto: Produto, quantidade: Int = 1) {
        self.id = UUID()
        self.produto = produto
        self.quantidade = quantidade
    }
}
