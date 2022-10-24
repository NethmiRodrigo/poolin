import { useState } from "react";
import PerfectScrollbar from "react-perfect-scrollbar";
import PropTypes from "prop-types";
import { Button } from "@mui/material";
import {
  Avatar,
  Box,
  Card,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography,
} from "@mui/material";
import { getInitials } from "src/utils/get-initials";
import ViewProductModal from "./product-modal";

export const ProductListResults = ({ customers, ...rest }) => {
  const [viewModalOpen, setViewModalOpen] = useState(false);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);
  const [selectedUser, setSelectedUser] = useState({});

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
                <TableCell>Address</TableCell>
                <TableCell>Contact Number</TableCell>
                <TableCell>Email</TableCell>
                <TableCell>Action</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {customers.length > 0 &&
                customers.slice(0, limit).map((customer) => (
                  <TableRow hover key={customer.id}>
                    <TableCell>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                        }}
                      >
                        <Avatar src={customer.avatarUrl} sx={{ mr: 2 }}>
                          {getInitials(customer.name)}
                        </Avatar>
                        <Typography color="textPrimary" variant="body1">
                          {customer.name}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>
                      {`${customer.address.city}, ${customer.address.state}, ${customer.address.country}`}
                    </TableCell>
                    <TableCell>{customer.phone}</TableCell>
                    <TableCell>{customer.email}</TableCell>
                    <TableCell>
                      <Button
                        variant="outlined"
                        sx={{ marginRight: 1, marginLeft: 1 }}
                        onClick={() => {
                          setSelectedUser(customer);
                          setViewModalOpen(true);
                        }}
                      >
                        View
                      </Button>
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
        <ViewProductModal
          open={viewModalOpen}
          handleClose={() => {
            setViewModalOpen(false);
            setSelectedUser(null);
          }}
          customer={selectedUser}
        />
      )}
    </Card>
  );
};

ProductListResults.propTypes = {
  customers: PropTypes.array.isRequired,
};
