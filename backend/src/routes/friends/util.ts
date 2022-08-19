import { Node } from "neo4j-driver";
import { User } from "../../database/entity/User";
import { executeCypherQuery } from "../../service/neo-service";

export const findUsersByMobile = async (contacts: Array<String>) => {
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

const findUsersWithNeoResult = async (result) => {
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

export const findFriendsOfAUser = async (userid, level) => {
  const statement = `MATCH (:User { user_id: $id })-[:TRUSTS*${level}..${level}]-(n) RETURN n`;

  const params = {
    id: userid,
  };

  const result = await executeCypherQuery(statement, params);

  const users = await findUsersWithNeoResult(result);

  return users;
};

export const findMutualFriends = async (user_id, friend_id) => {
  const statement = `MATCH (start1 {user_id: $user_id})-[*..2]->(main), (start2 {user_id: $friend_id})-[*..2]->(main) RETURN main`;
  const params = { user_id, friend_id };

  const result = await executeCypherQuery(statement, params);
  const users = await findUsersWithNeoResult(result);

  return users;
};

export const findFriendLevelOfUser = async (user_id, friend_id) => {
  const statement = `MATCH p=shortestPath((user:User)-[:TRUSTS*1..15]-(friend:User)) 
  WHERE user.user_id=$user_id AND friend.user_id=$friend_id
  RETURN p`;
  const params = { user_id, friend_id };

  const result = await executeCypherQuery(statement, params);

  if (result.records && result.records.length)
    return result.records[0].get(0).length;
  else return -1;
};
