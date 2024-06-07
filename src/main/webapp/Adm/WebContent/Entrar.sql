CREATE TABLE registros_login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    horario_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
