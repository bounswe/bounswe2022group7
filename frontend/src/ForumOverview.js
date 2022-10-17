import React from 'react'

import Paper from '@mui/material/Paper'
import Box from '@mui/material/Box'
import Typography from '@mui/material/Typography'

export class ForumOverview extends React.Component {
    render() {
        return (<Box sx={{
            my: 2,
            borderRadius: 1,
            minHeight: '75%',
            width: '75%',
            boxShadow: 3
        }}>
            <Paper elevation={3} >
                <Typography variant="subtitle1" color="text.secondary" align="center">
                    Latest in forum
                </Typography>
            </Paper>
        </Box>
        )
    }
}