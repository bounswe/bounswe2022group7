import React, { useEffect } from 'react'

import { Grid, Link } from '@mui/material';

import { Event } from './Event'
import { ArtItem } from './ArtItem'
import { ForumOverview } from './ForumOverview'
import { useAuth } from "../../auth/useAuth"

const HomePage = () => {
    const [error, setError] = React.useState(null)
    const [isLoaded, setLoaded] = React.useState(false)
    const [artitems, setArtitems] = React.useState([])
    const [events, setEvents] = React.useState([])


    const { saveToken } = useAuth()
    saveToken('eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1c2VyMSIsImF1dGhvcml0aWVzIjpbImFydGlzdCJdLCJleHAiOjE2OTg2MjQwMDB9.yXtKaBo2Nxt28f2U2wFwlRPG7HDlc91BSeObt-6UzLM')
    const { token } = useAuth()
    const fetchHeaders = {
        Authorization: 'Bearer ' + token
    }

    useEffect(() => {
        const promise1 = fetch('/homepage/getGenericArtItems', {
            headers: fetchHeaders,
            method: 'GET',
        })
            .then((response) => response.json())
            .then((data) => {
                console.count(data)
                setLoaded(true)
                setArtitems(data)
            },
                error => {
                    setLoaded(true)
                    setError(error)
                })

        const promise2 = fetch('/homepage/getGenericEvents', {
            headers: fetchHeaders,
            method: 'GET',
        })
            .then((response) => response.json())
            .then((data) => {
                console.count(data)
                setLoaded(true)
                setEvents(data)
            },
                error => {
                    setLoaded(true)
                    setError(error)
                })

        return () => {
            promise1.cancel()
            promise2.cancel()
        }
    }, [])

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
                            <Link href={"/art_item/" + artitem.id} underline="none">
                                <ArtItem data={artitem} />
                            </Link>
                        </Grid>
                    ))}
                </Grid>
                <Grid container item xs={12} md={4} direction='column' wrap='wrap'>
                    {events.map(event => (
                        <Grid key={event.id} item>
                            <Link href={'/event/' + event.id} underline='none'>
                                <Event data={event} />
                            </Link>

                        </Grid>
                    ))}

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

export default HomePage