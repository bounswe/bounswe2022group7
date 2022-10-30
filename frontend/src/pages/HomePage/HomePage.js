import React from 'react'

import { Grid, Link } from '@mui/material';

import { Event } from './Event'
import { ArtItem } from './ArtItem'
import { ForumOverview } from './ForumOverview'

class HomePage extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            error: null,
            isLoaded: false,
            artitems: [],
            events: []
        }
    }

    componentDidMount() {
        const fetchHeaders = {
            Authorization: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VyMSIsImF1dGhvcml0aWVzIjpbImFydGlzdCJdLCJleHAiOjE2OTg2MjQwMDB9.yXtKaBo2Nxt28f2U2wFwlRPG7HDlc91BSeObt-6UzLM'
        }

        fetch('/homepage/getGenericArtItems', {
            headers: fetchHeaders,
            method: 'GET',
        })
            .then((response) => response.json())
            .then((data) => {
                console.log(data)
                this.setState({
                    isLoaded: true,
                    artitems: data
                })
            });
    }

    render() {
        const { error, isLoaded, artitems } = this.state
        if (error) {
            return <div>Error: {error.message}</div>
        } else if (!isLoaded) {
            return <div>Loading...</div>
        } else
            return (
                <Grid
                    container
                >
                    <Grid container item xs={12} md={4} direction='column' wrap='wrap'>
                        {artitems.map(artitem => (
                            <Grid key={artitem.id} item>
                                <Link href={"/art_item/"+artitem.id} underline="none"> 
                                    <ArtItem data={artitem} />
                                </Link>
                            </Grid>
                        ))}
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