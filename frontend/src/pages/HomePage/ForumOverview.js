import React from 'react'

import Paper from '@mui/material/Paper'
import Box from '@mui/material/Box'
import Typography from '@mui/material/Typography'

export class ForumOverview extends React.Component {
    render() {
        return (<Box sx={{
            height: '100%'
        }}>
            <Paper variant='outlined' squar sx={{
                height: '100%'
            }}>
                <Typography variant="subtitle1" color="text.secondary" align="center" sx={{
                    borderBottom: 1,
                    borderColor: 'text.secondary'
                }}>
                    Latest in forum
                </Typography>
            </Paper>
        </Box>
        )
    }
}