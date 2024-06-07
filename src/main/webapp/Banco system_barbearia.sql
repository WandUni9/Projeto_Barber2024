create database system_barbearia;
use system_barbearia;

select * from agendamento;

DROP TABLE IF EXISTS agendamento;

CREATE TABLE agendamento (
    id INT(25) AUTO_INCREMENT PRIMARY KEY,
    data_agenda DATETIME NOT NULL,
    especialista CHAR(50) NOT NULL,
    nome_cliente VARCHAR(50) NOT NULL,
    tipo_servico CHAR(50) NOT NULL,
    valor_servico CHAR(40) NOT NULL,
    celular CHAR(25) NOT NULL
);


ALTER TABLE agendamento
ADD COLUMN nome VARCHAR(50) NOT NULL AFTER especialista;

ALTER TABLE agendamento
CHANGE COLUMN nome nome_cliente VARCHAR(50) NOT NULL;

ALTER TABLE agendamento
MODIFY COLUMN nome_cliente VARCHAR(50);

ALTER TABLE agendamento
MODIFY COLUMN nome_cliente VARCHAR(50) NOT NULL;

INSERT INTO agendamento (data_agenda, especialista, tipo_servico, valor_servico, celular)
VALUES ('2024-04-06 10:00:00', 'Dr. João', 'Consulta', '100.00', '123456789');

INSERT INTO agendamento (data_agenda, especialista, tipo_servico, valor_servico, celular)
VALUES ('2024-04-06 11:00:00', 'Seu Madruga', 'corte e barba', 'R$ 60,00', '123456789');

INSERT INTO agendamento (data_agenda, especialista, nome_cliente, tipo_servico, valor_servico, celular)
VALUES ('2024-04-06 11:00:00', 'Seu Madruga', 'Aline', 'barba', 'R$ 60,00', '0000000');

INSERT INTO agendamento (data_agenda, especialista, nome_cliente, tipo_servico, valor_servico, celular)
VALUES ('2024-04-07 11:00:00', 'Hommer', 'Mateus', 'corte ', 'R$ 35,00', '123456789');

INSERT INTO agendamento (data_agenda, especialista, nome_cliente, tipo_servico, valor_servico, celular)
VALUES ('2024-04-07 11:00:00', 'Seu Madruga', 'Christyan', 'corte e barba', 'R$ 60,00', '123456789');

INSERT INTO agendamento (data_agenda, especialista, nome_cliente, tipo_servico, valor_servico, celular)
VALUES ('2024-04-07 11:00:00', 'Seu Madruga', 'José', 'corte  ', 'R$ 60,00', '123456789');
