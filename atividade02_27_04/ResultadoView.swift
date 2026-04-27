//
//  ResultsView.swift
//  Atividade02-UI
//

import SwiftUI

struct ResultadoView: View {
    let tema: Tema
    let respostas: [Bool]
    let aoReiniciar: () -> Void

    private var corretas: Int { respostas.filter { $0 }.count }
    private var incorretas: Int { respostas.filter { !$0 }.count }
    private var total: Int { respostas.count }
    private var proporcao: Double { Double(corretas) / Double(total) }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.08, green: 0.08, blue: 0.18), Color(red: 0.14, green: 0.10, blue: 0.28)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Ícone de troféu / resultado
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: [.purple.opacity(0.4), .pink.opacity(0.4)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 120, height: 120)

                    Image(systemName: iconeResultado)
                        .font(.system(size: 54))
                        .foregroundStyle(
                            LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                        )
                }

                // Título do resultado
                VStack(spacing: 6) {
                    Text(tituloResultado)
                        .font(.title.bold())
                        .foregroundColor(.white)
                    Text("Tema: \(tema.nome)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }

                // Cartão de pontuação
                HStack(spacing: 0) {
                    CelulaPontuacao(valor: corretas, rotulo: "Corretas", cor: .green)
                    Divider()
                        .background(Color.white.opacity(0.2))
                        .frame(height: 60)
                    CelulaPontuacao(valor: incorretas, rotulo: "Incorretas", cor: .red)
                    Divider()
                        .background(Color.white.opacity(0.2))
                        .frame(height: 60)
                    CelulaPontuacao(valor: total, rotulo: "Total", cor: .purple)
                }
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.07))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 24)

                // Resumo das respostas
                VStack(spacing: 10) {
                    ForEach(0..<respostas.count, id: \.self) { i in
                        HStack {
                            Text("Pergunta \(i + 1)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                            Spacer()
                            Image(systemName: respostas[i] ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(respostas[i] ? .green : .red)
                            Text(respostas[i] ? "Correta" : "Incorreta")
                                .font(.caption.bold())
                                .foregroundColor(respostas[i] ? .green : .red)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.05))
                        )
                    }
                }
                .padding(.horizontal, 24)

                Spacer()

                // Botão de reiniciar
                Button(action: aoReiniciar) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Jogar Novamente")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                LinearGradient(colors: [.purple, .pink],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                    )
                }
                .buttonStyle(EstiloBotaoEscala())
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }

    private var iconeResultado: String {
        switch proporcao {
        case 1.0:        return "trophy.fill"
        case 0.6...:     return "star.fill"
        default:         return "face.dashed"
        }
    }

    private var tituloResultado: String {
        switch proporcao {
        case 1.0:        return "Perfeito!"
        case 0.8...:     return "Muito bem!"
        case 0.6...:     return "Bom trabalho!"
        case 0.4...:     return "Pode melhorar..."
        default:         return "Continue tentando!"
        }
    }
}

struct CelulaPontuacao: View {
    let valor: Int
    let rotulo: String
    let cor: Color

    var body: some View {
        VStack(spacing: 4) {
            Text("\(valor)")
                .font(.title.bold())
                .foregroundColor(cor)
            Text(rotulo)
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
    }
}
