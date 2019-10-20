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





module.exports = rota
