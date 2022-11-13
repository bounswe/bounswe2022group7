import React from 'react';
import { CssBaseline, Paper } from '@mui/material';

const styles = {
  main: {
    width: 'auto',
    display: 'block', // Fix IE 11 issue.
    marginLeft: 100,
    marginRight: 100,
  },
  paper: {
    marginTop: 10,
    paddingBottom: 20,
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    p: 2,
    width: 500,
    marginLeft: "auto",
    marginRight: "auto",
  },
};

const FormLayout =({children}) =>{
  
  return (
    <main SX={styles.main}>
      <CssBaseline />
      <Paper sx={styles.paper} variant="outlined">
        {children}
      </Paper>
    </main>
  );
}

export default FormLayout;