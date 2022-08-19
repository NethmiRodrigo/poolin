import { NeoDriver } from "../data-source";
import neo4j from "neo4j-driver";

const executeCypherQuery = async (statement: string, params = {}) => {
  try {
    let session = NeoDriver.session({
      database: process.env.NEO_DATABASE,
      defaultAccessMode: neo4j.session.WRITE,
    });

    const result = await session.writeTransaction((tx) =>
      tx.run(statement, params)
    );

    await session.close();
    return result;
  } catch (error) {
    throw new Error(error);
  }
};

export { executeCypherQuery };
