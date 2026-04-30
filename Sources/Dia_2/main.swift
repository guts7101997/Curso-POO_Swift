import Foundation

protocol Manutencao {
    var nomeItem: String {get}
    var historico: String {get}

    func realizarReparo(data: String, estaEmDia: Bool) -> Bool
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
        let status: String = "Consertado"

        historico.append("\(data) - \(status)")
        print("Maquina concertada!")
        return true
    }

    func reportarErro(data: String){
        estaFuncionando = false
        print("Erro reportado")
        let status: String = "Quebrado"
        historico.append("\(data) - \(status)")
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
    var capacidadeMinima: Int
    private var alunosInscritos: [Aluno] = []
    var numInscritos: Int {
        return alunosInscritos.count
    }

    init(nome: String, instrutor: Instrutor, categoria: CategoriaAula, descricao: String, capacidadeMaxima: Int, capacidadeMinima: Int){
        self.nome = nome
        self.instrutor = instrutor
        self.categoria = categoria
        self.descricao = descricao
        self.capacidadeMaxima = capacidadeMaxima
        self.capacidadeMinima = capacidadeMinima
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

    public func podeAula() -> Bool{
        if self.numInscritos < capacidadeMinima{
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
//talvez jogar isso no dia 3
    public func agendarHorario(horario: String) -> Bool{
        if instrutor.getHorarios().contains(horario){
            print("Não é possível fazer aula nesse horário, busque outro horário ou outro personal")
            return false
        }
        print("Aula agendada com o personal \(self.instrutor.nome)")
        self.instrutor.addHorarios(horario)
        return true

    }
}