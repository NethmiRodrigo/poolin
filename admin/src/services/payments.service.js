import axios from "axios";

// export const getTotalPayable = async () => {
//   const res = await axios.get(`http://localhost:5000/api/admin/total-income`);
//   if (!res.data) throw new Error("Cannot fetch data");
//   console.log(res.data)
//   return res.data;

// };

export const getAllPayments = async () => {
  const res = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_URL}/payments`);
  if (!res.data) throw new Error("Cannot fetch data");
  console.log(res.data)
  return res.data;
};
