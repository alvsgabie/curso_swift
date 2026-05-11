//
//  CarrinhoView.swift
//  Atividade_03_MVVM
//

import SwiftUI

struct CarrinhoView: View {
    var viewModel: CarrinhoViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.itensCarrinho.isEmpty {
                    CarrinhoVazioView()
                } else {
                    List {
                        // Itens
                        Section(header: Text("Itens no carrinho")) {
                            ForEach(viewModel.itensCarrinho) { item in
                                ItemCarrinhoLinhaView(item: item, viewModel: viewModel)
                            }
                            .onDelete { indices in
                                indices.forEach { i in
                                    viewModel.removerDoCarrinho(item: viewModel.itensCarrinho[i])
                                }
                            }
                        }

                        // Totalizador
                        Section {
                            HStack {
                                Text("Total")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(viewModel.totalCarrinho, format: .currency(code: "BRL"))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.orange)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Text("🛒")
                            .font(.system(size: 22))
                        Text("Carrinho")
                            .font(.headline)
                    }
                }
                if !viewModel.itensCarrinho.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
    }
}

// MARK: - Carrinho vazio
private struct CarrinhoVazioView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "cart")
                .font(.system(size: 64))
                .foregroundStyle(.secondary.opacity(0.5))
            Text("Carrinho vazio")
                .font(.title2)
                .foregroundStyle(.secondary)
            Text("Adicione produtos na aba Produtos.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Linha de item no carrinho
struct ItemCarrinhoLinhaView: View {
    let item: ItemCarrinho
    var viewModel: CarrinhoViewModel

    var body: some View {
        HStack(spacing: 12) {
            Text(item.produto.emoji)
                .font(.system(size: 36))

            VStack(alignment: .leading, spacing: 3) {
                Text(item.produto.nome)
                    .font(.headline)
                Text(item.subtotal, format: .currency(code: "BRL"))
                    .font(.subheadline)
                    .foregroundStyle(.orange)
            }

            Spacer()

            // Controles de quantidade
            HStack(spacing: 10) {
                Button {
                    viewModel.diminuirQuantidade(item: item)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                }
                .buttonStyle(.plain)

                Text("\(item.quantidade)")
                    .font(.headline)
                    .frame(minWidth: 28, alignment: .center)

                Button {
                    viewModel.aumentarQuantidade(item: item)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CarrinhoView(viewModel: CarrinhoViewModel())
}
