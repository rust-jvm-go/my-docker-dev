print("START #################################################################");

db = db.getSiblingDB("local_db");

db.createUser(
  {
    user: "localAdmin",
    pwd: "localAdmin",
    roles: [
      {
        role: "readWrite",
        db: "local_db"
      }
    ]
  },
);

db.createCollection("test_collection");

print("END #################################################################");
