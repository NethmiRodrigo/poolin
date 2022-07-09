import { Request, Response, Router } from "express";
import { isEmpty } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import cookie from "cookie";

import { User } from "../entity/User";

const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  try {
    let errors: any = {};
    if (isEmpty(email)) errors.email = "Email cannot be empty";
    if (isEmpty(password)) errors.password = "Password cannot be empty";

    if (Object.keys(errors).length > 0) return res.status(400).json(errors);

    const user = await User.findOneBy({ email });
    if (!user) return res.status(404).json({ error: "Incorrect credentials" });

    const passwordMatched = await bcrypt.compare(password, user.password);
    if (!passwordMatched)
      return res.status(401).json({ error: "Incorrect credentials" });

    const token = jwt.sign({ user }, process.env.JWT_SECRET);

    res.set(
      "Set-Cookie",
      cookie.serialize("Token", token, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "strict",
      })
    );

    return res.json({ user, token });
  } catch (err) {
    console.log(err);
    return res.status(500).json(err);
  }
};

const router = Router();
router.post("/login", login);

export default router;
