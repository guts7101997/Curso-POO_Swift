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
    var aulasFeitas: Int = 0
    let limites_modalidade: Int
    
    init(nome: String, valor: Double, personal: Bool, limite: Int, duracao: Int, limite_modalidades: Int){
        self.nome = nome
        valor_mensal = valor
        self.personal = personal
        limite_aula = limite
        self.duracao = duracao
        self.limites_modalidade = limites_modalidade
    }

    public func checkIn(){
        if podeFazerAula() {        
            print("Check-in realizado. Boa aula!")
            aulasFeitas += 1}

        print("Você atingiu o limite de aulas do seu plano.")
    }

    public func podeFazerAula() -> Bool {
        if aulasFeitas + 1 > limite_aula{
            return false
        } 
        return true 
    }
}

class CatalogoP {
    static let mensal = Plano(
        nome: "Plano Mensal",
        valor: 120,
        personal: false,
        limite: 25,
        durcao: 1,
        limite_modalidades: 1
    )

    static let trimestral = Plano(nome: "Plano Trimestral", valor: 680, personal: true, limite: 85, duracao: 3, limite_modalidades: 2)

    static let anual = Plano(nome: "Plano Anual", valor: 1300, personal: true, limite: 350, duracao: 12, limite_modalidades: 4)
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
    private var aulas_matriculado: Set<CategoriaAula>
    private var plano: Plano

    init(nome: String, cpf: Int, email: String, matricula: Int, primeiraAula: CategoriaAula, plano: Plano){
        self.matricula = matricula
        self.nivel = .Iniciante
        self.aulas_matriculado = [primeiraAula]
        self.plano = plano
        super.init(nome: nome, cpf: cpf, email: email)
    }

    public func getMatricula() -> Int{
        return self.matricula
    }

    public func getNivel() -> NivelAluno{
        return self.nivel
    }

    public func getTipoAula() -> CategoriaAula{
        return self.tipoAula
    }

    public func getPlano() -> Plano{
        return self.plano
    }

    public func getAulas() -> Set<CategoriaAula> {
        return self.aulasMatriculadas
    }

    override public func descricao(){
        let listaAulas = aulasMatriculadas.map { $0.rawValue }.joined(separator: ", ")
        print("""
        Nome: \(self.nome)
        CPF: \(self.cpf)
        E-Mail: \(self.email)
        Matricula: \(self.matricula)
        Nível: \(self.nivel.rawValue)
        Aula matriculado: \(listaAulas)
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

    public func adicionarAula(novaAula: CategoriaAula) {
    if aulasMatriculadas.count >= self.plano.limite_modalidades {
        print("Seu plano permite apenas \(plano.limite_modalidades) modalidades.")
    } else {
        print("\(self.nome) agora também está matriculado em \(novaAula.rawValue)")
        aulasMatriculadas.insert(novaAula)
        }
    }

    public func removerAula(aula: CategoriaAula) {
        if aulasMatriculadas.count > 1 {
            aulasMatriculadas.remove(aula)
        } else {
            print("O aluno deve estar matriculado em pelo menos uma aula.")
        }
    }

}


class Instrutor: Pessoa {
    private var especialidades: Set<CategoriaAula> 
    private var horarios: Set<String> = []

    init(nome: String, cpf: Int, email: String, primeiraEspecialidade: CategoriaAula) {
        self.especialidades = [primeiraEspecialidade]
        super.init(nome: nome, cpf: cpf, email: email)
    }

    public func getHorarios() -> [String] {
        return self.horarios.sorted()
    }

    public func addHorarios(horario: String){
        self.horarios.insert(horario)
    }

    public func adicionarEspecialidade(nova: CategoriaAula) {
        especialidades.insert(nova)
        print("Agora o instrutor \(self.nome) também pode dar aulas de \(nova.rawValue).")
    }

    public func podeDarAula(categoria: CategoriaAula) -> Bool {
        return especialidades.contains(categoria)
    }

    override public func descricao() {
        let lista = especialidades.map { $0.rawValue }.joined(separator: ", ")
        
        print("""
        Nome: \(self.nome)
        CPF: \(self.cpf)
        E-Mail: \(self.email)
        Especialidades: \(lista)
        """)
    }

}
