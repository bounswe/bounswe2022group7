import React from 'react'

import Avatar from '@mui/material/Avatar';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';

export class Event extends React.Component {
    static defaultProps = {
        data: {
            eventInfo: {},
            id: null
        }
    }

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
                    img={this.props.data.eventInfo?.posterUrl ?? ''}
                    alt="event poster"
                />
                <CardContent>
                    <Typography variant="body2" color="text.secondary">
                        {this.props.data.eventInfo?.description ?? 'No event description'}
                    </Typography>
                </CardContent>
            </Card>
        )
    }
}