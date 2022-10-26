import axios from "axios";

export const getAllsales = async () => {
  const res = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_URL}/dashboard`);
  if (!res.data) throw new Error("Cannot fetch data");
  console.log(res.data)
  return res.data;

};
