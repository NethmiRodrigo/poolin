import { Request, Response } from "express";
import { User } from "../../database/entity/User";
import { executeCypherQuery } from "../../service/neo-service";
import { findFriendsOfAUser, findUsersByMobile } from "./util";

export const findFriendsFromContacts = async (req: Request, res: Response) => {
  const { contacts } = req.body;

  const friends = await findUsersByMobile(contacts);

  return res.status(200).json({ friends });
};

export const addFriends = async (req: Request, res: Response) => {
  const { contacts } = req.body;
  const currentUser: User = res.locals.user;

  const users = await findUsersByMobile(contacts);

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

  const users = await findFriendsOfAUser(user.id.toFixed(1), level);

  return res.status(200).json(users);
};
