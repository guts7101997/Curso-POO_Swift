import Foundation

class Cofre{
    private var saldo: Double
    private var limite: Double
    private let id: Int
    private var nome: String
    private var tipo: TipoConta

    private enum TipoConta{
        case Básica
        case Intermediária
        case Avançada
    }

    private init(nome: String, id: Int, limite: Double, tipo: TipoConta){
        self.id = id
        self.nome = nome
        self.saldo = 0
        self.limite = limite
        self.tipo = .Básica
        if(self.limite <= 10000){
            self.tipo = .Avançada
        } else if (self.limite > 10000 && self.limite <= 5000) {
            self.tipo = .Intermediária
        } 
    }

    public func depositar(valor: Double){
        if (valor <= 0){
            print("O valor depositado não é válido. O saldo não foi alterado")
        } else {
            self.saldo += valor
        }
    }

    public func sacar(valor: Double){
        if (valor > self.saldo + self.limite || valor <= 0){
            print("Não é possível sacar essa quantia.")
        } else{
            self.saldo -= valor
        }
    }

    public func getSaldo() -> Double{
        return self.saldo
    }
}