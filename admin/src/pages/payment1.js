import Head from "next/head";
import { Box, Container, Grid } from "@mui/material";
import { TotalIncome } from "../components/payment/total-income";
import { TotalPayables } from "../components/payment/total-payables";
import { TotalProfit } from "../components/payment/total-profit";
import { TotalCustomers } from "../components/payment/total-customers";
import { PaymentListResults } from "../components/payment/payment-list-results";

import { DashboardLayout } from "../components/dashboard-layout";

import { getAllPayments } from "src/services/payments.service";
import { useState } from "react";
import { toast } from "react-toastify";
import { useEffect } from "react";

const Payment = () => {
  const [payment, setPayment] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(async () => {
    try {
      const response = await getAllPayments();
      setPayment(response);
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
        <title>Payments</title>
      </Head>
      <Box
        component="main"
        sx={{
          flexGrow: 1,
          py: 8,
        }}
      >
        <Container maxWidth={false}>
          <Grid container spacing={3}>
            <Grid item lg={3} sm={6} xl={3} xs={12}>
              <TotalIncome />
            </Grid>
            <Grid item xl={3} lg={3} sm={6} xs={12}>
              <TotalPayables />
            </Grid>
            <Grid item xl={3} lg={3} sm={6} xs={12}>
              <TotalProfit />
            </Grid>
            <Grid item xl={3} lg={3} sm={6} xs={12}>
              <TotalCustomers />
            </Grid>
            <Grid item md={12} xl={9} xs={12}>
              <PaymentListResults payment={payment} />
            </Grid>
          </Grid>
        </Container>
      </Box>
    </>
  );
};

Payment.getLayout = (page) => <DashboardLayout>{page}</DashboardLayout>;

export default Payment;
