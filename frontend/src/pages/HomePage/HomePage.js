import React from 'react'

import Grid from '@mui/material/Grid';

import {Event} from './Event'
import {ArtItem} from './ArtItem'
import {ForumOverview} from './ForumOverview'

class HomePage extends React.Component {
    render() {
        return (
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
        )
    }
}

export default HomePage