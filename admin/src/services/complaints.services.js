import axios from "axios";

export const getAllComplaints = async () => {
  const res = await axios.get(`http://localhost:5000/api/admin/total-income`);
  if (!res.data) throw new Error("Cannot fetch data");
  console.log(res.data)
  return res.data;

};
