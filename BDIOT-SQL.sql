/* BDIOT-DTR: */

CREATE TABLE Veiculos (
    veiculo_id VARCHAR(30) PRIMARY KEY,
    modelo VARCHAR(100),
    marca VARCHAR(50),
    nivel_autonomia TINYINT,
    tipo_propulsao ENUM('Eletrico', 'Combustao', 'Hibrido'),
    data_fabricacao DATE
);

CREATE TABLE Configuracao_Sensores (
    config_id BIGINT PRIMARY KEY,
    nome_sensor VARCHAR(50),
    versao_hardware VARCHAR(20),
    ultima_calibracao DATETIME,
    fk_Veiculos_veiculo_id VARCHAR(30)
);

CREATE TABLE Telemetrias (
    leitura_id BIGINT PRIMARY KEY,
    timestamp DATETIME,
    quilometragem_km DECIMAL(10, 2),
    velocidade_kph DECIMAL(5, 2),
    nivel_bateria_pct TINYINT,
    nivel_combustivel_pct TINYINT,
    tempo_ativo_segundos INT,
    fk_Veiculos_veiculo_id VARCHAR(30)
);

CREATE TABLE Diagnostico_Sensores (
    diagnostico_id BIGINT PRIMARY KEY,
    nome_sensor VARCHAR(50),
    status_sensor ENUM('OK', 'Degradado', 'Falha'),
    taxa_erros_pct DECIMAL(5, 3),
    cod_falha VARCHAR(20),
    temp_operacao_c DECIMAL(4, 1),
    fk_Telemetrias_leitura_id BIGINT
);
 
ALTER TABLE Configuracao_Sensores ADD CONSTRAINT FK_Configuracao_Sensores_2
    FOREIGN KEY (fk_Veiculos_veiculo_id)
    REFERENCES Veiculos (veiculo_id)
    ON DELETE RESTRICT;
 
ALTER TABLE Telemetrias ADD CONSTRAINT FK_Telemetrias_2
    FOREIGN KEY (fk_Veiculos_veiculo_id)
    REFERENCES Veiculos (veiculo_id)
    ON DELETE CASCADE;
 
ALTER TABLE Diagnostico_Sensores ADD CONSTRAINT FK_Diagnostico_Sensores_2
    FOREIGN KEY (fk_Telemetrias_leitura_id)
    REFERENCES Telemetrias (leitura_id)
    ON DELETE RESTRICT;
