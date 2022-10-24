import Head from "next/head";
import { Box, CircularProgress, Container } from "@mui/material";
import { ComplaintsListResults } from "../components/complaints/complaints-list-results";
import { CustomerListToolbar } from "../components/customer/customer-list-toolbar";
import { DashboardLayout } from "../components/dashboard-layout";
import { useEffect } from "react";
import { getAllUsers } from "src/services/users.service";
import { useState } from "react";
import { toast } from "react-toastify";
import { getAllComplaints } from "src/services/complaints.services";

const Complaints = () => {
  const [complaints, setComplaints] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(async () => {
    try {
      const response = await getAllComplaints();
      setComplaints(response.allComplaints);
    } catch (error) {
      toast.error(error.message, {
        position: "top-right",
        autoClose: 5000,
        hideProgressBar: false,
        closeOnClick: true,
        pauseOnHover: true,
        draggable: true,
        progress: undefined,
        theme: "colored",
      });
      console.log(error);
    } finally {
      setLoading(false);
    }
  }, []);

  return (
    <>
      <Head>
        <title>Users</title>
      </Head>
      <Box
        component="main"
        sx={{
          flexGrow: 1,
          py: 8,
        }}
      >
        <Container maxWidth={false}>
          <CustomerListToolbar />
          <Box sx={{ mt: 3 }}>
            {loading ? <CircularProgress /> : <ComplaintsListResults complaints={complaints} />}
          </Box>
        </Container>
      </Box>
    </>
  );
};

Complaints.getLayout = (page) => <DashboardLayout>{page}</DashboardLayout>;

export default Complaints;
