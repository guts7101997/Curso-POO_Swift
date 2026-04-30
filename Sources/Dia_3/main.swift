import Foundation

class Gerenciamento{
    private var alunos: [Int: Aluno] = [:]
    private var instrutores: [Int: Instrutor] = [:]
    private var aparelhos: [Int: Aparelho] = [:]
    private var aulas_coletivas: [String: TurmasColetivas] = [:]
    private var aulas_personal: [TreinoPersonal] = []

    func matricularAluno(novoAluno: Aluno) -> Bool {
        if alunos[novoAluno.getMatricula()] != nil {
            print("Erro: Matrícula \(novoAluno.getMatricula()) já existe.")
            return false
        }
        
        let existeEmailDuplicado = alunos.values.contains(where: { alunoExistente in
            return alunoExistente.email == novoAluno.email})

        if existeEmailDuplicado {
            print("Erro: E-mail já cadastrado no sistema.")
            return false
        } 
        
        alunos[novoAluno.getMatricula()] = novoAluno
        print("Aluno \(novoAluno.nome) matriculado com sucesso!")
        return true
    }

    func desmatricularAluno(matriculaAluno: Int){
        if alunos[matriculaAluno] == nil {
            print("Não foi possível encontrar aluno com essa matrícula.")
        } 

        alunos[matriculaAluno] = nil
        print("O aluno de matricula \(matriculaAluno) foi desligado da academia.")
    }

    func registrarAparelho(novoAparelho: Aparelho){
        if aparelhos[novoAparelho.getID()] != nil{
            print("Este aparelho já esta cadastrado.")
        }

        aparelhos[novoAparelho.getID()] = novoAparelho
        print("Aparelho registrado com sucesso.")
    }

    func removerAparelho(idAparelho: Int){
        if aparelhos[idAparelho] == nil{
            print("Não foi encontrado aparelho com esse ID.")
        }

        aparelhos[idAparelho] = nil
        print("Aparelho de ID \(idAparelho) removido com sucesso.")

    }

    func realizarManutencao(){
        var aparelhosDanificados: [Aparelho] = []
        for aparelho in aparelhos {
            if !aparelho.estaFuncionando{
                aparelhosDanificados.append(aparelho)
            }
        }

        if aparelhosDanificados.isEmpty {
            print("Todos os aparelhos estão em dia!")
        } else {
            aparelhosDanificados.forEach { aparelho in 
            print("Aparelho: \(aparelho.nome) - ID: \(aparelho.id)")}
        }
    }

    func agendarSessaoPersonal(matriculaAluno: Int, cpfInstrutor: Int, horario: String) {
        guard let aluno = alunos[matriculaAluno] else {
            print("Erro: Aluno com matrícula \(matriculaAluno) não encontrado.")
            return
        }

        guard let instrutor = instrutores[cpfInstrutor] else {
            print("Erro: Instrutor não localizado no sistema.")
            return
        }

        let planoDoAluno = aluno.getPlano()

        if planoDoAluno.personal {
            confirmarAgendamento(aluno: aluno, instrutor: instrutor)
        } else {
            print("Agendamento Negado: O aluno \(aluno.nome) possui o '\(planoDoAluno.nome)', que não possui acesso a personal trainer.")
        }
    }

    private func confirmarAgendamento(aluno: Aluno, instrutor: Instrutor, treinoPersonal: TreinoPersonal) {
        if treinoPersonal.agendarHorario(horario: horario, aluno: aluno){
            aulas_personal.append(treinoPersonal)
            print("Sucesso! Agendamento consolidado para \(aluno.nome) com o instrutor \(instrutor.nome).")
        }

        print("Não foi possível se inscrever nesse horário.")
    }

    func agendarTurmaColetiva(matriculaAluno: Int, nomeAula: String){
        guard let aluno = alunos[matriculaAluno] else {
            print("Erro: Aluno com matrícula \(matriculaAluno) não encontrado.")
            return
        }

        guard let nomeAula = aulas_coletivas[nomeAula] else {
            print("Erro: Aula coletiva não localizado no sistema.")
            return
        }

        if !nomeAula.inscrever(aluno: aluno){
            print("Não foi possível se inscrever nessa aula.")
        }

        print("Inscrição efetuada. Boa aula!")
    }
}
