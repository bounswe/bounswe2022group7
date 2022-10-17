import ReactDOM from 'react-dom/client'
import React from 'react'

import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';

import ResponsiveAppBar from './ResponsiveAppBar'
import { Event } from './Event';
import { ForumOverview } from './ForumOverview';
import { ArtItem } from './ArtItem';

class HomePage extends React.Component {
    render() {
        return (
            <Box >
                <Box>
                    <ResponsiveAppBar />
                </Box>
                <Grid container sx={{
                    gap: 2
                }}>
                    <Grid item xs={7}>
                        <Event />
                        <ArtItem />
                        <Event />
                    </Grid>
                    <Grid item xs>
                        <ForumOverview />
                    </Grid>
                </Grid>
            </Box>
        )
    }
}

const container = document.querySelector('#root')
const root = ReactDOM.createRoot(container)
root.render(<HomePage />)