import { useState } from "react";
import PerfectScrollbar from "react-perfect-scrollbar";
import PropTypes from "prop-types";
import { Button, FormGroup, Modal } from "@mui/material";
import { FormControlLabel } from "@mui/material";
import { Switch } from "@mui/material";
import axios from "axios";
import { format } from "date-fns";
import {
  Avatar,
  Box,
  Card,
  Checkbox,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography,
} from "@mui/material";
import { getInitials } from "../../utils/get-initials";
import PreviewIcon from "@mui/icons-material/Preview";
const style = {
  position: 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 400,
  bgcolor: 'background.paper',
  border: '2px solid #000',
  boxShadow: 24,
  p: 4,
};
export const PaymentListResults = ({ payment, ...rest }) => {
  console.log(payment)
  const [selectedPaymentIds, setSelectedPaymentIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);

  const handleSelectAll = (event) => {
    let newSelectedPaymentsIds;

    if (event.target.checked) {
      newSelectedPaymentIds = payment.map((payment) => payment.id);
      console.log(newSelectedPaymentsIds)
    } else {
      newSelectedPaymentIds = [];
    }

    setSelectedPaymentIds(newSelectedPaymentIds);
  };

  // const handleSelectOne = (event, id) => {
  //   const selectedIndex = selectedCustomerIds.indexOf(id);
  //   let newSelectedCustomerIds = [];

  //   if (selectedIndex === -1) {
  //     newSelectedCustomerIds = newSelectedCustomerIds.concat(selectedCustomerIds, id);
  //   } else if (selectedIndex === 0) {
  //     newSelectedCustomerIds = newSelectedCustomerIds.concat(selectedCustomerIds.slice(1));
  //   } else if (selectedIndex === selectedCustomerIds.length - 1) {
  //     newSelectedCustomerIds = newSelectedCustomerIds.concat(selectedCustomerIds.slice(0, -1));
  //   } else if (selectedIndex > 0) {
  //     newSelectedCustomerIds = newSelectedCustomerIds.concat(
  //       selectedCustomerIds.slice(0, selectedIndex),
  //       selectedCustomerIds.slice(selectedIndex + 1)
  //     );
  //   }

  //   setSelectedCustomerIds(newSelectedCustomerIds);
  // };

  const handleLimitChange = (event) => {
    setLimit(event.target.value);
  };

  const handlePageChange = (event, newPage) => {
    setPage(newPage);
  };

  return (
    
    <Card {...rest}>
      <PerfectScrollbar>
        <Box sx={{ minWidth: 1050 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Driver ID</TableCell>
                <TableCell>Passengers</TableCell>
                <TableCell>Total Number of Rides</TableCell>
                <TableCell>Total Ride Income</TableCell>
                <TableCell>Total Ride Payable</TableCell>
                <TableCell>Total Income</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {payment.length > 0 &&
                payment.slice(0, limit).map((payment) => (
                  <TableRow
                    hover
                    key={payment.id}
                    // selected={selectedComplaintsIds.indexOf(complaints.id) !== -1}
                  >
                    <TableCell>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                        }}
                      >
                        <Typography color="textPrimary" variant="body1">
                          {payment.id}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{payment.totalIncome}</TableCell>
                    <TableCell></TableCell>
                    <TableCell>
                      
                    </TableCell>
                    <TableCell>
                      
                    </TableCell>
                    <TableCell>
                      <FormGroup>
                        <FormControlLabel control={<Switch />} label="" />
                      </FormGroup>
                    </TableCell>
                    <TableCell>
                      
                    </TableCell>
                  </TableRow>
                ))}
            </TableBody> 
          </Table>
        </Box>
      </PerfectScrollbar>
      <TablePagination
        component="div"
        // count={complaints.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[5, 10, 25]}
      />
    </Card>
    
  );
  
};


PaymentListResults.propTypes = {
  payment: PropTypes.array.isRequired,
};

