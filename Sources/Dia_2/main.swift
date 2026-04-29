import Foundation

protocol Manutencao {
    var nomeItem: String {get}
    var historico: String {get}

    func realizarReparo(data: String) -> Bool
    func estaEmDia() -> Bool
}

class Aparelho: Manutencao{
    let nomeItem: String
    private(set) var historico: [String] = []
    private let id: Int
    private(set) var estaFuncionando: Bool = true

    init(nome: String){
        nomeItem = nome
        id = Int.random(in:100...600)
    }

    func realizarReparo(data: String, estaemDia: Bool) -> Bool {
        guard estaemDia else{
            print("Maquina quebrada. Reparo não é possível.")
            return false
        }
        
        historico.append(data)
        print("Maquina concertada!")
        return true
    }

    func reportarErro(){
        estaFuncionando = false
    }
}
protocol Aula {
    var nome: String
    var instrutor: Instrutor
    var categoria: CategoriaAula
    var descricao: String
}

class turmasColetiva: Aula{
    var nome: String
    var instrutor: Instrutor
    var categoria: CategoriaAula
    var descricao: String
    var numInscritos: Int 
    var capacidadeMaxima: Int
    private var alunosInscritos: [Aluno] = []
    var numInscritos: Int {
        return alunosInscritos.count
    }

    init(nome: String, instrutor: Instrutor, categoria: CategoriaAula, descricao: String, capacidadeMaxima: Int){
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
        self.capacidadeMaxima = capacidadeMaxima
        self.numInscritos = 0
    }

    public func inscrever(aluno: Aluno){
        if controlaInscricao(aluno: aluno) == false{
            print("Não é possível se inscrever nessa aula. Busque outro horario.")
        } else {
            print("Inscrição confirmada. Boa aula!")
            alunosInscritos.append(aluno)
        }
    }

    private func controlaInscricao(aluno: Aluno) -> Bool{
        if (numInscritos + 1) > capacidadeMaxima{
            return false
        } 
        if alunosInscritos.contains(where: { $0 === aluno }) {
            print("O aluno \(aluno.nome) já está inscrito nesta turma.")
            return false
        }
        
        return true
    }
}

class treinoPersonal{
    var nome: String
    var instrutor: Instrutor
    var categoria: CategoriaAula
    var descricao: String

    init(nome: String, instrutor: Instrutor, categoria: CategoriaAula, descricao: String){
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
    }
}