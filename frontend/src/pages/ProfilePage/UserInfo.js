import React from 'react'

import Paper from '@mui/material/Paper'
import Box from '@mui/material/Box'
import Typography from '@mui/material/Typography'

export class UserInfo extends React.Component {
    static defaultProps = {
        username: ''
    }

    render() {
        return (
            <Box sx={{
                height: '100%'
            }}>
                <Paper variant='outlined' square sx={{
                    height: '100%'
                }}>
                    <Typography variant="subtitle1" color="text.secondary" align="center" sx={{
                        borderBottom: 1,
                        borderColor: 'text.secondary'
                    }}>
                        {this.props.username}
                    </Typography>
                </Paper>
            </Box>
        )
    }
}