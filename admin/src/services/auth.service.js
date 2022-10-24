import axios from "axios";

export const login = async (email, password) => {
  const res = await axios.post(`${process.env.NEXT_PUBLIC_BACKEND_URL}/auth/login`, {
    email,
    password,
  });
  if (res.data.user.role !== "admin") throw new Error("Unauthorized");
  localStorage.setItem("Cookie", `Cookie=${res.data.token}`);
  axios.defaults.headers.common["token"] = `Cookie=${res.data.token}`;
};
