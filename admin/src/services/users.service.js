import axios from "axios";

export const getAllUsers = async () => {
  const res = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_URL}/admin/get-all-users`);
  if (!res.data) throw new Error("Cannot fetch data");
  return res.data;
};
