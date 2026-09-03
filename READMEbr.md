# 🗄️ SQL — Guia Completo de Banco de Dados

> Guia prático de **SQL e MySQL**, desenvolvido para consulta, estudo e aplicação em projetos reais de banco de dados.

Este material apresenta desde a criação de um banco de dados até operações mais avançadas, como **relacionamentos, JOINs, agregações, subqueries, transações, views, índices e transferência de dados**.

---

---

# 🧠 1. Introdução

**SQL (Structured Query Language)** é uma linguagem utilizada para trabalhar com bancos de dados relacionais.

Com SQL é possível:

* Criar bancos de dados
* Criar e alterar tabelas
* Inserir informações
* Consultar dados
* Atualizar registros
* Excluir registros
* Criar relacionamentos
* Realizar consultas entre várias tabelas
* Agrupar e analisar informações
* Controlar transações
* Criar views e índices

### Fluxo básico

```text
Banco de Dados
      │
      ├── Tabelas
      │      │
      │      ├── Colunas
      │      └── Registros
      │
      └── Relacionamentos
             │
             ├── 1:1
             ├── 1:N
             └── N:N
```

---

# 🗃️ 2. Banco de Dados

## Principais comandos

| Comando           | Função             | Exemplo                 |
| ----------------- | ------------------ | ----------------------- |
| `CREATE DATABASE` | Cria um banco      | `CREATE DATABASE loja;` |
| `DROP DATABASE`   | Exclui um banco    | `DROP DATABASE loja;`   |
| `SHOW DATABASES`  | Lista os bancos    | `SHOW DATABASES;`       |
| `USE`             | Seleciona um banco | `USE loja;`             |

### Criar banco

```sql
CREATE DATABASE loja;
```

### Selecionar banco

```sql
USE loja;
```

### Listar bancos

```sql
SHOW DATABASES;
```

### Excluir banco

```sql
DROP DATABASE loja;
```

> ⚠️ `DROP DATABASE` remove o banco e todas as suas tabelas.

---

# 📋 3. Tabelas

| Comando             | Função                                 |
| ------------------- | -------------------------------------- |
| `CREATE TABLE`      | Cria uma tabela                        |
| `ALTER TABLE`       | Altera uma tabela existente            |
| `DROP TABLE`        | Exclui uma tabela                      |
| `TRUNCATE`          | Remove todos os registros              |
| `DESCRIBE`          | Mostra a estrutura da tabela           |
| `SHOW CREATE TABLE` | Mostra o SQL usado para criar a tabela |

## CREATE TABLE

```sql
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(150)
);
```

## ALTER TABLE

Adicionar coluna:

```sql
ALTER TABLE usuarios
ADD telefone VARCHAR(20);
```

Alterar coluna:

```sql
ALTER TABLE usuarios
MODIFY nome VARCHAR(200);
```

Renomear coluna:

```sql
ALTER TABLE usuarios
RENAME COLUMN nome TO nome_completo;
```

## DROP TABLE

```sql
DROP TABLE usuarios;
```

Remove a tabela completamente.

## TRUNCATE

```sql
TRUNCATE TABLE usuarios;
```

Remove todos os registros, mantendo a estrutura da tabela.

### DROP x TRUNCATE

| Comando      | Remove dados | Remove tabela |
| ------------ | -----------: | ------------: |
| `DELETE`     |            ✅ |             ❌ |
| `TRUNCATE`   |            ✅ |             ❌ |
| `DROP TABLE` |            ✅ |             ✅ |

## DESCRIBE

```sql
DESCRIBE usuarios;
```

## SHOW CREATE TABLE

```sql
SHOW CREATE TABLE usuarios;
```

---

# 🔤 4. Tipos de Dados

| Tipo       | Utilização            | Exemplo                 |
| ---------- | --------------------- | ----------------------- |
| `INT`      | Números inteiros      | `100`                   |
| `BIGINT`   | Inteiros grandes      | `999999999`             |
| `DECIMAL`  | Valores monetários    | `199.90`                |
| `FLOAT`    | Números decimais      | `10.5`                  |
| `CHAR`     | Texto de tamanho fixo | `'BR'`                  |
| `VARCHAR`  | Texto variável        | `'Eduardo'`             |
| `TEXT`     | Textos longos         | `'Descrição...'`        |
| `DATE`     | Data                  | `'2026-09-03'`          |
| `DATETIME` | Data e hora           | `'2026-09-03 13:30:00'` |
| `TIME`     | Horário               | `'13:30:00'`            |
| `BOOLEAN`  | Verdadeiro/Falso      | `TRUE`                  |
| `JSON`     | Dados JSON            | `'{"nome":"Edu"}'`      |

### Exemplo

```sql
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT,
    criado_em DATETIME
);
```

---

# 🔒 5. Constraints

Constraints são regras aplicadas às colunas para manter a **integridade dos dados**.

| Constraint       | Função                            |
| ---------------- | --------------------------------- |
| `PRIMARY KEY`    | Identifica cada registro          |
| `FOREIGN KEY`    | Cria relacionamento entre tabelas |
| `UNIQUE`         | Impede valores duplicados         |
| `NOT NULL`       | Impede valores nulos              |
| `DEFAULT`        | Define um valor padrão            |
| `CHECK`          | Valida uma condição               |
| `AUTO_INCREMENT` | Gera números automaticamente      |

## PRIMARY KEY

```sql
id INT PRIMARY KEY AUTO_INCREMENT
```

Cada registro possui um identificador único.

## FOREIGN KEY

```sql
usuario_id INT,

FOREIGN KEY (usuario_id)
REFERENCES usuarios(id)
```

Relaciona uma tabela com outra.

## UNIQUE

```sql
email VARCHAR(150) UNIQUE
```

Não permite dois usuários com o mesmo email.

## NOT NULL

```sql
nome VARCHAR(100) NOT NULL
```

O campo precisa receber um valor.

## DEFAULT

```sql
status VARCHAR(20) DEFAULT 'ativo'
```

Caso nenhum valor seja informado:

```text
status = ativo
```

## CHECK

```sql
idade INT CHECK (idade >= 18)
```

## AUTO_INCREMENT

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

Exemplo:

```text
1
2
3
4
5
...
```

---

# ➕ 6. INSERT

Utilizado para inserir registros.

```sql
INSERT INTO usuarios (nome, email)
VALUES ('João', 'joao@email.com');
```

Inserindo vários registros:

```sql
INSERT INTO usuarios (nome, email)
VALUES
('João', 'joao@email.com'),
('Maria', 'maria@email.com'),
('Pedro', 'pedro@email.com');
```

---

# 🔎 7. SELECT

Usado para consultar dados.

```sql
SELECT * FROM usuarios;
```

Selecionar colunas específicas:

```sql
SELECT nome, email
FROM usuarios;
```

Criar alias:

```sql
SELECT nome AS usuario
FROM usuarios;
```

---

# 🎯 8. WHERE

Filtra registros.

```sql
SELECT *
FROM usuarios
WHERE id = 1;
```

Outro exemplo:

```sql
SELECT *
FROM produtos
WHERE preco > 100;
```

---

# ⚙️ 9. Operadores

| Operador | Significado    |
| -------- | -------------- |
| `=`      | Igual          |
| `<>`     | Diferente      |
| `!=`     | Diferente      |
| `>`      | Maior          |
| `<`      | Menor          |
| `>=`     | Maior ou igual |
| `<=`     | Menor ou igual |
| `AND`    | E              |
| `OR`     | Ou             |
| `NOT`    | Negação        |

### Exemplo

```sql
SELECT *
FROM produtos
WHERE preco >= 100
AND estoque > 0;
```

---

# 🔤 10. LIKE

Pesquisa padrões de texto.

| Símbolo | Função                            |
| ------- | --------------------------------- |
| `%`     | Qualquer quantidade de caracteres |
| `_`     | Um único caractere                |

### Começa com

```sql
SELECT *
FROM usuarios
WHERE nome LIKE 'Jo%';
```

### Termina com

```sql
SELECT *
FROM usuarios
WHERE nome LIKE '%Silva';
```

### Contém

```sql
SELECT *
FROM usuarios
WHERE nome LIKE '%ana%';
```

---

# 📌 11. IN

Verifica se um valor pertence a uma lista.

```sql
SELECT *
FROM produtos
WHERE categoria_id IN (1, 2, 3);
```

Equivale a:

```sql
WHERE categoria_id = 1
   OR categoria_id = 2
   OR categoria_id = 3;
```

---

# 📅 12. BETWEEN

Pesquisa valores dentro de um intervalo.

```sql
SELECT *
FROM produtos
WHERE preco BETWEEN 100 AND 500;
```

Também pode ser usado com datas:

```sql
SELECT *
FROM pedidos
WHERE data_pedido
BETWEEN '2026-01-01' AND '2026-12-31';
```

---

# ❓ 13. NULL

`NULL` representa ausência de valor.

### Encontrar valores nulos

```sql
SELECT *
FROM usuarios
WHERE telefone IS NULL;
```

### Encontrar valores preenchidos

```sql
SELECT *
FROM usuarios
WHERE telefone IS NOT NULL;
```

> Não utilize `= NULL`.

Use:

```sql
IS NULL
```

ou:

```sql
IS NOT NULL
```

---

# ↕️ 14. ORDER BY

Ordena resultados.

### Crescente

```sql
SELECT *
FROM produtos
ORDER BY preco ASC;
```

### Decrescente

```sql
SELECT *
FROM produtos
ORDER BY preco DESC;
```

---

# 🔢 15. LIMIT

Limita a quantidade de resultados.

```sql
SELECT *
FROM produtos
LIMIT 10;
```

Exemplo com ordenação:

```sql
SELECT *
FROM produtos
ORDER BY preco DESC
LIMIT 5;
```

---

# 🔀 16. DISTINCT

Remove valores duplicados.

```sql
SELECT DISTINCT categoria_id
FROM produtos;
```

---

# ✏️ 17. UPDATE

Atualiza registros existentes.

```sql
UPDATE usuarios
SET nome = 'Carlos'
WHERE id = 1;
```

Atualizando vários campos:

```sql
UPDATE usuarios
SET nome = 'Carlos',
    email = 'carlos@email.com'
WHERE id = 1;
```

> ⚠️ Sempre tenha cuidado com `UPDATE` sem `WHERE`.

---

# 🗑️ 18. DELETE

Remove registros.

```sql
DELETE FROM usuarios
WHERE id = 5;
```

Remover todos:

```sql
DELETE FROM usuarios;
```

### DELETE x TRUNCATE

| Característica                    | DELETE | TRUNCATE |
| --------------------------------- | ------ | -------- |
| Remove registros                  | ✅      | ✅        |
| Pode usar `WHERE`                 | ✅      | ❌        |
| Mantém tabela                     | ✅      | ✅        |
| É útil para exclusões específicas | ✅      | ❌        |

---

# 🔗 19. Relacionamentos

Relacionamentos representam como as tabelas se conectam.

---

## 1:1 — Um para Um

Um registro possui relação com apenas um registro da outra tabela.

```text
USUARIO
   │
   │ 1:1
   ▼
PERFIL
```

Exemplo:

```sql
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE perfis (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT UNIQUE,

    FOREIGN KEY (usuario_id)
    REFERENCES usuarios(id)
);
```

O `UNIQUE` impede que um usuário tenha vários perfis.

---

## 1:N — Um para Muitos

Um registro possui vários registros relacionados.

```text
CLIENTE
   │
   ├── PEDIDO
   ├── PEDIDO
   └── PEDIDO
```

Exemplo:

```sql
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,

    FOREIGN KEY (cliente_id)
    REFERENCES clientes(id)
);
```

Um cliente pode ter vários pedidos.

---

## N:1 — Muitos para Um

É a visão inversa do relacionamento `1:N`.

```text
PEDIDO ──────► CLIENTE
   N              1
```

Vários pedidos pertencem a um cliente.

---

## N:N — Muitos para Muitos

Vários registros de uma tabela podem se relacionar com vários registros de outra.

Exemplo:

```text
ALUNOS
  │
  │
  ▼
MATRICULAS
  ▲
  │
  │
CURSOS
```

Tabela intermediária:

```sql
CREATE TABLE alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE cursos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE matriculas (
    aluno_id INT,
    curso_id INT,

    PRIMARY KEY (aluno_id, curso_id),

    FOREIGN KEY (aluno_id)
    REFERENCES alunos(id),

    FOREIGN KEY (curso_id)
    REFERENCES cursos(id)
);
```

> Em bancos relacionais, o relacionamento `N:N` normalmente é implementado utilizando uma **tabela associativa/intermediária**.

---

# 🔗 20. JOIN

`JOIN` combina informações de diferentes tabelas.

---

## INNER JOIN

Retorna somente registros que possuem correspondência nas duas tabelas.

```sql
SELECT
    clientes.nome,
    pedidos.id
FROM clientes
INNER JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

```text
CLIENTE ───── PEDIDO
    │            │
    └──── JOIN ──┘
```

---

## LEFT JOIN

Retorna todos os registros da tabela da esquerda.

```sql
SELECT
    clientes.nome,
    pedidos.id
FROM clientes
LEFT JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

Mesmo clientes sem pedidos aparecerão.

---

## RIGHT JOIN

Retorna todos os registros da tabela da direita.

```sql
SELECT
    clientes.nome,
    pedidos.id
FROM clientes
RIGHT JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

---

## Múltiplos JOINs

É possível conectar várias tabelas.

```sql
SELECT
    clientes.nome,
    pedidos.id,
    produtos.nome
FROM clientes

INNER JOIN pedidos
    ON pedidos.cliente_id = clientes.id

INNER JOIN itens_pedido
    ON itens_pedido.pedido_id = pedidos.id

INNER JOIN produtos
    ON produtos.id = itens_pedido.produto_id;
```

### Estrutura

```text
CLIENTE
   │
   ▼
PEDIDO
   │
   ▼
ITEM_PEDIDO
   │
   ▼
PRODUTO
```

---

# 📊 21. Agregação

Funções de agregação trabalham com vários registros.

| Função    | Função          |
| --------- | --------------- |
| `COUNT()` | Conta registros |
| `SUM()`   | Soma valores    |
| `AVG()`   | Calcula média   |
| `MAX()`   | Maior valor     |
| `MIN()`   | Menor valor     |

### COUNT

```sql
SELECT COUNT(*) AS total
FROM usuarios;
```

### SUM

```sql
SELECT SUM(preco) AS total
FROM produtos;
```

### AVG

```sql
SELECT AVG(preco) AS media
FROM produtos;
```

### MAX

```sql
SELECT MAX(preco) AS maior
FROM produtos;
```

### MIN

```sql
SELECT MIN(preco) AS menor
FROM produtos;
```

---

# 📦 22. GROUP BY

Agrupa registros.

```sql
SELECT
    categoria_id,
    COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria_id;
```

Resultado conceitual:

```text
categoria | quantidade
----------|-----------
1         | 10
2         | 5
3         | 8
```

---

# 🎯 23. HAVING

Filtra grupos criados pelo `GROUP BY`.

```sql
SELECT
    categoria_id,
    COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria_id
HAVING COUNT(*) > 5;
```

### WHERE x HAVING

| Comando  | Filtra                         |
| -------- | ------------------------------ |
| `WHERE`  | Registros antes do agrupamento |
| `HAVING` | Grupos depois do agrupamento   |

---

# 🧩 24. Subqueries

Uma subquery é uma consulta dentro de outra consulta.

Exemplo:

```sql
SELECT *
FROM produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM produtos
);
```

Essa consulta retorna produtos cujo preço está acima da média.

### Estrutura

```text
SELECT principal
      │
      └── Subquery
             │
             └── Calcula a média
```

---

# 🔍 25. EXISTS

Verifica se uma subconsulta retorna algum resultado.

```sql
SELECT *
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.id
);
```

Retorna clientes que possuem pelo menos um pedido.

---

# 🔀 26. UNION

Combina resultados de duas consultas.

```sql
SELECT nome
FROM clientes

UNION

SELECT nome
FROM fornecedores;
```

As consultas precisam possuir quantidade e tipos de colunas compatíveis.

### UNION ALL

```sql
SELECT nome
FROM clientes

UNION ALL

SELECT nome
FROM fornecedores;
```

`UNION` remove duplicados.

`UNION ALL` mantém duplicados.

---

# 🔀 27. CASE

Permite criar condições dentro do `SELECT`.

```sql
SELECT
    nome,
    preco,

    CASE
        WHEN preco < 100 THEN 'Barato'
        WHEN preco < 500 THEN 'Médio'
        ELSE 'Caro'
    END AS classificacao

FROM produtos;
```

Resultado:

```text
Produto     Preço     Classificação
------------------------------------
Mouse       50        Barato
Teclado     200       Médio
Monitor     900       Caro
```

---

# 🧱 28. COALESCE

Retorna o primeiro valor que não seja `NULL`.

```sql
SELECT
    nome,
    COALESCE(telefone, 'Não informado') AS telefone
FROM usuarios;
```

Se `telefone` for `NULL`, será mostrado:

```text
Não informado
```

---

# 📋 29. Cópia de Dados

É possível copiar dados de uma tabela para outra.

## INSERT INTO SELECT

```sql
INSERT INTO usuarios_backup
SELECT *
FROM usuarios;
```

Também podemos selecionar colunas específicas:

```sql
INSERT INTO usuarios_backup (nome, email)
SELECT nome, email
FROM usuarios;
```

### Exemplo prático

Tabela original:

```text
usuarios
```

Tabela de backup:

```text
usuarios_backup
```

Processo:

```text
usuarios
    │
    │ SELECT
    ▼
usuarios_backup
```

---

# 🚚 30. Transferência de Dados

É possível mover registros de uma tabela para outra.

Primeiro copiamos:

```sql
INSERT INTO usuarios_ativos (nome, email)
SELECT nome, email
FROM usuarios
WHERE status = 'ativo';
```

Depois removemos os registros originais:

```sql
DELETE FROM usuarios
WHERE status = 'ativo';
```

### Forma segura

Esse tipo de operação é um ótimo candidato para uma **transaction**:

```sql
START TRANSACTION;

INSERT INTO usuarios_ativos (nome, email)
SELECT nome, email
FROM usuarios
WHERE status = 'ativo';

DELETE FROM usuarios
WHERE status = 'ativo';

COMMIT;
```

Se houver algum problema:

```sql
ROLLBACK;
```

---

# 💳 31. Transactions

Transactions permitem executar várias operações como uma única unidade.

Principais comandos:

| Comando             | Função                |
| ------------------- | --------------------- |
| `START TRANSACTION` | Inicia transaction    |
| `COMMIT`            | Confirma alterações   |
| `ROLLBACK`          | Desfaz alterações     |
| `SAVEPOINT`         | Cria ponto de retorno |

### Exemplo

```sql
START TRANSACTION;

UPDATE contas
SET saldo = saldo - 100
WHERE id = 1;

UPDATE contas
SET saldo = saldo + 100
WHERE id = 2;

COMMIT;
```

Se ocorrer um erro:

```sql
ROLLBACK;
```

### Conceito

```text
START TRANSACTION
       │
       ├── UPDATE
       ├── UPDATE
       ├── INSERT
       │
       ▼
    COMMIT
       │
       ▼
Alterações confirmadas
```

---

# 👁️ 32. VIEW

Uma `VIEW` é uma consulta armazenada que pode ser utilizada como uma tabela virtual.

### Criar

```sql
CREATE VIEW clientes_pedidos AS

SELECT
    clientes.nome,
    pedidos.id
FROM clientes

INNER JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

Consultar:

```sql
SELECT *
FROM clientes_pedidos;
```

Excluir:

```sql
DROP VIEW clientes_pedidos;
```

### Vantagens

* Simplificar consultas complexas
* Reutilizar consultas
* Facilitar relatórios
* Controlar quais colunas serão expostas

---

# ⚡ 33. INDEX

Índices ajudam o banco de dados a localizar registros com mais eficiência.

### Criar índice

```sql
CREATE INDEX idx_email
ON usuarios(email);
```

### Índice único

```sql
CREATE UNIQUE INDEX idx_email
ON usuarios(email);
```

### Remover

```sql
DROP INDEX idx_email
ON usuarios;
```

### Quando utilizar?

Índices são especialmente importantes em colunas frequentemente utilizadas em:

```sql
WHERE
JOIN
ORDER BY
```

> ⚠️ Índices não são gratuitos: ocupam espaço e podem aumentar o custo de `INSERT`, `UPDATE` e `DELETE`. Devem ser utilizados de forma planejada.

---

# 🔄 34. ON DELETE / ON UPDATE

Controlam o comportamento de uma `FOREIGN KEY` quando o registro relacionado é alterado ou excluído.

### CASCADE

```sql
FOREIGN KEY (cliente_id)
REFERENCES clientes(id)
ON DELETE CASCADE
ON UPDATE CASCADE
```

Se o cliente for excluído, seus registros dependentes também serão.

### RESTRICT

```sql
ON DELETE RESTRICT
```

Impede a exclusão quando existem registros relacionados.

### SET NULL

```sql
ON DELETE SET NULL
```

Define a chave estrangeira como `NULL`.

A coluna precisa aceitar `NULL`.

### Resumo

| Ação        | Comportamento                                          |
| ----------- | ------------------------------------------------------ |
| `CASCADE`   | Propaga alteração/exclusão                             |
| `RESTRICT`  | Impede operação                                        |
| `SET NULL`  | Define FK como `NULL`                                  |
| `NO ACTION` | Mantém comportamento de restrição conforme o mecanismo |

---

# 🧩 35. CRUD

CRUD representa as quatro operações fundamentais de manipulação de dados.

| CRUD       | SQL      | Operação  |
| ---------- | -------- | --------- |
| **C**reate | `INSERT` | Criar     |
| **R**ead   | `SELECT` | Consultar |
| **U**pdate | `UPDATE` | Atualizar |
| **D**elete | `DELETE` | Excluir   |

### CREATE

```sql
INSERT INTO usuarios (nome, email)
VALUES ('João', 'joao@email.com');
```

### READ

```sql
SELECT *
FROM usuarios;
```

### UPDATE

```sql
UPDATE usuarios
SET nome = 'Carlos'
WHERE id = 1;
```

### DELETE

```sql
DELETE FROM usuarios
WHERE id = 1;
```

---

# 🏗️ 36. DDL / DML / DQL / TCL

Os comandos SQL podem ser classificados em grupos.

| Categoria | Significado                  | Principais comandos                   |
| --------- | ---------------------------- | ------------------------------------- |
| **DDL**   | Data Definition Language     | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DML**   | Data Manipulation Language   | `INSERT`, `UPDATE`, `DELETE`          |
| **DQL**   | Data Query Language          | `SELECT`                              |
| **TCL**   | Transaction Control Language | `COMMIT`, `ROLLBACK`, `SAVEPOINT`     |

### DDL

Trabalha com a estrutura do banco:

```sql
CREATE TABLE produtos (...);
ALTER TABLE produtos ...;
DROP TABLE produtos;
```

### DML

Trabalha com os dados:

```sql
INSERT INTO produtos ...;

UPDATE produtos ...;

DELETE FROM produtos ...;
```

### DQL

Consulta informações:

```sql
SELECT *
FROM produtos;
```

### TCL

Controla transações:

```sql
START TRANSACTION;

UPDATE produtos
SET estoque = estoque - 1
WHERE id = 1;

COMMIT;
```

---

# 🚀 37. Projeto Final

Para colocar todos os conceitos em prática, podemos construir um pequeno sistema de **loja virtual**.

## Modelo

```text
                    ┌──────────────┐
                    │   CLIENTES   │
                    └──────┬───────┘
                           │
                           │ 1:N
                           ▼
                    ┌──────────────┐
                    │   PEDIDOS    │
                    └──────┬───────┘
                           │
                           │ 1:N
                           ▼
                  ┌──────────────────┐
                  │  ITENS_PEDIDO    │
                  └────────┬─────────┘
                           │
                           │ N:1
                           ▼
                    ┌──────────────┐
                    │   PRODUTOS   │
                    └──────┬───────┘
                           │
                           │ N:1
                           ▼
                    ┌──────────────┐
                    │  CATEGORIAS  │
                    └──────────────┘
```

---

## Criar banco

```sql
CREATE DATABASE loja;

USE loja;
```

---

## Criar categorias

```sql
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);
```

---

## Criar produtos

```sql
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    categoria_id INT,

    FOREIGN KEY (categoria_id)
    REFERENCES categorias(id)
);
```

---

## Criar clientes

```sql
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);
```

---

## Criar pedidos

```sql
CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (cliente_id)
    REFERENCES clientes(id)
);
```

---

## Criar itens do pedido

```sql
CREATE TABLE itens_pedido (
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (pedido_id, produto_id),

    FOREIGN KEY (pedido_id)
    REFERENCES pedidos(id),

    FOREIGN KEY (produto_id)
    REFERENCES produtos(id)
);
```

---

# 📊 Consultas do projeto

### Produtos com suas categorias

```sql
SELECT
    produtos.nome AS produto,
    categorias.nome AS categoria,
    produtos.preco
FROM produtos

INNER JOIN categorias
    ON produtos.categoria_id = categorias.id;
```

### Clientes e seus pedidos

```sql
SELECT
    clientes.nome,
    pedidos.id AS pedido
FROM clientes

LEFT JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

### Quantidade de pedidos por cliente

```sql
SELECT
    clientes.nome,
    COUNT(pedidos.id) AS total_pedidos
FROM clientes

LEFT JOIN pedidos
    ON pedidos.cliente_id = clientes.id

GROUP BY clientes.id;
```

### Produtos mais caros que a média

```sql
SELECT *
FROM produtos
WHERE preco > (
    SELECT AVG(preco)
    FROM produtos
);
```

### Classificação dos produtos

```sql
SELECT
    nome,
    preco,

    CASE
        WHEN preco < 100 THEN 'Econômico'
        WHEN preco < 500 THEN 'Intermediário'
        ELSE 'Premium'
    END AS categoria_preco

FROM produtos;
```

---

# 🧭 Fluxo de aprendizado

```text
SQL
 │
 ├── Fundamentos
 │    ├── Banco de dados
 │    ├── Tabelas
 │    ├── Tipos de dados
 │    └── Constraints
 │
 ├── Manipulação
 │    ├── INSERT
 │    ├── UPDATE
 │    └── DELETE
 │
 ├── Consultas
 │    ├── SELECT
 │    ├── WHERE
 │    ├── LIKE
 │    ├── IN
 │    ├── BETWEEN
 │    ├── ORDER BY
 │    └── LIMIT
 │
 ├── Relacionamentos
 │    ├── 1:1
 │    ├── 1:N
 │    ├── N:1
 │    └── N:N
 │
 ├── Consultas avançadas
 │    ├── JOIN
 │    ├── GROUP BY
 │    ├── HAVING
 │    ├── Subqueries
 │    ├── EXISTS
 │    ├── UNION
 │    ├── CASE
 │    └── COALESCE
 │
 ├── Banco de dados avançado
 │    ├── Transactions
 │    ├── Views
 │    ├── Indexes
 │    ├── ON DELETE
 │    └── ON UPDATE
 │
 └── Projeto
      └── Sistema completo
```

---

# 📌 Resumo rápido

| Operação               | Comando             |
| ---------------------- | ------------------- |
| Criar banco            | `CREATE DATABASE`   |
| Selecionar banco       | `USE`               |
| Criar tabela           | `CREATE TABLE`      |
| Alterar tabela         | `ALTER TABLE`       |
| Excluir tabela         | `DROP TABLE`        |
| Limpar tabela          | `TRUNCATE`          |
| Inserir                | `INSERT`            |
| Consultar              | `SELECT`            |
| Filtrar                | `WHERE`             |
| Atualizar              | `UPDATE`            |
| Excluir                | `DELETE`            |
| Ordenar                | `ORDER BY`          |
| Limitar                | `LIMIT`             |
| Agrupar                | `GROUP BY`          |
| Filtrar grupos         | `HAVING`            |
| Relacionar tabelas     | `JOIN`              |
| Contar                 | `COUNT`             |
| Somar                  | `SUM`               |
| Média                  | `AVG`               |
| Maior valor            | `MAX`               |
| Menor valor            | `MIN`               |
| Consulta interna       | `Subquery`          |
| Verificar existência   | `EXISTS`            |
| Unir consultas         | `UNION`             |
| Condições              | `CASE`              |
| Substituir `NULL`      | `COALESCE`          |
| Copiar dados           | `INSERT ... SELECT` |
| Confirmar transaction  | `COMMIT`            |
| Desfazer transaction   | `ROLLBACK`          |
| Criar consulta virtual | `VIEW`              |
| Melhorar buscas        | `INDEX`             |

---

# 🧠 Conceito final

Um banco de dados bem estruturado não depende apenas de saber escrever comandos SQL.

É necessário entender:

```text
        MODELAGEM
            │
            ▼
        ESTRUTURA
            │
            ▼
      RELACIONAMENTOS
            │
            ▼
       INTEGRIDADE
            │
            ▼
        CONSULTAS
            │
            ▼
       PERFORMANCE
            │
            ▼
        SEGURANÇA
```

O objetivo é construir bancos que sejam:

* **Consistentes**
* **Escaláveis**
* **Performáticos**
* **Seguros**
* **Fáceis de manter**
* **Bem relacionados**

---

> **SQL não é apenas consultar dados. É saber estruturar, relacionar, manipular e garantir a integridade das informações.**
