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
    marginTop: 3,
    paddingBottom: 20,
    flexDirection: 'column',
    alignItems: 'center',
    p: 2,
    width: 900,
    marginLeft: "auto",
    marginRight: "auto",
  },
};

const ContentLayout =({children}) =>{
  
  return (
    <main SX={styles.main}>
      <Paper sx={styles.paper} variant="outlined">
        {children}
      </Paper>
    </main>
  );
}

export default ContentLayout;