import { Request, Response } from "express";
import bcrypt from "bcrypt";
import { User } from "../../database/entity/User";
import { executeCypherQuery } from "../../service/neo-service";

export const createUser = async (req: Request, res: Response) => {
  const { firstname, lastname, email, gender, mobile, password } = req.body;
  let user = new User({ firstname, lastname, email, gender, mobile });

  const hashedPassword = await bcrypt.hash(password, 8);
  user.password = hashedPassword;

  user = await user.save();

  const statement =
    'CREATE (a:User) SET a.user_id = $user_id, a.mobile = $mobile, a.name = $name RETURN a.user_id + ", from node " + id(a)';

  const params = {
    user_id: user.id,
    mobile,
    name: `${user.firstname} ${user.lastname}`,
  };

  const result = await executeCypherQuery(statement, params);

  const record = result.records[0].get(0);

  return res.status(200).json({ user, record });
};

export const createNode = async (req: Request, res: Response) => {
  const { name, mobile, user_id } = req.body;

  const statement =
    'CREATE (a:User) SET a.user_id = $user_id, a.mobile = $mobile, a.name = $name RETURN a.user_id + ", from node " + id(a)';

  const params = { user_id: user_id, mobile: mobile, name };

  const result = await executeCypherQuery(statement, params);

  return res.status(200).json(result.records[0].get(0));
};
