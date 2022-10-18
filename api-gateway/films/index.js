import { ApolloServer, gql } from "apollo-server";
import { buildFederatedSchema } from "@apollo/federation";

import { films } from "../data.js";

const port = 4002;

const typeDefs = gql`
  type Film {
    id: Int!
    title: String
    actors: [Person] @provides(fields: "id")
    director: Person @provides(fields: "id")
  }

  extend type Person @key(fields: "id") {
    id: Int! @external
  }

  extend type Query {
    film(id: ID!): Film
    films: [Film]
  }
`;

const resolvers = {
  Film: {
    actors(film) {
      return film.actors.map((actor) => ({ __typename: "Person", id: actor }));
    },
    director(film) {
      return { __typename: "Person", id: film.director };
    }
  },
  Person: {
    appearedIn(person) {
      return films.filter((film) =>
        film.actors.find((actor) => actor === person.id)
      );
    },
    directed(person) {
      return films.filter((film) => film.director === person.id);
    }
  },
  Query: {
    film(_, { id }) {
      return films.find((film) => film.id === id);
    },
    films() {
      return films;
    }
  }
};

const server = new ApolloServer({
  schema: buildFederatedSchema([{ typeDefs, resolvers }]),
});

server.listen({ port }).then(({ url }) => {
  console.log(`Films service ready at ${url}`);
});
