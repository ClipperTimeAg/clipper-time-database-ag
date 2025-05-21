CREATE DATABASE clipper_time_ag
DEFAULT CHARACTER SET = utf8mb4
DEFAULT COLLATE = utf8mb4_unicode_ci;

USE clipper_time_ag;

CREATE TABLE usuarios (
  user_id       INT AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(100)         NOT NULL,
  email         VARCHAR(150)         NOT NULL UNIQUE,
  password_hash VARCHAR(255)         NOT NULL,
  phone         VARCHAR(20),
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                  ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;
  
 -- Cosultando 1° Registro
 SELECT * FROM USUARIOS WHERE 1=1;

CREATE TABLE profissionais (
  professional_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id         INT            NOT NULL,
  bio             TEXT,
  specialties     VARCHAR(100),
  rating          DECIMAL(2,1)   CHECK (rating BETWEEN 0.0 AND 5.0),
  FOREIGN KEY (user_id)
    REFERENCES usuarios(user_id)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE servicos (
  service_id   INT AUTO_INCREMENT PRIMARY KEY,
  name         VARCHAR(100)         NOT NULL,
  description  TEXT,
  duration_min INT,
  price        DECIMAL(8,2)         NOT NULL
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;
  
CREATE TABLE agendamentos (
  appointment_id   INT AUTO_INCREMENT PRIMARY KEY,
  user_id          INT            NOT NULL,
  professional_id  INT            NOT NULL,
  service_id       INT            NOT NULL,
  start_time       DATETIME       NOT NULL,
  end_time         DATETIME       NOT NULL,
  status           ENUM('A','C','R') DEFAULT 'A',
  created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id)        
    REFERENCES usuarios(user_id),
  FOREIGN KEY (professional_id)
    REFERENCES profissionais(professional_id),
  FOREIGN KEY (service_id)      
    REFERENCES servicos(service_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE produtos (
  id_produto   INT AUTO_INCREMENT PRIMARY KEY,
  nome         VARCHAR(50)         NOT NULL,
  descricao    VARCHAR(150),
  situacao     VARCHAR(10),
  preco        DECIMAL(6,2)        NOT NULL,
  service_id   INT,
  FOREIGN KEY (service_id)
    REFERENCES servicos(service_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE avaliacoes (
  avail_id        INT AUTO_INCREMENT PRIMARY KEY,
  professional_id INT            NOT NULL,
  dia_semana      DATE,
  hora_inicio     TIME,
  hora_fim        TIME,
  FOREIGN KEY (professional_id)
    REFERENCES profissionais(professional_id)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- ============================================  
-- Inserindo primeiros registros manualmente
-- ============================================  

START TRANSACTION; 

-- 1) usuarios 
INSERT INTO usuarios(name,email,password_hash,phone)
VALUES 
('Anderson Ramos'
  ,'an2767394@gmail.com'
  ,'100000$dd292a51cd972a9beb2431bb931b7169$78615e31e1a24f3316bdc17474da312ceb63b9e1900fb176ef56a9127819d197'
  ,'(11) 93930-2000'
);

-- 2) profissionais
INSERT INTO profissionais (user_id, bio, specialties, rating)
VALUES
  (1, 'Barbeiro experiente em cortes clássicos e modernos, especialista em barba e bigode.', 'Corte, Barba, Bigode', 4.9);

-- 3) servicos
INSERT INTO servicos (name, description, duration_min, price)
VALUES
  ('Corte de Cabelo', 'Corte de cabelo masculino com estilo personalizado.', 45, 50.00),
  ('Barba', 'Ajuste e modelagem da barba com navalha e máquina.', 30, 40.00),
  ('Corte + Barba', 'Combo com corte de cabelo e barba.', 75, 85.00);
  
-- 4) agendamentos
INSERT INTO agendamentos (user_id, professional_id, service_id, start_time, end_time, status)
VALUES
  (1, 1, 3, '2025-05-20 10:00:00', '2025-05-20 11:15:00', 'A');

-- 5) produtos
INSERT INTO produtos (nome, descricao, situacao, preco, service_id)
VALUES
  ('Pomada Modeladora', 'Pomada para fixação média com brilho natural.', 'ativo', 35.00, NULL),
  ('Óleo para Barba', 'Óleo hidratante para barba e pele.', 'ativo', 45.00, NULL),
  ('Kit Barba Completo', 'Conjunto com óleo, shampoo e balm para barba.', 'ativo', NULL, NULL);

-- 6) avaliacoes
INSERT INTO avaliacoes (professional_id, dia_semana, hora_inicio, hora_fim)
VALUES
  (1, '2025-05-21', '09:00:00', '18:00:00');

COMMIT;    

-- Result Final para Validação 
SELECT * FROM usuarios;
SELECT * FROM profissionais;
SELECT * FROM servicos;
SELECT * FROM agendamentos;
SELECT * FROM produtos;
SELECT * FROM avaliacoes;
