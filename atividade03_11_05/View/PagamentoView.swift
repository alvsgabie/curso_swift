//
//  PagamentoView.swift
//  Atividade_03_MVVM
//

import SwiftUI

// MARK: - Formas de pagamento
enum FormaPagamento: String, CaseIterable, Identifiable {
    case pix           = "Pix"
    case cartaoCredito = "Cartão de Crédito"
    case cartaoDebito  = "Cartão de Débito"
    case dinheiro      = "Dinheiro"

    var id: String { rawValue }

    var icone: String {
        switch self {
        case .pix:           return "qrcode"
        case .cartaoCredito: return "creditcard.fill"
        case .cartaoDebito:  return "creditcard"
        case .dinheiro:      return "banknote"
        }
    }

    var cor: Color {
        switch self {
        case .pix:           return .blue
        case .cartaoCredito: return .purple
        case .cartaoDebito:  return .green
        case .dinheiro:      return .orange
        }
    }
}

// MARK: - Pagamento
struct PagamentoView: View {
    var viewModel: CarrinhoViewModel

    @State private var formaSelecionada: FormaPagamento = .pix
    @State private var mostrarCompraConcluidaModal = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    // Resumo do pedido
                    Section(header: Text("Resumo do pedido")) {
                        HStack {
                            Text("Quantidade de itens")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(viewModel.quantidadeTotalItens)")
                                .fontWeight(.semibold)
                        }
                        HStack {
                            Text("Total")
                                .fontWeight(.bold)
                            Spacer()
                            Text(viewModel.totalCarrinho, format: .currency(code: "BRL"))
                                .fontWeight(.bold)
                                .foregroundStyle(.orange)
                        }
                    }

                    // Forma de pagamento
                    Section(header: Text("Forma de pagamento")) {
                        ForEach(FormaPagamento.allCases) { forma in
                            HStack(spacing: 12) {
                                Image(systemName: forma.icone)
                                    .foregroundStyle(forma.cor)
                                    .frame(width: 26)

                                Text(forma.rawValue)

                                Spacer()

                                if formaSelecionada == forma {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.orange)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture { formaSelecionada = forma }
                            .padding(.vertical, 2)
                        }
                    }
                }
                .listStyle(.insetGrouped)

                // Botão finalizar
                Button {
                    mostrarCompraConcluidaModal = true
                } label: {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                        Text("Finalizar Compra")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.itensCarrinho.isEmpty ? Color.gray.opacity(0.4) : Color.orange)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 14))
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .disabled(viewModel.itensCarrinho.isEmpty)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 6) {
                        Text("💳")
                            .font(.system(size: 22))
                        Text("Pagamento")
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $mostrarCompraConcluidaModal) {
                CompraConcluidaView(
                    formaPagamento: formaSelecionada,
                    total: viewModel.totalCarrinho,
                    aoFechar: {
                        mostrarCompraConcluidaModal = false
                        viewModel.finalizarCompra()
                    }
                )
            }
        }
    }
}

// MARK: - Modal compra concluída
struct CompraConcluidaView: View {
    let formaPagamento: FormaPagamento
    let total: Double
    let aoFechar: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(.green)
                .padding(.bottom, 4)

            VStack(spacing: 8) {
                Text("Compra Concluída!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Obrigado pela preferência!")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 6) {
                HStack(spacing: 8) {
                    Image(systemName: formaPagamento.icone)
                        .foregroundStyle(formaPagamento.cor)
                    Text("Pagamento: \(formaPagamento.rawValue)")
                        .foregroundStyle(.secondary)
                }
                .font(.subheadline)

                Text(total, format: .currency(code: "BRL"))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color(.systemGroupedBackground))
            .clipShape(.rect(cornerRadius: 14))

            Text("🥖 Padaria do Zé agradece sua visita!")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: aoFechar) {
                Text("Voltar ao Início")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 14))
                    .padding(.horizontal)
            }

            Spacer().frame(height: 8)
        }
        .padding()
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    PagamentoView(viewModel: CarrinhoViewModel())
}
