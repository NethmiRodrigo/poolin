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

function viewComplaintsModal({ open, handleClose, complaints }) {
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
      <DialogTitle>Test</DialogTitle>
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

viewComplaintsModal.propTypes = {
  open: PropTypes.bool.isRequired,
  handleClose: PropTypes.func.isRequired,
  complaints: PropTypes.object.isRequired,
};

export default viewComplaintsModal;
