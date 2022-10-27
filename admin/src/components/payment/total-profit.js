import { Avatar, Box, Card, CardContent, Grid, Typography } from "@mui/material";

export const TotalProfit = (props) => (
  <Card sx={{ height: "80%" }} {...props}>
    <CardContent>
      <Grid container spacing={1} sx={{ justifyContent: "space-around" }}>
        <Grid item>
          <Grid row>
            <Grid item fontSize={20}>
              Total <br></br>
              Profit
            </Grid>
          </Grid>
        </Grid>

        <Grid item>
          <Typography color="textPrimary" variant="h5">
            LKR 4,845
          </Typography>
        </Grid>
      </Grid>
    </CardContent>
  </Card>
);
