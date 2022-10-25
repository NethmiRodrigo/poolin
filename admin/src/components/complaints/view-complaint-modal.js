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
  Typography,
} from "@mui/material";
import Slide from "@mui/material/Slide";
import { Box } from "@mui/system";

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

function ViewComplaintsModal({ open, handleClose, complaints }) {
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
      <DialogTitle>Trip Details</DialogTitle>
      <DialogContent>
        <Card>
          <CardContent>
            <Grid container spacing={5}>
              <Grid row xs={12}>
                <Box  m={2} pt={3} >
                <Typography>
                {complaints.description}
                </Typography>
                </Box>
              </Grid>
              
              <Grid item md={6} xs={12}>
                <TextField
                  label="Trip ID"
                  value={complaints.tripId}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
                
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Staus"
                  value={complaints.status}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Complainer Name"
                  value={`${complaints.complainer.firstname} ${complaints.complainer.lastname}`}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Complainer Email"
                  value={complaints.complainer.email}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Complainer Number"
                  value={complaints.complainer.mobile}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Complainee Name"
                  value={`${complaints.complainee.firstname} ${complaints.complainee.lastname}`}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Complainee Email"
                  value={complaints.complainee.email}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>

              <Grid item md={6} xs={12}>
                <TextField
                  label="Complainee Number"
                  value={complaints.complainee.mobile}
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
        <Button autofocus onClick={handleClose}>
          Blacklist
        </Button>
      </DialogActions>
    </Dialog>
  );
}

ViewComplaintsModal.propTypes = {
  open: PropTypes.bool.isRequired,
  handleClose: PropTypes.func.isRequired,
  complaints: PropTypes.object.isRequired,
};

export default ViewComplaintsModal;
