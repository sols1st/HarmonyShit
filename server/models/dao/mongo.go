package dao

import (
    "blogger/models/entity"
    "context"
    "go.mongodb.org/mongo-driver/bson"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
    "log"
)

const logPrefix = "[MongoDB]: "

var Client *mongo.Client

func mongoLog(msg string) {
    log.Println(logPrefix + msg)
}

func AddUser(client *mongo.Client, user entity.User) {
    collection := client.Database("mydb").Collection("user")
    mongoLog("Try adding user!")

    _, err := collection.InsertOne(context.Background(), user)
    if err != nil {
        mongoLog("add user error in mongodb!")
        panic(err.Error())
    }

    mongoLog("Add user completed!")
}

func QueryUser(client *mongo.Client, Email string) entity.User {
    collection := client.Database("mydb").Collection("user")

    cursor, err := collection.Find(context.Background(), bson.D{})
    if err != nil {
        mongoLog("Query user error in mongodb!")
        panic(err.Error())
    }
    defer cursor.Close(context.Background())

    var users []entity.User
    if err := cursor.All(context.Background(), &users); err != nil {
        panic(err.Error())
    }
    var user entity.User
    for _, v := range users {
        if v.Email == Email {
            user = v
            break
        }
    }

    return user
}

func UpdateUser(client *mongo.Client, username string, user entity.User) {
    collection := client.Database("mydb").Collection("user")

    filter := bson.M{"username": username}
    update := bson.M{"$set": bson.M{"email": user.Email, "passward": user.Password, "username": user.Username}}

    _, err := collection.UpdateOne(context.Background(), filter, update)
    if err != nil {
        panic(err.Error())
    }
}

func DeleteUser(client *mongo.Client, user entity.User) {
    collection := client.Database("mydb").Collection("user")

    filter := bson.M{"username": user}

    _, err := collection.DeleteOne(context.Background(), filter)
    if err != nil {
        panic(err.Error())
    }
}

func MongoConnect() {
    clientOption := options.Client().ApplyURI("mongodb://localhost:27017")
    client, err := mongo.Connect(context.Background(), clientOption)
    if err != nil {
        mongoLog("Conecte to the mongodb failed!")
        panic(err.Error())
    }
    mongoLog("Connected to the mongodb !")
    Client = client
}

func DisConnect(client *mongo.Client) {
    err := client.Disconnect(context.Background())
    if err != nil {
        mongoLog(err.Error())
    } else {
        mongoLog("Mongodb connection is released !")
    }
}
