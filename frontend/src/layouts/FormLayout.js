import React from 'react';
import { Container, CssBaseline, Paper } from '@mui/material';

const styles = {
  main: {
    width: 'auto',
    display: 'block', // Fix IE 11 issue.
    margin: 'auto',
  },
  paper: {

    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    marginTop: 4,
    marginBottom: 4,
    paddingTop: 4,
    paddingBottom: 2,
    maxWidth: 500, 
    width: '95%',
    marginLeft: "auto",
    marginRight: "auto",
  },
};

const FormLayout = ({ children }) => {
  return (
    <main sx={styles.main}>
      <CssBaseline />
      <Paper sx={styles.paper} variant="outlined">
        <Container>
          {children}
        </Container>
      </Paper>
    </main>
  );
}

export default FormLayout;