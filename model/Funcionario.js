const Funcionario = sequelize.define('funcionario', {
    matricula: {
        type: Sequelize.INTERGER,
        field: 'matricula'
    },
    nome: {
        type: Sequelize.STRING,
        field: 'nome'
    },
    endereco: {
        type: Sequelize.STRING,
        field: 'endereco'       
    },
    cargaHora: {
        type: Sequelize.DATE,
        field: 'cargaHora'
    }
})