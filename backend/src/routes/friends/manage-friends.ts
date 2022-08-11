import { Request, Response } from "express";
import { Node } from "neo4j-driver";
import { User } from "../../database/entity/User";
import { executeCypherQuery } from "../../service/neo-service";

const findUsers = async (contacts: Array<String>) => {
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

export const findFriendsFromContacts = async (req: Request, res: Response) => {
  const { contacts } = req.body;

  const friends = await findUsers(contacts);

  return res.status(200).json({ friends });
};

export const addFriends = async (req: Request, res: Response) => {
  const { contacts } = req.body;
  const currentUser: User = res.locals.user;

  const users = await findUsers(contacts);

  if (!users.length)
    return res.status(200).json({ message: "Could not find any users" });

  users.forEach(async (user: User) => {
    const statement =
      "MATCH (a:User), (b: User) WHERE a.mobile = $user_mobile AND b.mobile = $friend_mobile CREATE (a)-[r:TRUSTS {name: a.name + ' trusts -> ' + b.name}]->(b) RETURN r";

    const params = {
      user_mobile: currentUser.mobile,
      friend_mobile: user.mobile,
    };

    await executeCypherQuery(statement, params);
  });

  return res.status(200).json(users);
};

export const getCloseFriends = async (req: Request, res: Response) => {
  const { level } = req.params;
  const user: User = res.locals.user;

  if (!level) return Error("Level cannot be empty");

  const statement = `MATCH (:User { user_id: $id })-[:TRUSTS*${level}..${level}]-(n) RETURN n`;

  const params = {
    id: user.id.toFixed(1),
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

  return res.status(200).json(users);
};
