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

  async destroy() {
    await TestAppDataSource.destroy();
  }
}
