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
        marginBottom: 4,
        paddingTop: 4,
        paddingBottom: 2,
        width: '95%',
        marginLeft: "auto",
        marginRight: "auto",
    },
};

export default function GenericCardLayout(props) {


    return (
        <main sx={styles.main}>
            <CssBaseline />
            <Paper sx={{ ...styles.paper, maxWidth: props.maxWidth, marginTop: props.customTopMargin }} variant="outlined">
                <Container>
                    {props.children}
                </Container>
            </Paper>
        </main>
    );
}

GenericCardLayout.defaultProps = {
    maxWidth: 750,
    customTopMargin: 4,
};