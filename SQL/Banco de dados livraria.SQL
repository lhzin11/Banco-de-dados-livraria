-- Excluindo o Banco de Dados se já existir
DROP DATABASE IF EXISTS Livraria;

-- Criação do Banco de Dados
CREATE DATABASE Livraria;
USE Livraria;

-- Criação da Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

-- Criação da Tabela Editora
CREATE TABLE Editora (
    idEditora INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

-- Criação da Tabela Livro
CREATE TABLE Livro (
    idLivro INT PRIMARY KEY,
    idEditora INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    ano INT NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idEditora) REFERENCES Editora(idEditora)
);

-- Criação da Tabela Estoque
CREATE TABLE Estoque (
    idLivro INT PRIMARY KEY,
    quantidade INT NOT NULL,
    FOREIGN KEY (idLivro) REFERENCES Livro(idLivro)
);

-- Criação da Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    idCliente INT NOT NULL,
    dataPedido DATE NOT NULL,
    valorPedido DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Criação da Tabela ItemPedido
CREATE TABLE ItemPedido (
    idPedido INT NOT NULL,
    idLivro INT NOT NULL,
    quantidade INT NOT NULL,
    valorItemPedido DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (idPedido, idLivro),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idLivro) REFERENCES Livro(idLivro)
);
SELECT COUNT(*) AS QuantidadeLivros
FROM Livro;
SELECT nome
FROM Cliente
ORDER BY nome ASC;
SELECT e.nome AS NomeEditora, l.titulo AS TituloLivro
FROM Editora e
JOIN Livro l ON e.idEditora = l.idEditora
ORDER BY e.nome DESC;
SELECT e.nome AS NomeEditora, AVG(l.preco) AS MediaPreco
FROM Editora e
JOIN Livro l ON e.idEditora = l.idEditora
GROUP BY e.nome;
SELECT 
    c.nome AS Nome_Cliente,
    SUM(ip.quantidade) AS Quantidade_Livros_Comprados
FROM 
    Cliente c
JOIN 
    Pedido p ON c.idCliente = p.idCliente
JOIN 
    ItemPedido ip ON p.idPedido = ip.idPedido
GROUP BY 
    c.idCliente, c.nome
ORDER BY 
    Quantidade_Livros_Comprados DESC;


