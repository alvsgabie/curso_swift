//
//  ContentView.swift
//  Atividade02-UI
//
//  Created by Almeida, Gabrielle Alves de on 27/04/26.
//

import SwiftUI

enum EstadoJogo {
    case selecionandoTema
    case jogando(Tema)
    case resultado(Tema, [Bool])
}

struct ContentView: View {
    @State private var estadoJogo: EstadoJogo = .selecionandoTema

    var body: some View {
        switch estadoJogo {
        case .selecionandoTema:
            SelecaoTemaView { tema in
                withAnimation(.easeInOut) {
                    estadoJogo = .jogando(tema)
                }
            }

        case .jogando(let tema):
            QuizView(tema: tema) { respostas in
                withAnimation(.easeInOut) {
                    estadoJogo = .resultado(tema, respostas)
                }
            }

        case .resultado(let tema, let respostas):
            ResultadoView(tema: tema, respostas: respostas) {
                withAnimation(.easeInOut) {
                    estadoJogo = .selecionandoTema
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
