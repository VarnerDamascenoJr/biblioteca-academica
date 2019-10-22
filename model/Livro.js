const Livro = sequelize.define('livro', {
    ISBN: {
        type: Sequelize.INTERGER,
        field: 'ISBN'
    },
    titulo: {
        type: Sequelize.STRING,
        field: 'titulo'
    },
    anoLancamento: {
        type: Sequelize.DATE,
        field: 'anoLancamento'
    },
    autor: {
        type: Sequelize.STRING,
        field: 'autor'
    },
    editora: {
        type: Sequelize.STRING,
        field: 'editora'
    },
    coAutor: {
        type: Sequelize.STRING,
        field: 'coAutor'
    },
    quantLivro: {
        type: Sequelize.INTERGER,
        field: 'quantLivro'
    },
    dia_emprestimo: {
        type: Sequelize.DATE,
        field: 'dia_emprestimo'
    },
    dia_entrega: {
        type: Sequelize.DATE,
        field: 'dia_entrega'
    }
    
})