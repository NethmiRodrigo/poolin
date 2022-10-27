import React, { useState } from "react";
import PerfectScrollbar from "react-perfect-scrollbar";
import PropTypes from "prop-types";
import { Button, FormControl, FormGroup, InputAdornment, InputLabel, MenuItem, Modal, NativeSelect, Select, TextField } from "@mui/material";
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
// import ViewComplaintsModal from "./view-complaint-modal";
import { ArrowDropDown } from "@mui/icons-material";

export const PaymentListResults = ({ payments, ...rest }) => {
  const [viewModalOpen, setViewModalOpen] = useState(false);
  const [selectedPaymentsIds, setSelectedPaymentsIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);

  const handleSelectAll = (event) => {
    let newSelectedPaymentsIds;

    if (event.target.checked) {
      newSelectedPaymentsIds = payments.map((payment) => payments.id);
    } else {
      newSelectedPaymentsIds = [];
    }

    setSelectedPaymentsIds(newSelectedPaymentsIds);
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
                <TableCell>Total Profit</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
            
              {payments.length > 0 && payments.slice(0, limit).map((payments) => (
                  <TableRow
                    hover
                    key={payments.id}
                    // selected={selectedPaymentIds.indexOf(Payment.id) !== -1}
                  >
                    <TableCell>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                        }}
                      >
                        
                        <Typography color="textPrimary" variant="body1">
                          {payments.id}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{payments.numberOfPassengers}</TableCell>
                    <TableCell>Total Number of Rides</TableCell>
                    <TableCell>
                    LKR: {payments.totalIncome}
                    </TableCell>
                    <TableCell>
                    LKR: {payments.totalPayable}
                    </TableCell>
                    <TableCell>
                    LKR: {payments.totalProfit}
                    </TableCell>
                    
                  </TableRow>
                ))}
            </TableBody>
          </Table>
        </Box>
      </PerfectScrollbar>
      <TablePagination
        component="div"
        count={payments.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[5, 10, 25]}
      />
      {/* {viewModalOpen && (
        <ViewComplaintsModal
          open={viewModalOpen}
          handleClose={() => {
            setViewModalOpen(false);
            //selectedCustomerIds(null);
          }}
          payment={selectedPaymentIds}
        />
      )} */}
    </Card>
  );
};

PaymentListResults.propTypes = {
  payment: PropTypes.array.isRequired,
};
