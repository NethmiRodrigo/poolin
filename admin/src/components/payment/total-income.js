import { Avatar, Box, Card, CardContent, Grid, Typography } from '@mui/material';
import { useEffect, useState } from 'react';
import { toast } from 'react-toastify';
import { getAllTotalIncome } from 'src/services/payments.service';

export const TotalIncome = ({ incomes, ...rest }) => {
 
  console.log(incomes)
  
  

  return (
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
                Income 
               
            </Grid>
          </Grid>          
        </Grid>
        
        
      <Grid item>
      
        <Typography
            color="textPrimary"
            variant="h5"
          >      
            
LKR 1080
         
            
               
            
          </Typography>
          
        </Grid>
        
      </Grid>
    </CardContent>
  </Card>
)};


