import Head from 'next/head';
import { Box, Container } from '@mui/material';
import { ComplaintsListResults } from '../components/complaints/complaints-list-results';
import { ComplaintsListToolbar } from '../components/complaints/complaints-list-toolbar';
import { DashboardLayout } from '../components/dashboard-layout';
import { customers } from '../__mocks__/customers';

const Complaints = () => (
  <>
    <Head>
      <title>
        Complaints
      </title>
    </Head>
    <Box
      component="main"
      sx={{
        flexGrow: 1,
        py: 8
      }}
    >
      <Container maxWidth={false}>
        <ComplaintsListToolbar />
        <Box sx={{ mt: 3 }}>
          <ComplaintsListResults customers={customers} />
        </Box>
      </Container>
    </Box>
  </>
);
Complaints.getLayout = (page) => (
  <DashboardLayout>
    {page}
  </DashboardLayout>
);

export default Complaints;
