import { Avatar, Box, Card, CardContent, Grid, LinearProgress, Typography } from '@mui/material';
import InsertChartIcon from '@mui/icons-material/InsertChartOutlined';

export const TasksProgress = (props) => (
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
                
                Complaints 
               
            </Grid>
          </Grid>          
        </Grid>
        
        
      <Grid item>
      
        <Typography
            color="textPrimary"
            variant="h5"
          >      
            

         1,000
            
               
            
          </Typography>
          
        </Grid>
        
      </Grid>
    </CardContent>
  </Card>
);
