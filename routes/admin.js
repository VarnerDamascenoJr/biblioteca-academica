const express = require('express')
const mysql   = require('mysql')
const rota   = express.Router()

var con = mysql.createConnection({
    host:'localhost',
    user:'varner',
    password:'varner',
    database:'biblioteca'
})

rota.get('/', (req, res)=>{
    res.render('./admin/aluno/aluno')
})


rota.get('/aluno', (req, res)=>{
   con.query('SELECT*FROM aluno', (err, rows, fields)=>{
        if(!err)
        res.send(rows)
        else
        console.log(err)
    })        
})

rota.get('/aluno/add', (req, res)=>{
    res.render('./admin/aluno/alunoadd')
})
rota.post('/aluno/novo', (req, res)=>{
       var erros = []
if(!req.body.nome || typeof req.body.nome == null || req.body.nome == undefined){ erros.push({texto: 'Erro com o nome!'})}
if(req.body.nome == '%' || typeof req.body.nome == '#' || req.body.nome == '*'
|| req.body.nome == '!' || req.body.nome == '@' || req.body.nome == '&' || req.body.nome == '+' || req.body.nome == '-')
{ erros.push({texto:'Por favor, não use caractere especial!'})} 
if(!req.body.telefone     || typeof req.body.telefone == null    || req.body.telefone == undefined){ erros.push({texto: 'Corrija o campo para telefone.'})}
if(req.body.telefone < 11 || typeof req.body.telefone[0] == null || req.body.telefone[1] == null){erros.push({texto: 'Corrija o DDD. Verifique se o número está inserido corretamente.'})}
if(erros.length > 0){ res.render('/')}
else{ 
    const novoAluno = {
        matricula : req.body.matricula,
        nome : req.body.nome,
        data_Entrada : req.body.data_Entrada,
        data_Saida : req.body.data_Saida,
        telefone : req.body.telefone
    }

    new Aluno(novoAluno).conn("INSERT INTO database VALUES()").then(() => { 
        req.flash('success_msg', 'Aluno salvo com sucesso.')
        res.redirect('/')
    }).catch((err) => {
        req.flash('error_msg', 'Falha interna ao salvar Aluno.')
        console.log('Não foi possível salvar.'+err)
    })
}
})

// rotas para professor
rota.get('/professor', (req, res)=>{
    res.render('./admin/professor/professor')

})

rota.get('/professor/add', (req, res)=>{
    res.render('./admin/professor/professoradd')
})

rota.get('/', (req, res)=>{
    res.render('./admin/professoredit')
})

//rotas para livro.
rota.post('/livro', (req, res) => {


})
rota.get('/livro/add', (req, res) => {
    res.render('./admin/livroadd')
})

rota.post('/livro/novo', (req, res) => {
           var erros = []

if(!req.body.ISBN || typeof req.body.ISBN == null || req.body.ISBN == undefined){ erros.push({texto: 'Corrija o campo para ISBN.'})}
if(!req.body.titulo || typeof req.body.titulo == null || req.body.titulo == undefined) { erros.push({texto: 'Corrija o campo de título.'})}
if(!req.body.autor || typeof req.body.autor == null || req.body.autor == undefined){ erros.push({texto: 'Corrija o campo do nome do autor.'})}
if(data_Entrada < data_Saida){ erros.push({texto: 'Digite a data corretamente.'})}
if(erros.length > 0){res.render('./path')}

else{
//aqui para cadastrar novo livro
}
})

// rotas para funcionario
rota.get('/funcionario', (req, res) => {
    res.render('./admin/funcionario')
})

rota.get('/funcionario/add', (req, res) => {
    res.render('./admin/funcionario/funcionarioadd')
})

rota.post('/funcionario/novo', (req, res) => {
   var erros = []
if(!req.body.matricula || typeof req.body.matricula == null || req.body.matricula == undefined){ erros.push({texto:'Corrija o campo da matrícula.'})}
if(!req.body.nome      || typeof req.body.nome      == null || req.body.nome      == undefined){ erros.push({texto:'Corrija o campo do nome.'})}
if(!req.body.endereco  || typeof req.body.endereco  == null || req.body.endereco  == undefined){ erros.push({texto:'Corrija o campo de endereço.'})}
if(!req.body.cargaHora || typeof req.body.cargaHora == null || req.body.cargaHora == undefined){ erros.push({texto:'Corrija o campo de carga horária.'})}
if(erros.length > 0){ res.render('')}
else{
   
}
})

module.exports = rota
