db = db.getSiblingDB('ninjaAdmin');

db.createUser({
  user: "admin",
  pwd: "admin123",
  roles: [
    { role: "readWrite", db: "ninja" }
  ]
});

/* 1º 
Os ids gerados ficam no time */
db.equipe1.insertMany([
  { _id: ObjectId(), nome: "Time 7" },
  { _id: ObjectId(), nome: "Time 10" }
]);

/* Pego esses ids e uso para povoar minha tabela de ninjas, minha relação compõe não é mais necessária
Logo: um documento referenciando apenas um documento
*/
const equipes = db.equipe1.find().toArray();

db.ninja1.insertMany([
  { nome: "Naruto", rank: "Genin", equipe_id: equipes[0]._id },
  { nome: "Sasuke", rank: "Genin", equipe_id: equipes[0]._id },
  { nome: "Sakura", rank: "Genin", equipe_id: equipes[0]._id },
  { nome: "Shikamaru", rank: "Chunnin", equipe_id: equipes[1]._id }
]);
//consulta:
db.ninja1.find({ 
    equipe_id: db.equipe1.findOne({ nome: "Time 7" })._id 
});

/*2º 
um documento embutindo apenas um documento
*/
db.ninja2.insertMany([
  {
    nome: "Naruto",
    rank: "Genin",
    equipe: { nome: "Time 7" }
  },
  {
    nome: "Shikamaru",
    rank: "Chunnin",
    equipe: { nome: "Time 10" }
  }
]);
//consulta
db.ninja2.find({ equipe:{ nome:"Time 7" }})

/*3º 
um documento com um array de referências para documentos
*/
db.equipe3.insertOne({
  nome: "Time 7",
  ninjas_ids: []
});

const equipe7 = db.equipe3.findOne({ nome: "Time 7" });

const naruto = db.ninja3.insertOne({ nome: "Naruto", rank: "Genin" });
const sasuke = db.ninja3.insertOne({ nome: "Sasuke", rank: "Genin" });
const sakura = db.ninja3.insertOne({ nome: "Sakura", rank: "Genin" });

db.equipe3.updateOne(
  { _id: equipe7._id },
  { $set: { 
    ninjas_ids: [naruto.insertedId, sasuke.insertedId, sakura.insertedId] 
    } }
);

//consulta
db.ninja3.find({ 
    _id: { $in: db.equipe3.findOne({ nome: "Time 7" }).ninjas_ids } 
});

/*4º
um documento embutindo varios documentos
*/
 db.equipe4.insertOne({
  nome: "Time 7",
  ninjas: [
    { nome: "Naruto", rank: "Genin" },
    { nome: "Sasuke", rank: "Genin" },
    { nome: "Sakura", rank: "Genin" }
  ]
});

//consulta
db.equipe4.findOne({ nome:"Time 7" }).ninjas