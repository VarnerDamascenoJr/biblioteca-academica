const mysql = require('mysql')
var conn = mysql.createConnection({
    host: 'localhost',
    user: 'varner',
    password: 'varner',
    database: 'biblioteca'
})

conn.connection((err) => {
    console.log('Database connected!')
    if(err) throw err;
       console.log('Database not connected!') 
})