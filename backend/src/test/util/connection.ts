import { DataSource, QueryRunner } from "typeorm";
import { TestAppDataSource } from "./test-data-source";

export default class TestConnection {
  dataSource: DataSource;
  queryRunner: QueryRunner;

  constructor() {}

  async initialize() {
    this.dataSource = await TestAppDataSource.initialize();
    this.queryRunner = this.dataSource.createQueryRunner();
    return this;
  }

  async dropTable(name: string) {
    let table = await this.queryRunner.getTable(name);
    await this.queryRunner.dropTable(table!);
  }

  async clearDatabase() {
    const entities = this.dataSource.entityMetadatas;
    const tableNames = entities
      .map((entity) => `"${entity.tableName}"`)
      .join(", ");

    await this.dataSource.query(`TRUNCATE ${tableNames} CASCADE;`);
  }

  async destroy() {
    await TestAppDataSource.destroy();
  }
}
