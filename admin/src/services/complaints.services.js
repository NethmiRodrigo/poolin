import axios from "axios";

export const getAllComplaints = async () => {
  const res = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_URL}/admin/get-all-complaints`);
  if (!res.data) throw new Error("Cannot fetch data");
  return res.data;
};
