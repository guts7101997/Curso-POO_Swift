extension Gerenciamento {
    
    func gerarRelatorioMetricas() {
        print("\n==================================")
        print("DASHBOARD DE MÉTRICAS GERAIS")
        print("==================================")
        print("Total de Alunos: \(self.alunos.count)")
        print("Total de Instrutores: \(self.instrutores.count)")
        print("Aulas Coletivas Ativas: \(self.turmas.count)")
        
        let totalDanificados = self.aparelhos.filter { $0.estaQuebrado }.count
        print("Equipamentos Danificados: \(totalDanificados)")
        print("==================================\n")
    }
}

let central = GerenciadorAcademia()

let planoMensal = CatalogoP.mensal
let planoAnual = CatalogoP.anual

let alunoBeto = Aluno(nome: "Beto", cpf: 11, email: "beto@email.com", matricula: 101, plano: planoMensal, aulaInicial: .musculacao)
let alunoAna = Aluno(nome: "Ana VIP", cpf: 22, email: "ana@email.com", matricula: 102, plano: planoAnual, aulaInicial: .yoga)
let instrutorLeo = Instrutor(nome: "Leonardo", cpf: 99, email: "leo@gym.com", especialidade: .luta)

print("--- [Teste 1: Admissão] ---")
central.matricularAluno(alunoBeto)
central.matricularAluno(alunoAna)
central.matricularAluno(alunoBeto) 

print("\n--- [Teste 2: Agendamento Personal] ---")
central.cadastrarInstrutor(instrutorLeo)

print("Tentativa Aluno Mensal:")
central.agendarPersonal(matricula: 101, cpfInstrutor: 99)

print("\nTentativa Aluno Anual:")
central.agendarPersonal(matricula: 102, cpfInstrutor: 99)

print("\n--- [Teste 3: Superlotação] ---")
let salaLuta = TurmaColetiva(nome: "Luta Iniciante", categoria: .luta, capacidade: 1)
salaLuta.inscrever(aluno: alunoAna)  
salaLuta.inscrever(aluno: alunoBeto)  

print("\n--- [Teste 4: Manutenção Global] ---")
let bike = Equipamento(id: 50, nome: "Bike Ergométrica")
bike.estaQuebrado = true 
central.adicionarEquipamento(bike)
central.realizarManutencaoGlobal() 

print("\n--- [Teste 5: Polimorfismo] ---")
let membros: [Pessoa] = [alunoBeto, instrutorLeo]
for membro in membros {
    membro.descricao() 
}

central.gerarRelatorioMetricas()