import React from "react";
import lodash from "lodash";
import PropTypes from "prop-types";
import {
  Dialog,
  DialogTitle,
  DialogContent,
  TextField,
  DialogActions,
  Card,
  CardContent,
  Grid,
  Button,
  Avatar,
} from "@mui/material";
import Slide from "@mui/material/Slide";

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

function ViewCustomerModal({ open, handleClose, customer }) {
  return (
    <Dialog
      open={open}
      keepMounted
      TransitionComponent={Transition}
      onClose={handleClose}
      fullWidth
      maxWidth="md"
      aria-describedby="alert-dialog-slide-description"
    >
      <DialogTitle>{customer.name}</DialogTitle>
      <DialogContent>
        <Card>
          <CardContent>
            <Grid container spacing={5}>
              {/* <Grid item md={12} xs={12}> */}
              {/* {customer?.avatarUrl && (
                  <Avatar
                    src={customer?.avatarUrl}
                    alt="profile picture"
                    variant="rounded"
                    sx={{ width: 150, height: 150, marginBottom: 2 }}
                  />
                )} */}
              {/* </Grid> */}

              <Grid item md={6} xs={12}>
                <TextField
                  label="First Name"
                  value={customer.firstname}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={15}>
                <TextField
                  label="Last Name"
                  value={customer.lastname}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Email Address"
                  value={customer.email}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Mobile"
                  value={customer.mobile}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Gender"
                  value={customer.gender}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Role"
                  value={customer.role}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Average Rating"
                  value={customer.totalRatings}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="License"
                  value=""
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
            </Grid>
          </CardContent>
        </Card>
      </DialogContent>
      <DialogActions>
        <Button autofocus onClick={handleClose}>
          Close
        </Button>
      </DialogActions>
    </Dialog>
  );
}

ViewCustomerModal.propTypes = {
  open: PropTypes.bool.isRequired,
  handleClose: PropTypes.func.isRequired,
  customer: PropTypes.object.isRequired,
};

export default ViewCustomerModal;
