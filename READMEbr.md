# 🗄️ SQL — Guia de Banco de Dados

Referência prática de **SQL e MySQL** para trabalhar com bancos de dados relacionais: desde criação básica até JOINs, transações, views e índices.

---

## O que é SQL

**SQL** é a linguagem para bancos de dados relacionais. Com ela você consegue:

- Criar e alterar tabelas
- Inserir, consultar, atualizar e excluir dados
- Criar relacionamentos entre tabelas
- Filtrar, agrupar e analisar informações
- Controlar transações e criar views

---

## Estrutura básica

```text
Banco de Dados
      │
      ├── Tabelas
      │      ├── Colunas
      │      └── Registros
      │
      └── Relacionamentos (1:1, 1:N, N:N)
```

---

## Banco de Dados

| Comando           | O que faz                |
| ----------------- | ----------------------- |
| `CREATE DATABASE` | Cria um banco           |
| `DROP DATABASE`   | Deleta um banco         |
| `SHOW DATABASES`  | Lista os bancos         |
| `USE`             | Seleciona um banco      |

Criar e selecionar:

```sql
CREATE DATABASE loja;
USE loja;
```

Excluir (⚠️ remove tudo):

```sql
DROP DATABASE loja;
```

---

## Tabelas

| Comando             | Função                      |
| ------------------- | --------------------------- |
| `CREATE TABLE`      | Cria tabela                 |
| `ALTER TABLE`       | Modifica tabela             |
| `DROP TABLE`        | Deleta tabela               |
| `TRUNCATE`          | Limpa todos os registros    |
| `DESCRIBE`          | Mostra a estrutura          |

Exemplo básico:

```sql
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(150)
);
```

Adicionar coluna:

```sql
ALTER TABLE usuarios
ADD telefone VARCHAR(20);
```

Modificar coluna:

```sql
ALTER TABLE usuarios
MODIFY nome VARCHAR(200);
```

Renomear coluna:

```sql
ALTER TABLE usuarios
RENAME COLUMN nome TO nome_completo;
```

Limpar tabela (mantém estrutura):

```sql
TRUNCATE TABLE usuarios;
```

### DELETE vs TRUNCATE vs DROP

| Comando      | Remove dados | Mantém estrutura |
| ------------ | -----------: | ---------------: |
| `DELETE`     |            ✅ |               ✅ |
| `TRUNCATE`   |            ✅ |               ✅ |
| `DROP TABLE` |            ✅ |               ❌ |

---

## Tipos de dados

| Tipo       | Uso                      | Exemplo              |
| ---------- | ------------------------ | -------------------- |
| `INT`      | Números inteiros         | `100`                |
| `BIGINT`   | Inteiros grandes         | `999999999`          |
| `DECIMAL`  | Valores monetários       | `199.90`             |
| `FLOAT`    | Decimais                 | `10.5`               |
| `VARCHAR`  | Texto variável           | `'Eduardo'`          |
| `TEXT`     | Textos longos            | `'Descrição...'`     |
| `DATE`     | Data                     | `'2026-09-03'`       |
| `DATETIME` | Data e hora              | `'2026-09-03 13:30'` |
| `BOOLEAN`  | Verdadeiro/Falso         | `TRUE`               |
| `JSON`     | Dados JSON               | `'{"nome":"Edu"}'`   |

---

## Constraints (Regras)

Garantem a integridade dos dados:

| Constraint       | O que faz                        |
| ---------------- | -------------------------------- |
| `PRIMARY KEY`    | Identifica cada registro         |
| `FOREIGN KEY`    | Relaciona tabelas                |
| `UNIQUE`         | Impede valores duplicados        |
| `NOT NULL`       | Obriga preenchimento             |
| `DEFAULT`        | Valor padrão se não informado    |
| `CHECK`          | Valida uma condição              |
| `AUTO_INCREMENT` | Incrementa automaticamente       |

Exemplo:

```sql
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) CHECK (preco > 0),
    estoque INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'ativo'
);
```

---

## CRUD — As 4 operações básicas

### CREATE — Inserir

```sql
INSERT INTO usuarios (nome, email)
VALUES ('João', 'joao@email.com');
```

Vários registros:

```sql
INSERT INTO usuarios (nome, email)
VALUES
('João', 'joao@email.com'),
('Maria', 'maria@email.com'),
('Pedro', 'pedro@email.com');
```

### READ — Consultar

```sql
SELECT * FROM usuarios;
```

Colunas específicas:

```sql
SELECT nome, email FROM usuarios;
```

Com alias:

```sql
SELECT nome AS usuario FROM usuarios;
```

### UPDATE — Atualizar

```sql
UPDATE usuarios
SET nome = 'Carlos'
WHERE id = 1;
```

Vários campos:

```sql
UPDATE usuarios
SET nome = 'Carlos', email = 'carlos@email.com'
WHERE id = 1;
```

### DELETE — Excluir

```sql
DELETE FROM usuarios WHERE id = 5;
```

⚠️ Sempre use `WHERE` ou vai deletar tudo.

---

## Filtros e consultas

### WHERE

Filtra registros:

```sql
SELECT * FROM produtos
WHERE preco > 100;
```

Combinações:

```sql
SELECT * FROM produtos
WHERE preco >= 100 AND estoque > 0;
```

### Operadores

| Operador | Significado |
| -------- | ----------- |
| `=`      | Igual       |
| `<>`     | Diferente   |
| `>`      | Maior       |
| `<`      | Menor       |
| `>=`     | Maior igual |
| `<=`     | Menor igual |
| `AND`    | E           |
| `OR`     | Ou          |
| `NOT`    | Negação     |

### LIKE

Busca padrões de texto:

```sql
SELECT * FROM usuarios
WHERE nome LIKE 'Jo%';        -- começa com Jo

SELECT * FROM usuarios
WHERE nome LIKE '%Silva';     -- termina com Silva

SELECT * FROM usuarios
WHERE nome LIKE '%ana%';      -- contém ana
```

### IN

Valores de uma lista:

```sql
SELECT * FROM produtos
WHERE categoria_id IN (1, 2, 3);
```

### BETWEEN

Intervalo de valores:

```sql
SELECT * FROM produtos
WHERE preco BETWEEN 100 AND 500;
```

### NULL

```sql
SELECT * FROM usuarios
WHERE telefone IS NULL;

SELECT * FROM usuarios
WHERE telefone IS NOT NULL;
```

Nunca use `= NULL`.

### ORDER BY

Ordena resultados:

```sql
SELECT * FROM produtos
ORDER BY preco ASC;      -- crescente

SELECT * FROM produtos
ORDER BY preco DESC;     -- decrescente
```

### LIMIT

Limita resultados:

```sql
SELECT * FROM produtos
LIMIT 10;

SELECT * FROM produtos
ORDER BY preco DESC
LIMIT 5;  -- top 5 mais caros
```

### DISTINCT

Remove duplicados:

```sql
SELECT DISTINCT categoria_id FROM produtos;
```

---

## Relacionamentos

### 1:1 — Um para Um

Um registro se relaciona com apenas um de outra tabela.

```sql
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE perfis (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
```

O `UNIQUE` garante que cada usuário tem um perfil.

### 1:N — Um para Muitos

Um cliente pode ter vários pedidos.

```sql
CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100)
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```

### N:N — Muitos para Muitos

Alunos e cursos: um aluno faz vários cursos, um curso tem vários alunos.

Use uma tabela intermediária:

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
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);
```

---

## JOIN — Combinar tabelas

### INNER JOIN

Retorna apenas registros que existem nas duas tabelas.

```sql
SELECT clientes.nome, pedidos.id
FROM clientes
INNER JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

### LEFT JOIN

Todos os clientes, mesmo sem pedidos.

```sql
SELECT clientes.nome, pedidos.id
FROM clientes
LEFT JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

### RIGHT JOIN

Todos os pedidos, mesmo sem cliente.

```sql
SELECT clientes.nome, pedidos.id
FROM clientes
RIGHT JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

### Múltiplos JOINs

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

---

## Agregação

Funções que trabalham com vários registros:

| Função    | Resultado     |
| --------- | ------------- |
| `COUNT()` | Conta         |
| `SUM()`   | Soma          |
| `AVG()`   | Média         |
| `MAX()`   | Valor máximo  |
| `MIN()`   | Valor mínimo  |

Exemplos:

```sql
SELECT COUNT(*) AS total FROM usuarios;

SELECT SUM(preco) AS total FROM produtos;

SELECT AVG(preco) AS media FROM produtos;

SELECT MAX(preco) AS maior FROM produtos;

SELECT MIN(preco) AS menor FROM produtos;
```

---

## GROUP BY e HAVING

Agrupar e filtrar grupos:

```sql
SELECT
    categoria_id,
    COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria_id;
```

Filtrar grupos (use `HAVING`, não `WHERE`):

```sql
SELECT
    categoria_id,
    COUNT(*) AS quantidade
FROM produtos
GROUP BY categoria_id
HAVING COUNT(*) > 5;
```

**Diferença:** `WHERE` filtra registros antes do agrupamento. `HAVING` filtra grupos depois.

---

## Subqueries

Consulta dentro de consulta:

```sql
SELECT * FROM produtos
WHERE preco > (
    SELECT AVG(preco) FROM produtos
);
```

Retorna produtos acima da média.

### EXISTS

Verifica se uma subquery retorna algo:

```sql
SELECT * FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM pedidos p
    WHERE p.cliente_id = c.id
);
```

Clientes que têm pelo menos um pedido.

---

## UNION

Combina resultados de duas consultas:

```sql
SELECT nome FROM clientes
UNION
SELECT nome FROM fornecedores;
```

`UNION` remove duplicados. Use `UNION ALL` para manter.

---

## CASE

Condições dentro de SELECT:

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

---

## COALESCE

Substitui `NULL` por um valor:

```sql
SELECT
    nome,
    COALESCE(telefone, 'Não informado') AS telefone
FROM usuarios;
```

---

## INSERT INTO SELECT

Copiar dados de uma tabela para outra:

```sql
INSERT INTO usuarios_backup (nome, email)
SELECT nome, email FROM usuarios;
```

---

## Transactions

Executa operações como uma unidade única. Se algo falhar, tudo volta.

```sql
START TRANSACTION;

UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;

COMMIT;
```

Se algo deu errado:

```sql
ROLLBACK;
```

Conceito: ou tudo funciona, ou nada funciona.

---

## VIEW

Consulta armazenada que funciona como uma tabela virtual:

```sql
CREATE VIEW clientes_pedidos AS
SELECT
    clientes.nome,
    pedidos.id
FROM clientes
INNER JOIN pedidos
    ON pedidos.cliente_id = clientes.id;
```

Usar:

```sql
SELECT * FROM clientes_pedidos;
```

Deletar:

```sql
DROP VIEW clientes_pedidos;
```

---

## INDEX

Melhora a velocidade de buscas:

```sql
CREATE INDEX idx_email ON usuarios(email);
```

Único:

```sql
CREATE UNIQUE INDEX idx_email ON usuarios(email);
```

Remover:

```sql
DROP INDEX idx_email ON usuarios;
```

⚠️ Índices ocupam espaço e custam em INSERT/UPDATE/DELETE. Use com planejamento, principalmente em colunas de `WHERE`, `JOIN` e `ORDER BY`.

---

## ON DELETE / ON UPDATE

Controla o que acontece com registros relacionados:

```sql
FOREIGN KEY (cliente_id)
REFERENCES clientes(id)
ON DELETE CASCADE
ON UPDATE CASCADE
```

| Ação        | Faz                            |
| ----------- | ------------------------------ |
| `CASCADE`   | Deleta registros dependentes   |
| `RESTRICT`  | Impede a operação              |
| `SET NULL`  | Define FK como `NULL`          |

---

## Classificação de comandos

| Tipo  | O que faz                   | Exemplos                      |
| ----- | --------------------------- | ----------------------------- |
| **DDL** | Define estrutura | `CREATE`, `ALTER`, `DROP` |
| **DML** | Manipula dados | `INSERT`, `UPDATE`, `DELETE` |
| **DQL** | Consulta dados | `SELECT` |
| **TCL** | Controla transações | `COMMIT`, `ROLLBACK` |

---

## Exemplo: Loja Virtual

Modelo:

```
CLIENTES
    │
    ├─ PEDIDOS
         │
         ├─ ITENS_PEDIDO
              │
              └─ PRODUTOS
                  │
                  └─ CATEGORIAS
```

Criar banco e tabelas:

```sql
CREATE DATABASE loja;
USE loja;

CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (pedido_id, produto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
```

Consultas úteis:

```sql
-- Produtos com categoria
SELECT p.nome, c.nome AS categoria, p.preco
FROM produtos p
INNER JOIN categorias c ON p.categoria_id = c.id;

-- Clientes e pedidos
SELECT c.nome, COUNT(p.id) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON p.cliente_id = c.id
GROUP BY c.id;

-- Produtos acima da média
SELECT * FROM produtos
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- Classificar produtos por preço
SELECT
    nome, preco,
    CASE
        WHEN preco < 100 THEN 'Econômico'
        WHEN preco < 500 THEN 'Intermediário'
        ELSE 'Premium'
    END AS faixa
FROM produtos;
```

---

## Referência rápida

| Tarefa | Comando |
| --- | --- |
| Criar banco | `CREATE DATABASE` |
| Selecionar banco | `USE` |
| Criar tabela | `CREATE TABLE` |
| Alterar tabela | `ALTER TABLE` |
| Deletar tabela | `DROP TABLE` |
| Inserir dados | `INSERT` |
| Consultar | `SELECT` |
| Filtrar | `WHERE` |
| Atualizar | `UPDATE` |
| Deletar registro | `DELETE` |
| Ordenar | `ORDER BY` |
| Limitar | `LIMIT` |
| Agrupar | `GROUP BY` |
| Filtrar grupos | `HAVING` |
| Unir tabelas | `JOIN` |
| Contar | `COUNT()` |
| Somar | `SUM()` |
| Média | `AVG()` |
| Máximo | `MAX()` |
| Mínimo | `MIN()` |
| Condições | `CASE` |
| Substituir NULL | `COALESCE()` |
| Confirmar transação | `COMMIT` |
| Desfazer transação | `ROLLBACK` |
| Criar view | `CREATE VIEW` |
| Criar índice | `CREATE INDEX` |
