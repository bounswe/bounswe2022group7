import React from "react";

import { Grid, Typography } from '@mui/material';

function IconWithText(props) {
    
  const { icon, text, variant } = props

  return (
    <Grid container wrap="nowrap" paddingTop={2}>
      <Grid item>
        {icon}
      </Grid>
      <Grid item justifyContent="left" xs zeroMinWidth>
        <Typography variant={variant}>
          {text}
        </Typography>
      </Grid>
    </Grid>
  )
}

export default IconWithText