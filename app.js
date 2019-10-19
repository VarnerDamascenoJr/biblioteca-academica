const express = require('express')
const handlebars = require('express-handlebars')
const app     = express()
const bodyParser = require('body-parser')
const path       = require('path') 
const admin = require('./routes/admin')
const mysql = require('mysql')
//SETTING
    //SESSION
    //MIDDLEWARE
    //BODY-PARSER

    app.use(bodyParser.urlencoded({extended: true}))
    app.use(bodyParser.json())
    //HANDLEBARS

    app.engine('handlebars', handlebars({defaultLayout: 'main'}))
    app.set('view engine', 'handlebars')

    //DATABASE -> MYSQL
    var con = mysql.createConnection({
        host:'localhost',
        user:'varner',
        password:'varner',
        database:'biblioteca'
    })

   /*     con.connect((err)=>{
            if(err) throw err;
            console.log("Connected to DataBase.")})
          //    var sql = "SELECT*FROM pessoa"
         // con.query(sql, (err, result)=>{
        // if(err) throw err;
       // console.log("1 dado inserido")
      // })
     // })*/
    
     app.get('/alunos', (req, res)=>{
        con.query('SELECT*FROM aluno', (err, rows, fields)=>{
            if(!err)
            res.send(rows)
            else
            console.log(err)
        })
    })
    


    //PUBLIC
    app.use(express.static(path.join(__dirname, "public")))
    //ROUTES
    app.use('/admin', admin)

   


const PORT = 8081
app.listen(PORT, (req, res)=>{
    console.log("Server connected.")
})
