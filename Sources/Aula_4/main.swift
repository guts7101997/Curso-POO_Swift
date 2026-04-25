class User{
    public let nome: String
    private let cpf: Int


    init(nome: String, cpf: Int){
        self.nome = nome
        self.cpf = cpf
    }

    public func getCPF() -> Int{
        return self.cpf
    }
}
class Conta: User{
    private var saldo: Double
    private var score: ScoreCategory
    private var email: String
    private var limite: Double
    private var tipoConta: TipoConta
    private var senha: String


    init(nome: String, cpf: Int, tipoConta: TipoConta, email: String, senha: String){
        self.email = email
        self.senha = senha
        self.tipoConta = tipoConta
        self.saldo = 0
        self.limite = 0
        score = .baixo

        super.init(nome: nome, cpf: cpf)

    }

    public func getSaldo() -> Double{
        return self.saldo
    }

    public func depositar(valor: Double){
        if valor > 0{
            self.saldo += valor
        } else {
            print("Não é possível depositar esse valor.")
        }
    }

    public func sacar(valor: Double){
        if valor > 0 && valor < self.saldo + self.limite{
            self.saldo -= valor
        } else {
            print("Não é possível sacar esse valor.")
        }
    }



    public func getEmail() -> String{
        return self.email
    }
    
    private func setEmail(novoEmail: String){
        self.email = novoEmail
    }

    public func setEmailSenha(senha: String, novoEmail: String){
        if senha == self.senha{
            setEmail(novoEmail: novoEmail)
        }
    }
    
    public func getScore() -> ScoreCategory{
        return self.score
    }

    public func setSenha(antigaSenha: String, senhaNova: String){
        if antigaSenha == self.senha {
            self.senha = senhaNova
        }
    }

    public func aumentarLimite(scoreNovo: ScoreCategory){
        switch scoreNovo{
            case .baixo:
                self.limite = 600
            case .medio:
                self.limite = 1200
            case .alto:
                self.limite = 2000
        }
    }
}


enum ScoreCategory{
    case baixo
    case medio
    case alto
    }

enum TipoConta{
    case corrente
    case poupanca
    }

var minhaConta = Conta(nome: "Gabriel", cpf: 11111, tipoConta: .corrente, email: "12mello", senha: "9876")