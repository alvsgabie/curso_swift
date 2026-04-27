//
//  QuizView.swift
//  Atividade02-UI
//

import SwiftUI

struct QuizView: View {
    let tema: Tema
    let aoTerminar: ([Bool]) -> Void

    @State private var indiceAtual = 0
    @State private var opcaoSelecionada: Int? = nil
    @State private var respostas: [Bool] = []
    @State private var mostrarRetorno = false

    private var pergunta: Pergunta { tema.perguntas[indiceAtual] }
    private var eUltimaPergunta: Bool { indiceAtual == tema.perguntas.count - 1 }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.08, green: 0.08, blue: 0.18), Color(red: 0.14, green: 0.10, blue: 0.28)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Cabeçalho
                VStack(spacing: 12) {
                    HStack {
                        Image(systemName: tema.icone)
                            .foregroundColor(.purple)
                        Text(tema.nome)
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Text("\(indiceAtual + 1)/\(tema.perguntas.count)")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)

                    ProgressView(value: Double(indiceAtual + 1), total: Double(tema.perguntas.count))
                        .tint(.purple)
                        .padding(.horizontal, 24)
                }

                Spacer()

                // Cartão da pergunta
                VStack(alignment: .leading, spacing: 20) {
                    Text("Pergunta \(indiceAtual + 1)")
                        .font(.caption.uppercaseSmallCaps())
                        .foregroundColor(.purple.opacity(0.9))

                    Text(pergunta.texto)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.07))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 24)

                Spacer()

                // Opções
                VStack(spacing: 12) {
                    ForEach(0..<pergunta.opcoes.count, id: \.self) { indice in
                        BotaoOpcao(
                            rotulo: rotuloOpcao(indice),
                            texto: pergunta.opcoes[indice],
                            estado: estadoOpcao(indice),
                            desativado: mostrarRetorno
                        ) {
                            guard !mostrarRetorno else { return }
                            opcaoSelecionada = indice
                        }
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // Retorno
                if mostrarRetorno, let selecionado = opcaoSelecionada {
                    BannerRetorno(
                        eCorreto: selecionado == pergunta.indiceCorreto,
                        respostaCorreta: pergunta.opcoes[pergunta.indiceCorreto]
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                // Botão confirmar / próxima
                Button(action: tocarBotao) {
                    Text(mostrarRetorno
                         ? (eUltimaPergunta ? "Ver Resultado" : "Próxima Pergunta")
                         : "Confirmar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(
                                      LinearGradient(colors: [.purple, .pink],
                                                       startPoint: .leading,
                                                       endPoint: .trailing))
                        )
                }
                .disabled(opcaoSelecionada == nil)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: mostrarRetorno)
    }

    private func rotuloOpcao(_ indice: Int) -> String {
        ["A", "B", "C", "D"][indice]
    }

    private func estadoOpcao(_ indice: Int) -> EstadoOpcao {
        guard mostrarRetorno, let selecionado = opcaoSelecionada else {
            return opcaoSelecionada == indice ? .selecionado : .normal
        }
        if indice == pergunta.indiceCorreto { return .correto }
        if indice == selecionado { return .errado }
        return .normal
    }

    private func tocarBotao() {
        guard let selecionado = opcaoSelecionada else { return }

        if !mostrarRetorno {
            withAnimation { mostrarRetorno = true }
            return
        }

        respostas.append(selecionado == pergunta.indiceCorreto)

        if eUltimaPergunta {
            aoTerminar(respostas)
        } else {
            withAnimation {
                indiceAtual += 1
                opcaoSelecionada = nil
                mostrarRetorno = false
            }
        }
    }
}

// MARK: - Estado da Opção

enum EstadoOpcao {
    case normal, selecionado, correto, errado
}

// MARK: - Botão de Opção

struct BotaoOpcao: View {
    let rotulo: String
    let texto: String
    let estado: EstadoOpcao
    let desativado: Bool
    let acao: () -> Void

    var body: some View {
        Button(action: acao) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(fundoInsignia)
                        .frame(width: 36, height: 36)
                    Text(rotulo)
                        .font(.subheadline.bold())
                        .foregroundColor(textoInsignia)
                }
                Text(texto)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                Spacer()
                if estado == .correto {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if estado == .errado {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(fundoLinha)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(corBorda, lineWidth: 1.5)
                    )
            )
        }
        .buttonStyle(EstiloBotaoEscala())
        .disabled(desativado)
    }

    private var fundoLinha: Color {
        switch estado {
        case .correto:    return Color.green.opacity(0.15)
        case .errado:     return Color.red.opacity(0.15)
        case .selecionado: return Color.purple.opacity(0.2)
        case .normal:     return Color.white.opacity(0.06)
        }
    }

    private var corBorda: Color {
        switch estado {
        case .correto:    return .green.opacity(0.8)
        case .errado:     return .red.opacity(0.8)
        case .selecionado: return .purple.opacity(0.8)
        case .normal:     return .white.opacity(0.12)
        }
    }

    private var fundoInsignia: Color {
        switch estado {
        case .correto:    return .green
        case .errado:     return .red
        case .selecionado: return .purple
        case .normal:     return .white.opacity(0.15)
        }
    }

    private var textoInsignia: Color { .white }
}

// MARK: - Banner de Retorno

struct BannerRetorno: View {
    let eCorreto: Bool
    let respostaCorreta: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: eCorreto ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.title2)
                .foregroundColor(eCorreto ? .green : .red)

            VStack(alignment: .leading, spacing: 2) {
                Text(eCorreto ? "Correto!" : "Incorreto!")
                    .font(.headline)
                    .foregroundColor(.white)
                if !eCorreto {
                    Text("Resposta correta: \(respostaCorreta)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.75))
                }
            }
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(eCorreto ? Color.green.opacity(0.18) : Color.red.opacity(0.18))
        )
    }
}
