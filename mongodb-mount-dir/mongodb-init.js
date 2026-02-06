print("START #################################################################");

function getEnvOrThrow(key, fallback) {
  if (typeof process !== "undefined" && process.env && process.env[key]) {
    return process.env[key];
  }
  if (fallback !== undefined) {
    return fallback;
  }
  throw new Error("Missing required environment variable: " + key);
}

const appDbName = getEnvOrThrow("MONGODB_APP_DATABASE", "local_db");
const appUser = getEnvOrThrow("MONGODB_APP_USERNAME");
const appPassword = getEnvOrThrow("MONGODB_APP_PASSWORD");
const defaultCollectionName = "test_collection";

db = db.getSiblingDB(appDbName);

function ensureAppUser() {
  const existingUser = db.getUser(appUser);
  if (existingUser) {
    print("User '" + appUser + "' already exists, skipping creation");
    return;
  }
  db.createUser(
    {
      user: appUser,
      pwd: appPassword,
      roles: [
        {
          role: "readWrite",
          db: appDbName
        }
      ]
    },
  );
  print("Created application user '" + appUser + "'");
}

function ensureCollection(name) {
  if (!db.getCollectionNames().includes(name)) {
    db.createCollection(name);
    print("Created collection '" + name + "'");
  } else {
    print("Collection '" + name + "' already exists, skipping creation");
  }
}

ensureAppUser();
ensureCollection(defaultCollectionName);

print("END #################################################################");
