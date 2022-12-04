import React, { useEffect } from 'react'

import { CircularProgress, Typography } from '@mui/material';

import Stack from '@mui/material/Stack';
import { useAuth } from "../../auth/useAuth"
import GenericCardLayout from '../../layouts/GenericCardLayout';
import FeedCard from './FeedCard';
import FilterChip from '../../components/FilterChip';

const HomePage = () => {
    const [error, setError] = React.useState(null)
    const [isLoaded, setLoaded] = React.useState(false)
    const [userData, setUserData] = React.useState(null)
    const [content, setContent] = React.useState([])

    const [filter, setFilter] = React.useState({
        artitem: true,
        event: true,
        discussionPost: true,
    })


    const { token } = useAuth()

    useEffect(() => {
        fetch("/api/profile", {
            method: "GET",
            headers: {
                "Authorization": "Bearer " + token,
            }
        })
            .then(response => response.json())
            .then(data => {
                setUserData(data);
            }
            )
    }, [token])


    function handleFilter(event) {
        switch (event.target.textContent) {
            case "Artworks":
                setFilter({ ...filter, artitem: !filter.artitem });
                break;
            case "Events":
                setFilter({ ...filter, event: !filter.event });
                break;
            case "Discussions":
                setFilter({ ...filter, discussionPost: !filter.discussionPost });
                break;
            default:
                break;
        }
    }



    useEffect(() => {
        const fetchArgs = {
            method: "GET",
        }
        if (token) fetchArgs.headers = { Authorization: "Bearer " + token }

        setLoaded(false);
        setContent([]);

        fetch('api/homepage/artItem', fetchArgs)
            .then((response) => response.json())
            .then((data) => {

                data.forEach((item) => {

                    const artItem = {
                        creator: {
                            id: item.creatorAccountInfo.id,
                            username: item.creatorAccountInfo.username,
                            followed: userData ? userData.following.includes(item.creatorAccountInfo.username) : false,
                            imageId: item.creatorAccountInfo.profilePictureId,
                        },
                        content: {
                            type: "artitem",
                            id: item.id,
                            title: item.name,
                            description: item.description,
                            imageId: item.imageId,
                            creationDate: item.creationDate,
                        }
                    }

                    setContent(content => [...content, artItem])
                });

                setLoaded(true);


            })
            .catch((error) => {
                setLoaded(true);
                setError(error)
            })


        fetch('api/homepage/event', fetchArgs)
            .then((response) => response.json())
            .then((data) => {
                data.forEach((item) => {
                    const event = {
                        creator: {
                            id: item.creatorAccountInfo.id,
                            username: item.creatorAccountInfo.username,
                            followed: userData ? userData.following.includes(item.creatorAccountInfo.username) : false,
                            imageId: item.creatorAccountInfo.profilePictureId,
                        },
                        content: {
                            type: "event",
                            id: item.id,
                            title: item.eventInfo.title,
                            description: item.eventInfo.description,
                            imageId: item.eventInfo.posterId,
                            creationDate: item.creationDate,
                        }
                    }

                    setContent(content => [...content, event])
                });

                setLoaded(true);
                // setContent((c) => c.sort((a, b) => (a.content.creationDate > b.content.creationDate) ? -1 : 1));

            })
            .catch((error) => {
                setLoaded(true)
                setError(error)
            })

        fetch('api/discussionPost', fetchArgs)
            .then((response) => response.json())
            .then((data) => {
                data.forEach((item) => {

                    const discussionPost = {
                        creator: {
                            id: item.creatorAccountInfo.id,
                            username: item.creatorAccountInfo.username,
                            followed: userData ? userData.following.includes(item.creatorAccountInfo.username) : false,
                            imageId: item.creatorAccountInfo.profilePictureId,
                        },
                        content: {
                            type: "discussionPost",
                            id: item.id,
                            title: item.title,
                            description: item.textBody,
                            creationDate: item.creationDate,
                        }
                    }

                    setContent(content => [...content, discussionPost])
                });

                setLoaded(true);

            })
            .catch((error) => {
                setLoaded(true);
                setError(error)
            })


    }, [token, userData])


    // TODO: Sort by date
    // useEffect(() => {
    //     const sortedContent = content.sort((a, b) => (a.content.creationDate > b.content.creationDate) ? -1 : 1);
    //     setContent(sortedContent);
    // }, [isLoaded])

    if (error) {
        return <div>Error: {error.message}</div>
    } else if (!isLoaded) {
        return <div><CircularProgress /></div>
    } else
        return (
            <GenericCardLayout maxWidth="md" customTopMargin={1}>
                <Typography variant="h4" component="h2" gutterBottom>
                    Feed
                </Typography>
                <Stack spacing={2} direction="row" justifyContent="flex-start" alignItems="center" sx={{ mb: 2, width: "100%" }}>
                    <Typography variant="body1" sx={{ fontSize: 14, fontWeight: 600, color: 'gray' }}>
                        Filters:
                    </Typography>
                    <FilterChip label="Artworks" filterState={filter.artitem} onClick={(event) => handleFilter(event)} />
                    <FilterChip label="Events" filterState={filter.event} onClick={(event) => handleFilter(event)} />
                    <FilterChip label="Discussions" filterState={filter.discussionPost} onClick={(event) => handleFilter(event)} />

                </Stack>
                <Stack spacing={2} direction="column">
                    {content.map((item, index) => {
                        return (
                            <FeedCard key={index} filtered={item.content.type === "artitem" ? filter.artitem : (item.content.type === "event" ? filter.event : filter.discussionPost)} content={item.content} creator={item.creator} />
                        )
                    })}
                </Stack>
            </GenericCardLayout>
        )
}

export default HomePage