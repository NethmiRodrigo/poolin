import React from "react";
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
  Typography,
  Divider,
} from "@mui/material";
import Slide from "@mui/material/Slide";

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

function ViewReferralModal({ open, handleClose, referral }) {
  return (
    <Dialog
      open={open}
      TransitionComponent={Transition}
      onClose={handleClose}
      fullWidth
      maxWidth="md"
      aria-describedby="alert-dialog-slide-description"
    >
      <DialogTitle>VIP ID: </DialogTitle>
      <DialogContent>
        <Card>
          <CardContent>
            {/* <Grid container spacing={3}>
              <Grid item md={12} xs={12}>
                <Typography variant="h6" component="div">
                  Referral Code Owner Details
                </Typography>
                <Divider variant="middle" />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Email"
                  value={referral?.owner}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              {referral?.ownerData.isSignUpFilled && (
                <>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="User Name"
                      value={referral?.ownerData.fullName}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="Mobile Number"
                      value={referral?.ownerData.mobileNo ? referral?.ownerData.mobileNo : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="State"
                      value={referral?.ownerData.state ? referral?.ownerData.state : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="City"
                      value={referral?.ownerData.city ? referral?.ownerData.city : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="Allergies"
                      value={referral?.ownerData.allergies ? referral?.ownerData.allergies : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                </>
              )}
              <Grid item md={12} xs={12}>
                <Typography variant="h6" component="div">
                  Referred By User Details
                </Typography>
                <Divider variant="middle" />
              </Grid>
              <Grid item md={6} xs={12}>
                <TextField
                  label="Email"
                  value={referral?.referredBy.id}
                  InputProps={{
                    readOnly: true,
                  }}
                  InputLabelProps={{ shrink: true }}
                />
              </Grid>
              {referral?.referredBy.isSignUpFilled && (
                <>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="User Name"
                      value={referral?.referredBy.fullName}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="Mobile Number"
                      value={referral?.referredBy.mobileNo ? referral?.referredBy.mobileNo : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="State"
                      value={referral?.referredBy.state ? referral?.referredBy.state : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="City"
                      value={referral?.referredBy.city ? referral?.referredBy.city : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item md={6} xs={12}>
                    <TextField
                      label="Allergies"
                      value={referral?.referredBy.allergies ? referral?.referredBy.allergies : ""}
                      InputProps={{
                        readOnly: true,
                      }}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                </>
              )}
            </Grid> */}
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

ViewReferralModal.propTypes = {
  open: PropTypes.bool.isRequired,
  handleClose: PropTypes.func.isRequired,
  referral: PropTypes.object,
};

export default ViewReferralModal;