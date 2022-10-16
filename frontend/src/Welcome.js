import ReactDOM from 'react-dom/client'
import React from 'react'
import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';

import ResponsiveAppBar from './ResponsiveAppBar'
import Event from './Event';
import ArtItem from './ArtItem';
import ForumPost from './ForumPost';

export class Welcome extends React.Component {
    render() {
        return (
            <p id={this.props.id}>Hello, {this.props.name}</p>
        )
    }
}

function BasicGrid() {
    return (
        <Box >
            <Box>
                <ResponsiveAppBar />
            </Box>
            <Grid container spacing={2} sx={{
                justifyContent: 'space-evenly',
                mx: "auto",
                my: 2,
            }}>
                <Grid md={5}>
                    <Event />
                    <Event />
                    <Event />
                </Grid>
                <Grid md={3}>
                    <ArtItem />
                    <ArtItem />
                    <ArtItem />
                </Grid>
                <Grid md>
                    <ForumPost />
                    <ForumPost />
                    <ForumPost />
                </Grid>
            </Grid>
        </Box>
    )
}

const root = document.querySelector('body')
ReactDOM.createRoot(root).render(<BasicGrid />)
