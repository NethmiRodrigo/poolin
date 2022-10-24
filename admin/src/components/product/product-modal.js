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

function ViewProductModal({ open, handleClose, customer }) {
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
            <Grid container spacing={3}>
              <Grid item md={12} xs={12}>
                {customer?.avatarUrl && (
                  <Avatar
                    src={customer?.avatarUrl}
                    alt="profile picture"
                    variant="rounded"
                    sx={{ width: 150, height: 150, marginBottom: 2 }}
                  />
                )}
              </Grid>
              {Object.keys(customer).map((key) =>
                key !== "avatarUrl" && key !== "address" ? (
                  <Grid item md={6} xs={12} key={`${key}${Math.random() * 1000}`}>
                    <TextField
                      label={lodash.startCase(key)}
                      value={customer[key]}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                ) : (
                  ""
                )
              )}
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

ViewProductModal.propTypes = {
  open: PropTypes.bool.isRequired,
  handleClose: PropTypes.func.isRequired,
  customer: PropTypes.object.isRequired,
};

export default ViewProductModal;
