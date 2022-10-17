import React from 'react'

import Avatar from '@mui/material/Avatar';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';
import Typography from '@mui/material/Typography';

export class Event extends React.Component {
    render() {
        return (
            <Card raised sx={{
                width: '75%',
                mx: 'auto',
                my: 2
            }}>
                <CardHeader
                    avatar={
                        <Avatar sx={{ bgcolor: 'secondary.main' }} aria-label="user">
                            G
                        </Avatar>
                    }
                    title="Upcoming Event"
                    subheader="September 18, 2022"
                />
                <CardContent>
                    <Typography variant="body2" color="text.secondary">
                        Event details
                    </Typography>
                </CardContent>
            </Card>
        )
    }
}