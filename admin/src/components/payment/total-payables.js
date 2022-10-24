import { Avatar, Box, Card, CardContent, Grid, Typography } from '@mui/material';

export const TotalPayables = (props) => (
  <Card
    sx={{ height: '80%' }}
    {...props}
  >
    <CardContent>
      <Grid
        container
        spacing={1}
        sx={{ justifyContent: 'space-around' }}
      >
        <Grid item>
          <Grid row>
            <Grid item
            fontSize={20}
            >
                Total <br></br>
                Payables
            </Grid>
          </Grid>          
        </Grid>
        
        <Grid item>
        <Typography
            color="textPrimary"
            variant="h4"
          >
            $24k
          </Typography>
        </Grid>
      </Grid>
    </CardContent>
  </Card>
);
