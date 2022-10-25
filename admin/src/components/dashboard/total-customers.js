import { Avatar, Box, Card, CardContent, Grid, Typography } from '@mui/material';
import ArrowUpwardIcon from '@mui/icons-material/ArrowUpward';
import PeopleIcon from '@mui/icons-material/PeopleOutlined';

export const TotalCustomers = (props) => (
  <Card
    sx={{ height: '80%' }}
    
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
                Payable 
               
            </Grid>
          </Grid>          
        </Grid>
        
        
      <Grid item>
      
        <Typography
            color="textPrimary"
            variant="h4"
          >      
            
LK : 4000
         
            
               
            
          </Typography>
          
        </Grid>
        
      </Grid>
    </CardContent>
  </Card>
);
