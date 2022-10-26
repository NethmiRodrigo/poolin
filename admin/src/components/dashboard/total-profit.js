import { Avatar, Card, CardContent, Grid, Typography } from '@mui/material';
import AttachMoneyIcon from '@mui/icons-material/AttachMoney';

export const TotalProfit = (props) => (
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
                varificated user 
               
            </Grid>
          </Grid>          
        </Grid>
        
        
      <Grid item>
      
        <Typography
            color="textPrimary"
            variant="h4"
          >      
            
20 Users
         
            
               
            
          </Typography>
          
        </Grid>
        
      </Grid>
    </CardContent>
  </Card>
);
