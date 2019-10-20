var Aluno = sequelize.define('aluno', {
    matricula: {
        type: Sequelize.INTEGER,
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
    data_Entrada: {
        type: Sequelize.DATE,
        field: 'data_Entrada'
    },
    data_Saida: {
        type: Sequelize.DATE,
        field: 'data_Saida'
    }

})

//Aluno.sync({force: true})