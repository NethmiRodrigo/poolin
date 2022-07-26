import app from "../../app";
import TestConnection from "./connection";
import { TestAppDataSource } from "./test-data-source";

let connection: TestConnection;

const tearDownTests = async () => {
  const entities = TestAppDataSource.entityMetadatas;

  for (const entity of entities) {
    const repository = TestAppDataSource.getRepository(entity.name); // Get repository
    if (repository) {
      await repository.remove([]);
      await repository.delete({});
    }
  }
  if (connection) await connection.destroy();
  app.close();
};

export default tearDownTests;
