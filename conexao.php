<?
$server = "localhost";$user = "nome_do_usuario";$password ="senha_aqui", $dbname = "Nomedobanco";
//Criarei a conexao do php no mysql
$conn = new mysqli($server, $user, $password,$dbname);

//Aqui ficará a verificação de conexão ao banco de dados.
if(!$conn){
    die("Não houve conexão!".mysql_connect_error());
}else{echo"Conexão feita!!!";}

?>