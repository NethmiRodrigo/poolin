import axios from "axios";

export const getAllPayments = async () => {
  const res = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_URL}/tests`);
  if (!res.data) throw new Error("Cannot fetch data");
  console.log(res.data)
  return res.data;

};
