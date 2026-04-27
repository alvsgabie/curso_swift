//
//  ThemeSelectionView.swift
//  Atividade02-UI
//

import SwiftUI

struct SelecaoTemaView: View {
    let aoSelecionarTema: (Tema) -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.08, green: 0.08, blue: 0.18), Color(red: 0.14, green: 0.10, blue: 0.28)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(
                            LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )

                    Text("Quiz Cultural")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)

                    Text("Escolha um tema para começar")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 40)

                VStack(spacing: 16) {
                    ForEach(todosOsTemas) { tema in
                        CartaoTema(tema: tema) {
                            aoSelecionarTema(tema)
                        }
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
    }
}

struct CartaoTema: View {
    let tema: Tema
    let acao: () -> Void

    var body: some View {
        Button(action: acao) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: [.purple.opacity(0.8), .pink.opacity(0.8)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .frame(width: 52, height: 52)

                    Image(systemName: tema.icone)
                        .font(.title2)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(tema.nome)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(tema.perguntas.count) perguntas")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.15), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(EstiloBotaoEscala())
    }
}

struct EstiloBotaoEscala: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
