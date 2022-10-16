import * as React from 'react';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardActions from '@mui/material/CardActions';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';

const bull = (
    <Box
        component="span"
        sx={{ display: 'inline-block', mx: '2px', transform: 'scale(0.8)' }}
    >
        •
    </Box>
);

export default function ForumPost() {
    return (
        <Card sx={{ mx: 2, my: 2 }}>
            <CardContent>
                <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
                    Latest posts
                </Typography>
                <Typography variant="h5" component="div">
                    Forum Post
                </Typography>
                <Typography sx={{ mb: 1.5 }} color="text.secondary">
                    Topic
                </Typography>
                <Typography variant="body2">
                    content content content content
                    content content content content
                </Typography>
            </CardContent>
            <CardActions>
                <Button size="small">Read More</Button>
            </CardActions>
        </Card>
    );
}
