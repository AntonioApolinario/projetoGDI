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

Naruto é um mangá/anime onde o protagonista enfrenta diversos inimigos no caminho para conseguir quebrar o ciclo de ódio do mundo ninja.

Entidade Ninja e seus atributos:

Na obra de Naruto, os personagens principais são os Ninjas. Cada um possui um Registro Ninja único e seus Nomes são compostos, em sua maioria, pelo seu Primeiro Nome e o Nome do seu Clã, ex: "Naruto Uzumaki"; além disso, alguns Ninjas tem um Codinome, ex: "Kakashi do Sharingan". Todos os Ninjas tem um ou vários Jutsus, cada um deles com um Nome, Tipo, Elemento da natureza e Rank de dificuldade.

Heranças de Ninja:

Os Ninjas podem ser classificados unicamente em um dos 4 títulos seguintes, do mais baixo pro mais alto: Genin, Chuunin, Jounin e Kage. O Kage é o Ninja que lidera sua respectiva Aldeia e tem um Nº que informa qual o seu número na linha de líderes da sua Aldeia. O Jounin é o Ninja que possui alunos e/ou é uma espécie de general. Chuunin é um título dado ao Genin que foi aprovado num exame Chuunin, podendo agir como uma espécie de capitão em certas ocasiões. Já Genin é o título dado ao aluno recém formado da academia ninja.

Entidade Aldeia, seu atributo e relacionamento Nasceu:

Uma Aldeia é o local único onde cada Ninja Nasce e nela Nascem vários Ninja, sendo necessário que um Ninja tenha nascido numa Aldeia para ser considerado com tal. Cada Aldeia possui um nome único.

Entidade Bijuu, seus atributos e relacionamento Tem:

Um Ninja pode Ter uma única Bijuu (seres mitológicos de muito poder) e uma Bijuu só pode estar num único Ninja. Cada uma tem um Nome único, ex: "Kurama" e um Apelido, ex: "Kyuubi".

Auto relacionamento Rivaliza:

Um Ninja pode ter vários outros Ninjas que são seus Rivais, ao passo que ele é Rivalizado apenas por um único outro. Ex: Naruto possui vários rivais, porém, ele só considera Sasuke como sendo seu rival principal.

Entidade Equipe, seu atributo e relacionamento Compõe:

Um Ninja pode compor várias Equipes e cada Equipe pode ser composta por vários Ninjas. Cada Equipe tem um Número único e precisa ter Ninjas para existir.

Entidade fraca Missão, seus atributos e relacionamento identificador Faz:

Uma Equipe Faz várias Missões e uma Missão só pode ser feita por uma única Equipe. Cada Missão depende do Nº da Equipe que a realizou e sua Data de finalização para sua identificação. Além disso, ela possui um Rank de dificuldade, uma Recompensa e uma breve Descrição do que deve ser feito.

Relacionamento ternário Avalia:

Numa Missão, um Genin é Avaliado por um único Jounin; Um Genin é Avaliado por um mesmo Jounin em várias Missões; Numa Missão, um Jounin Avalia vários Genins.

Relacionamento Exame Chuunin, Assiste e entidade associativa:

Um Jounin é examinador de vários Genins num Exame Chuunin; Um Genin é examinado por vários Jounins num Exame Chuunin. Durante o Exame Chuunin, é possível mas não necessário, que um ou mais outros Chuunins já com este título, assista seus colegas; ao passo que um Chuunin pode assistir vários Exames Chuunin.

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
