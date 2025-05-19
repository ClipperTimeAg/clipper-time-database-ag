# Clipper Time AG Database

Este repositório contém o esquema e scripts SQL para criação do banco de dados do site **Clipper Time AG**, uma plataforma para gerenciamento de barbearia, incluindo profissionais, serviços, agendamentos, produtos e avaliações.

---

## 🗂️ Estrutura de Tabelas

### 1. `usuarios`

> **Tabela de usuários da aplicação**

* `user_id` (INT, PK, AI) — Identificador único
* `nome` (VARCHAR) — Nome completo
* `email` (VARCHAR) — E-mail de acesso
* `senha` (VARCHAR) — Senha criptografada

### 2. `profissionais`

> **Dados dos barbeiros**

* `professional_id` (INT, PK, AI) — Identificador do profissional
* `user_id` (INT, FK) — Referência a `usuarios(user_id)`
* `bio` (TEXT) — Descrição e histórico
* `specialties` (VARCHAR) — Especialidades (corte, barba, etc.)
* `rating` (DECIMAL) — Avaliação média (0.0 a 5.0)

### 3. `servicos`

> **Catálogo de serviços**

* `service_id` (INT, PK, AI) — Identificador do serviço
* `name` (VARCHAR) — Nome do serviço
* `description` (TEXT) — Detalhes do serviço
* `duration_min` (INT) — Duração em minutos
* `price` (DECIMAL) — Valor cobrado

### 4. `agendamentos`

> **Registros de agendamentos**

* `appointment_id` (INT, PK, AI)
* `user_id` (INT, FK) — Cliente (`usuarios`)
* `professional_id` (INT, FK) — Barbeiro (`profissionais`)
* `service_id` (INT, FK) — Tipo de serviço (`servicos`)
* `start_time` (DATETIME) — Início do atendimento
* `end_time` (DATETIME) — Fim do atendimento
* `status` (ENUM) — Status: `A` (Agendado), `C` (Concluído), `R` (Cancelado)
* `created_at` / `updated_at` (TIMESTAMP) — Controle de versão

### 5. `produtos`

> **produtos para venda**

* `id_produto` (INT, PK, AI)
* `nome` (VARCHAR)
* `descricao` (VARCHAR)
* `situacao` (VARCHAR) — Ex.: `ativo`, `inativo`
* `preco` (DECIMAL)
* `service_id` (INT, FK, opcional) — Produto vinculado a serviço específico

### 6. `avaliacoes`

> **Avaliações do atendimento/estrutra oferecida**

* `avail_id` (INT, PK, AI)
* `professional_id` (INT, FK)
* `dia_semana` (DATE)
* `hora_inicio` (TIME)
* `hora_fim` (TIME)
