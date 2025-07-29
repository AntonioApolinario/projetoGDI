<h1 align="center"> NARUTO DATA BOOK </h1>

<p align="center">
  <img src="https://m.media-amazon.com/images/I/81QKx-T4NuL.jpg" alt="Naruto" height="750">
</p>

<p align="center">
  <img alt= Crunchyroll src="https://img.shields.io/badge/Crunchyroll-F47521?style=for-the-badge&logo=crunchyroll&logoColor=white">
  <img alt="Netflix" src="https://img.shields.io/badge/Netflix-E50914?style=for-the-badge&logo=netflix&logoColor=white">
  <img alt="Amazon Prime" src="https://img.shields.io/badge/Amazon%20Prime-0F79AF?style=for-the-badge&logo=amazonprime&logoColor=white">
</p>

𖦹 _Projeto para disciplina Gerenciamento de Dados e Informações 25.1_

🥷 _Equipe:_

- _Antônio Apolinário Barbosa_
- _Jhonatan Kennedy Pires de Andrade_
- _Matheus Barbosa Santos_
- _Michael Felipe dos Santos_
- _Wenderson Juvenal Lopes dos Santos_

## ✅ Objetivo do projeto

Auxiliar no aprendizado dos conceitos abordados na disciplina ao aplicá-los de forma prática num projeto desenvolvido sobre um tema de escolha dos próprios alunos.

![Static Badge](http://img.shields.io/static/v1?style=for-the-badge&label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge)

## 🌎 Descrição do minimundo

Naruto é um anime onde o protagonista enfrenta diversos inimigos no caminho para conseguir quebrar o ciclo de ódio do mundo ninja.

## 🚀 Executando a Database

Para subir o banco de dados, execute o comando abaixo no terminal:

```bash
docker compose up --build
```

> O parâmetro `--build` força a reconstrução das imagens Docker, útil quando há alterações na imagem ou na configuração do serviço.

---

## 🛠 Acessando o CLI do Banco de Dados

Para acessar o terminal interativo (CLI) do PostgreSQL:

```bash
docker exec -it sql psql -U postgres -d postgres
```

---

## ❌ Saindo do CLI

Para sair do terminal interativo do PostgreSQL:

```bash
exit
```

---

## 🧹 Derrubando o Compose e Limpando Volumes

Caso deseje parar todos os containers e **remover os volumes associados**, execute:

```bash
docker compose down -v
```

> O parâmetro `-v` remove também os volumes, o que zera os dados persistidos (como tabelas e registros). Use com cuidado caso esteja testando alterações e queira um ambiente limpo ao reiniciar.

---

## 🛠 Acessando o CLI do Mongo

```bash
docker exec -it no_sql mongosh -u admin -p admin123
```

Entrando no mongo:

```bash
use ninjaAdmin
```

## ✅ Requisitos

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

---
