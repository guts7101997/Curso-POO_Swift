import Foundation

enum NivelAluno: String{
    case Iniciante = "Iniciante"
    case Intermediario = "Intermediário"
    case Avancado = "Avançado"
}

enum CategoriaAula: String{
    case musculacao = "Musculação"
    case spinning = "Spinning"
    case yoga = "Yoga"
    case funcional = "Funcional"
    case luta = "Luta"
}


class Plano{
    let nome: String
    let valor_mensal: Double
    let personal: Bool
    let limite_aula: Int
    let duracao: Int
    
    init(nome: String, valor: Double, personal: Bool, limite: Int, duracao: Int){
        self.nome = nome
        valor_mensal = valor
        self.personal = personal
        limite_aula = limite
        self.duracao = duracao
    }
}

class CatalogoP {
    static let mensal = Plano(
        nome: "Plano Mensal",
        valor: 120,
        personal: false,
        limite: 25,
        durcao: 1
    )

    static let trimestral = Plano(nome: "Plano Trimestral", valor: 680, personal: true, limite: 85, duracao: 3)

    static let anual = Plano(nome: "Plano Anual", valor: 1300, personal: true, limite: 350, duracao: 12)
}

class Pessoa{
    public let nome: String
    private let cpf: Int
    private let email: String

    init(nome: String, cpf: Int, email: String){
        self.nome = nome
        self.cpf = cpf
        self.email = email
    }

    public func descricao(){
        print("""
        Nome: \(self.nome)
        CPF: \(self.cpf)
        E-Mail: \(self.email)
        """)
    }
}

class Aluno: Pessoa{
    private let matricula: Int
    private var nivel: NivelAluno
    private var tipoAula: CategoriaAula
    private var plano: Plano

    init(nome: String, cpf: Int, email: String, matricula: Int, tipoAula: CategoriaAula, plano: Plano){
        self.matricula = matricula
        self.nivel = .Iniciante
        self.tipoAula = tipoAula
        self.plano = plano
        super.init(nome: nome, cpf: cpf, email: email)
    }

    override public func descricao(){
        print("""
        Nome: \(self.nome)
        CPF: \(self.cpf)
        E-Mail: \(self.email)
        Matricula: \(self.matricula)
        Nível: \(self.nivel)
        Aula matriculado: \(self.tipoAula)
        Plano: \(self.plano)
        """)
    }

    public func mudaPlano(novoPlano: Plano){
        self.plano = novoPlano
    }

    public func evoluiNivel() {
        switch self.nivel {
        case .Iniciante:
            self.nivel = .Intermediario
            print("Parabéns, \(self.nome)! Você agora é Intermediário.")
        case .Intermediario:
            self.nivel = .Avancado
            print("Incrível! Você atingiu o nível Avançado.")
        case .Avancado:
            print("Você já está no nível máximo!")
        }
    }
}

// um professor pode ter mais de uma especilidade, vou explorar isso nos outros dias
class Instrutor: Pessoa{
    private let especialidade: CategoriaAula

    init(nome: String, cpf: Int, email: String, especialidade: CategoriaAula) {
    self.especialidade = especialidade
    super.init(nome: nome, cpf: cpf, email: email)
    }

    override public func descricao() {
    print("""
        Nome: \(self.nome)
        CPF: \(self.cpf)
        E-Mail: \(self.email)
        Especialidade: \(self.especialidade)
        """)
    }
}