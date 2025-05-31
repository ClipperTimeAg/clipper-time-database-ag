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
