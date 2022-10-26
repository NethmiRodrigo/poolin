import { Avatar, Box, Card, CardContent, Grid, Typography } from '@mui/material';
import ArrowDownwardIcon from '@mui/icons-material/ArrowDownward';
import MoneyIcon from '@mui/icons-material/Money';

export const Budget = (props) => (
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
                Profit 
               
            </Grid>
          </Grid>          
        </Grid>
        
        
      <Grid item>
      
        <Typography
            color="textPrimary"
            variant="h4"
          >      
            
LK : 6220/-
         
            
               
            
          </Typography>
          
        </Grid>
        
      </Grid>
    </CardContent>
  </Card>
);
