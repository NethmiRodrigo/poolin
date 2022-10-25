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
export const PaymentListResults = ({ complaints, ...rest }) => {
  console.log(complaints);
  const [selectedCustomerIds, setSelectedCustomerIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);
  const [viewModalOpen, setViewModalOpen] = useState(false);
  const [selectedReferral, setSelectedReferral] = useState(null);

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
const handleSelect = (referral) => {
    setSelectedReferral(referral);
    setViewModalOpen(true);
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
            {/* <TableBody>
              {complaints.length > 0 &&
                complaints.slice(0, limit).map((complaints) => (
                  <TableRow
                    hover
                    key={complaints.id}
                    selected={selectedCustomerIds.indexOf(complaints.id) !== -1}
                  >
                    <TableCell>
                      <Box
                        sx={{
                          alignItems: "center",
                          display: "flex",
                        }}
                      >
                        
                        <Typography color="textPrimary" variant="body1">
                          {complaints.tripId}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{complaints}</TableCell>
                    {/* <TableCell>
                      {`${customer.address.city}, ${customer.address.state}, ${customer.address.country}`}
                    </TableCell> */}
                    {/* <TableCell>{customer.phone}</TableCell> */}
                    {/* <TableCell>
                    {complaints.status}
                    </TableCell>
                    <TableCell>
                      <FormGroup>
                        <FormControlLabel control={<Switch />} label="Label"/>
                      </FormGroup>
                    </TableCell>
                    <TableCell> */}
                    {/* <Button variant="outlined" onClick={handleSelect}>
                        View
                    </Button> */}
                    {/* <Button variant="outlined" onClick={() => handleSelect(referral)}>
                          View
                    </Button>
                    </TableCell>
                    
                  </TableRow>
                  
                ))}
            </TableBody> */} 
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

// ComplaintsListResults.propTypes = {
//   complaints: PropTypes.array.isRequired,
// };
