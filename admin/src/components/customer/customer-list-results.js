import { useState } from "react";
import PerfectScrollbar from "react-perfect-scrollbar";
import PropTypes from "prop-types";

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
  Button,
  Switch,
  FormControlLabel,
  FormGroup,
} from "@mui/material";
import { getInitials } from "../../utils/get-initials";
import PreviewIcon from "@mui/icons-material/Preview";
import ViewCustomerModal from "./customer-modal";

export const CustomerListResults = ({ customers, ...rest }) => {
  const [viewModalOpen, setViewModalOpen] = useState(false);
  console.log(customers);
  const [selectedCustomerIds, setSelectedCustomerIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);

  const handleSelectAll = (event) => {
    let newSelectedCustomerIds;

    if (event.target.checked) {
      newSelectedCustomerIds = customers.map((customer) => customer.id);
    } else {
      newSelectedCustomerIds = [];
    }

    setSelectedCustomerIds(newSelectedCustomerIds);
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
                <TableCell>Name</TableCell>
                <TableCell>User Type</TableCell>
                <TableCell>Contact Number</TableCell>
                <TableCell>Registration date</TableCell>
                <TableCell>View Details</TableCell>
                <TableCell>Verification</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {customers.length > 0 &&
                customers.slice(0, limit).map((customer) => (
                  <TableRow
                    hover
                    key={customer.id}
                    // selected={selectedCustomerIds.indexOf(customer.id) !== -1}
                  >
                    <TableCell>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                        }}
                      >
                        {`${customer.firstname} ${customer.lastname}`}

                        <Typography color="textPrimary" variant="body1">
                          {customer.firstName}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{customer.role}</TableCell>
                    <TableCell>{customer.mobile}</TableCell>
                    <TableCell>{customer.createdAt}</TableCell>
                    <TableCell>
                      <Button
                        variant="outlined"
                        onClick={() => {
                          setViewModalOpen(true);
                          setSelectedCustomerIds(customer);
                        }}
                      >
                        View
                      </Button>
                    </TableCell>
                    <TableCell>
                      <FormGroup>
                        <FormControlLabel control={<Switch />} label="Verified" />
                      </FormGroup>
                    </TableCell>
                  </TableRow>
                ))}
            </TableBody>
          </Table>
        </Box>
      </PerfectScrollbar>
      <TablePagination
        component="div"
        count={customers.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[5, 10, 25]}
      />
      {viewModalOpen && (
        <ViewCustomerModal
          open={viewModalOpen}
          handleClose={() => {
            setViewModalOpen(false);
            //selectedCustomerIds(null);
          }}
          customer={selectedCustomerIds}
        />
      )}
    </Card>
  );
};

CustomerListResults.propTypes = {
  customers: PropTypes.array.isRequired,
};
