import Head from "next/head";
import { Box, CircularProgress, Container } from "@mui/material";
import { CustomerListResults } from "../components/customer/customer-list-results";
import { CustomerListToolbar } from "../components/customer/customer-list-toolbar";
import { DashboardLayout } from "../components/dashboard-layout";
import { useEffect } from "react";
import { getAllUsers } from "src/services/users.service";
import { useState } from "react";
import { toast } from "react-toastify";

const Customers = () => {
  const [customers, setCustomers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(async () => {
    try {
      const response = await getAllUsers();
      setCustomers(response.allUsers);
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
            {loading ? <CircularProgress /> : <CustomerListResults customers={customers} />}
          </Box>
        </Container>
      </Box>
    </>
  );
};

Customers.getLayout = (page) => <DashboardLayout>{page}</DashboardLayout>;

export default Customers;
