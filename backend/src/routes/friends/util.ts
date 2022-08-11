import { Node } from "neo4j-driver";
import { User } from "../../database/entity/User";
import { executeCypherQuery } from "../../service/neo-service";

export const findUsers = async (contacts: Array<String>) => {
  let users = [];
  let promises = [];
  contacts.forEach((contact: string) =>
    promises.push(User.findOneBy({ mobile: contact }))
  );
  const result = await Promise.all(promises);
  if (result && result.length) {
    result.forEach((value) => {
      if (value) users.push(value);
    });
  }
  return users;
};

export const findFriendsOfAUser = async (userid, level) => {
  const statement = `MATCH (:User { user_id: $id })-[:TRUSTS*${level}..${level}]-(n) RETURN n`;

  const params = {
    id: userid,
  };

  const result = await executeCypherQuery(statement, params);

  let users = [];
  let userPromises = [];

  if (result.records && result.records?.length) {
    result.records.map((record) => {
      const node: Node = record.get(0);
      userPromises.push(
        User.findOneBy({
          mobile: node.properties.mobile,
        })
      );
    });
  }

  if (userPromises.length) {
    const values = await Promise.all(userPromises);
    values.map((value: User) => {
      if (value) {
        delete value.password;
        users.push(value);
      }
    });
  }

  return users;
};
