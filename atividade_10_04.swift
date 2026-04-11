//
//  main.swift
//  Projeto_acompanhamenot_gabrielle
//
//  Created by Almeida, Gabrielle Alves de on 09/04/26.
//
import Foundation

enum OpcaoMenu: Int {
    case cadastrar = 1
    case listar = 2
    case alterar = 3
    case remover = 4
}

class Contato {
    public let id: String
    public var nome: String
    public var idade: Int
    public var telefone: Int
    public var email: String
    
    init(_ nome: String, _ idade: Int, _ telefone: Int, _ email: String) {
        self.id = UUID().uuidString
        self.nome = nome
        self.idade = idade
        self.telefone = telefone
        self.email = email
    }
    
    func descricao() -> String {
        return "\nCódigo de identificação: \(id) | Nome: \(nome) | Idade: \(idade) | Tel: \(telefone) | Email: \(email)"
    }
    public func mesmoNome(_ outroNome: String) -> Bool {
        nome.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        ==
        outroNome.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
}

class GerenciadorContatos {
    private var listaContatos: [Contato] = []
    
    func iniciar() {
        menu()
    }
    
    private func menu() {
        print("\nMenu - Escolha abaixo a tarefa desejada")
        print("0 - Digite 0 a qualquer momento para sair")
        print("1 - Cadastrar novo contato")
        print("2 - Listar contatos")
        print("3 - Alterar contato")
        print("4 - Remover contato")
        print("Escolha: ", terminator: "")
        
        guard let entrada = readLine(), let valor = Int(entrada) else {
            print("\nEntrada inválida.")
            menu()
            return
        }
        
        if valor == 0 { exit(0) }
        
        guard let opcao = OpcaoMenu(rawValue: valor) else {
            print("\nOpção inválida.")
            menu()
            return
        }
        
        switch opcao {
        case .cadastrar:
            Cadastrar()
        case .listar:
            Listar()
        case .alterar:
            Alterar()
        case .remover:
            Remover()
        }
    }
    
    
    private func readInfo() -> String{
        let info = readLine() ?? ""
        if ((Int(info) ?? 1)  == 0) { exit(0)}
        
        return info
    }
    
    private func Cadastrar() {
        print("Nome:",terminator: ""); let nome = readInfo()
        validarNome(nome)
        
        print("Idade:",terminator: ""); let idade = readInfo()
        validarInfo(idade)
        
        print("Telefone:",terminator: ""); let telefone = readInfo()
        validarInfo(telefone)
        
        print("Email:",terminator: ""); let email = readInfo()
        validarInfo(email)
        
        
        listaContatos.append(Contato(nome, Int(idade) ?? 0, Int(telefone) ?? 0, email))
        print("\nContato cadastrado com sucesso!")
        
        menu()
    }
    private func validarInfo(_ info:String){
        if info.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            print("Este campo não pode estar vazio, voce ira precisar recomeçar a operação")
            menu()
            return
        }
    }
    private func validarNome(_ nome:String){
        validarInfo(nome)
        let nomeJaExiste = listaContatos.contains { contato in
            contato.mesmoNome(nome)
        }
        
        if nomeJaExiste {
            print("\nEsse nome ja existe. Informe nome + sobrenome para diferenciar.")
            menu()
            return
        }
    }
    private func Listar() {
        if listaContatos.isEmpty {
            print("\nNenhum contato cadastrado.")
        } else {
            print("\n--- Contatos (\(listaContatos.count)) ---")
            listaContatos.forEach { print($0.descricao()) }
        }
        menu()
    }
    private func Alterar(){
        print("\nInsira o código de identificação contato:",terminator: ""); let idContato = readInfo()
        print("\nAguarde...")
        
        Thread.sleep(forTimeInterval: 3)
        guard let index = listaContatos.firstIndex(where: { $0.id == idContato }) else {
            print("\nNão encontrei :( tente novamente.")
            Alterar()
            return
        }
        
        print("\nEncontrei :), atualize as informações do contato a seguir:")
        
        print("Nome:",terminator: "");let nome  = readInfo()
        validarNome(nome)
        listaContatos[index].nome = nome
        
        print("Idade:",terminator: "");let idade = readInfo()
        validarInfo(idade)
        listaContatos[index].idade = Int(idade) ?? 0
        
        print("Telefone:",terminator: "");let telefone = readInfo()
        validarInfo(telefone)
        listaContatos[index].telefone = Int(telefone) ?? 0
        
        print("Email:",terminator: "");let email = readInfo()
        validarInfo(email)
        listaContatos[index].email = email
        
        
        
        print("\nContato atualizado!!")
        menu()
        
    }
    
    private func Remover(){
        
        listaContatos.forEach { print($0.descricao()) }
        
        print("\n Deseja remover um contato ? \nCopie o codigo identificador e insira a seguir:",terminator: ""); let idContato = readInfo()
        print("Aguarde...")
        
        Thread.sleep(forTimeInterval: 3)
        
        guard let index = listaContatos.firstIndex(where: { $0.id == idContato }) else {
            print("\nNão encontrei :( tente novamente.")
            menu()
            return
        }
        
        listaContatos.remove(at: index)
        
        print("Contato removido com sucesso!")
        menu()
    }
}


let app = GerenciadorContatos()
app.iniciar()



