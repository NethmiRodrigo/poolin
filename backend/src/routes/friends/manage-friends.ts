import { Request, Response } from "express";
import { User } from "../../database/entity/User";
import { executeCypherQuery } from "../../service/neo-service";

const findUsers = async (contacts: Array<String>) => {
  let users = [];
  contacts.forEach(async (contact: string) => {
    let user = await User.findOneBy({ mobile: contact });
    if (user) {
      delete user.password;
      users.push(user);
    }
  });
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

  let results = [];

  users.forEach(async (user: User) => {
    const statement =
      "MATCH (a:User), (b: User) WHERE a.mobile = $user_mobile AND b.mobile = $friend_mobile CREATE (b)-[r:RELTYPE {name: b.name + 'is a contact of ->' + a.name}]->(b) RETURN r.name";

    const params = {
      user_mobile: currentUser.mobile,
      friend_mobile: user.mobile,
    };

    const result = await executeCypherQuery(statement, params);

    results.push(result.records[0].get(0));
  });

  return res.status(200).json(results);
};
