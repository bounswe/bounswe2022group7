import React from 'react'

import Avatar from '@mui/material/Avatar';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';

export class Event extends React.Component {
    render() {
        return (
            <Card sx={{
                borderRadius: 0
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
                <CardMedia
                    component="img"
                    image="paella.jpg"
                    alt="Paella dish"
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