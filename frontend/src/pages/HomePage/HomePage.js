import React from 'react'

import Grid from '@mui/material/Grid';
import Box from '@mui/material/Box';

import { Event } from './Event'
import { ArtItem } from './ArtItem'
import { ForumOverview } from './ForumOverview'

class HomePage extends React.Component {
    render() {
        return (
            <Grid
                container
            >
                <Grid container item xs={12} md={4} direction='column' wrap='wrap'>
                    <Grid item>
                        <Event />
                    </Grid>
                    <Grid item>
                        <ArtItem />
                    </Grid>
                    <Grid item>
                        <Event />
                    </Grid>
                </Grid>
                <Grid container item xs={12} md={4} direction='column' wrap='wrap'>
                    <Grid item>
                        <ArtItem />
                    </Grid>
                    <Grid item>
                        <Event />
                    </Grid>
                    <Grid item>
                        <Event />
                    </Grid>
                </Grid>
                <Grid container item xs={12} md={4} direction='column' wrap='wrap' sx={{
                    display: { xs: 'none', md: 'block' }
                }}>
                    <Grid item sx={{
                        height: '100%'
                    }}>
                        <ForumOverview />
                    </Grid>
                </Grid>
            </Grid>
        )
    }
}

export default HomePage