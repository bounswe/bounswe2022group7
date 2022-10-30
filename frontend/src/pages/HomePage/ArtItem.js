import React from 'react'

import Avatar from '@mui/material/Avatar';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';

export class ArtItem extends React.Component {
    static defaultProps = {
        data: {
            artItemInfo: {},
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
                    title="My Latest Work"
                    subheader="September 18, 2022"
                />
                <CardMedia
                    component="img"
                    height="194"
                    image={this.props.data.artItemInfo.imageUrl}
                    alt="art item"
                />
                <CardContent>
                    <Typography variant="body2" color="text.secondary">
                        {this.props.data.artItemInfo.description}
                    </Typography>
                </CardContent>
            </Card>
        )
    }
}