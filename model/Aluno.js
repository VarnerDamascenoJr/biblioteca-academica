var Aluno = sequelize.define('aluno', {
    matricula: {
        type: Sequelize.Number,
        field: 'matricula'
    },
    nome: {
        type: Sequelize.String,
        field: 'nome'
    },
    endereco: {
        type: Sequelize.String,
        field: 'endereco'
    },
    data_Entrada: {
        type: Sequelize.Date,
        field: 'data_Entrada'
    },
    data_Saida: {
        type: Sequelize.Date,
        field: 'data_Saida'
    }

})