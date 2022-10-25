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
import ViewComplaintsModal from "./view-complaint-modal";
import { ArrowDropDown } from "@mui/icons-material";

export const ComplaintsListResults = ({ complaints, ...rest }) => {
  const [viewModalOpen, setViewModalOpen] = useState(false);
  const [selectedComplaintsIds, setSelectedComplaintsIds] = useState([]);
  const [limit, setLimit] = useState(10);
  const [page, setPage] = useState(0);

  const handleSelectAll = (event) => {
    let newSelectedComplaintIds;

    if (event.target.checked) {
      newSelectedComplaintIds = complaints.map((complaints) => complaints.id);
    } else {
      newSelectedComplaintIds = [];
    }

    setSelectedComplaintsIds(newSelectedComplaintIds);
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
        
      <Box sx={{ m: 1 }} >
      <FormControl fullwidth>
  <InputLabel variant="standard" htmlFor="uncontrolled-native">
    Status
  </InputLabel>
  <NativeSelect
    defaultValue={30}
    inputProps={{
      name: 'status',
      id: 'uncontrolled-native',
    }}
  >
    <option value={10}>Open</option>
    <option value={20}>Close</option>
    <option value={30}>All</option>
  </NativeSelect>
</FormControl>
        </Box>
        <Box sx={{ minWidth: 1050 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Trip ID</TableCell>
                <TableCell>Description</TableCell>
                <TableCell>Status</TableCell>
                <TableCell>Complainee</TableCell>
                <TableCell>Complainer</TableCell>
                <TableCell>Action</TableCell>
                <TableCell>View</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {complaints.length > 0 &&
                complaints.slice(0, limit).map((complaints) => (
                  <TableRow
                    hover
                    key={complaints.id}
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
                          {complaints.tripId}
                        </Typography>
                      </Box>
                    </TableCell>
                    <TableCell>{complaints.description}</TableCell>
                    <TableCell>{complaints.status}</TableCell>
                    <TableCell>
                      {`${complaints.complainee.firstname} ${complaints.complainee.lastname}`}{" "}
                    </TableCell>
                    <TableCell>
                      {`${complaints.complainer.firstname} ${complaints.complainer.lastname}`}{" "}
                    </TableCell>
                    <TableCell>
                      <FormGroup>
                        <FormControlLabel control={<Switch />} label="" />
                      </FormGroup>
                    </TableCell>
                    <TableCell>
                      <Button
                        variant="outlined"
                        onClick={() => {
                          setViewModalOpen(true);
                          setSelectedComplaintsIds(complaints);
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
        count={complaints.length}
        onPageChange={handlePageChange}
        onRowsPerPageChange={handleLimitChange}
        page={page}
        rowsPerPage={limit}
        rowsPerPageOptions={[5, 10, 25]}
      />
      {viewModalOpen && (
        <ViewComplaintsModal
          open={viewModalOpen}
          handleClose={() => {
            setViewModalOpen(false);
            //selectedCustomerIds(null);
          }}
          complaints={selectedComplaintsIds}
        />
      )}
    </Card>
  );
};

ComplaintsListResults.propTypes = {
  complaints: PropTypes.array.isRequired,
};
