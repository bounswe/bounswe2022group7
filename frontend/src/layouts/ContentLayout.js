import React from 'react';
import { Paper } from '@mui/material';

const styles = {
  main: {
    width: 'auto',
    display: 'block', // Fix IE 11 issue.
  },
  paper: {
    marginTop: 3,
    paddingBottom: 20,
    flexDirection: 'column',
    alignItems: 'center',
    maxWidth: "95vh",
    width: "100%",
    marginLeft: "auto",
    marginRight: "auto",
  },
};

const ContentLayout =({children}) =>{
  
  return (
    <main style={styles.main}>
      <Paper style={styles.paper} variant="outlined">
        {children}
      </Paper>
    </main>
  );
}

export default ContentLayout;