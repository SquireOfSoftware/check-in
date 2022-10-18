import { ApolloGateway } from "@apollo/gateway";
import { ApolloServer } from "apollo-server";

const port = 4000;

const gateway = new ApolloGateway({
  serviceList: [
    { name: "person", url: "http://localhost:8080/people-service/graphql" },
    { name: "films", url: "http://localhost:4002" }
  ]
});

const server = new ApolloServer({
  gateway,
  subscriptions: false
});

server.listen({ port }).then(({ url }) => {
  console.log(`Server ready at ${url}`);
});