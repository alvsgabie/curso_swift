//
//  ProdutosView.swift
//  Atividade_03_MVVM
//

import SwiftUI

struct ProdutosView: View {
    var viewModel: CarrinhoViewModel

    private let categorias = ["Pães", "Frios", "Doces"]

    var body: some View {
        NavigationStack {
            List {
                ForEach(categorias, id: \.self) { categoria in
                    Section {
                        ForEach(viewModel.produtos.filter { $0.categoria == categoria }) { produto in
                            ProdutoLinhaView(produto: produto) {
                                viewModel.adicionarAoCarrinho(produto: produto)
                            }
                        }
                    } header: {
                        Text(categoria)
                            .font(.headline)
                            .foregroundStyle(.orange)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Text("🥖")
                            .font(.system(size: 22))
                        Text("Padaria do Zé")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

// MARK: - Linha de produto
struct ProdutoLinhaView: View {
    let produto: Produto
    let aoAdicionar: () -> Void

    @State private var animando = false

    var body: some View {
        HStack(spacing: 12) {
            Text(produto.emoji)
                .font(.system(size: 36))

            VStack(alignment: .leading, spacing: 3) {
                Text(produto.nome)
                    .font(.headline)
                Text(produto.descricao)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(produto.preco, format: .currency(code: "BRL"))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.orange)
            }

            Spacer()

            Button {
                aoAdicionar()
                withAnimation(.spring(duration: 0.3, bounce: 0.5)) {
                    animando = true
                }
                Task {
                    try? await Task.sleep(for: .seconds(0.35))
                    animando = false
                }
            } label: {
                Image(systemName: "cart.badge.plus")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .scaleEffect(animando ? 1.35 : 1.0)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProdutosView(viewModel: CarrinhoViewModel())
}
