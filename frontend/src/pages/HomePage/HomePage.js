import React, { useEffect } from 'react'

import { CircularProgress, Typography } from '@mui/material';

import Stack from '@mui/material/Stack';
import { useAuth } from "../../auth/useAuth"
import GenericCardLayout from '../../layouts/GenericCardLayout';
import FeedCard from './FeedCard';
import FilterChip from '../../components/FilterChip';

const HomePage = () => {
    const [error, setError] = React.useState(null)
    const [userData, setUserData] = React.useState(null)
    const [displayContent, setDisplayContent] = React.useState([]);

    const [artContent, setArtContent] = React.useState({ content: [], loaded: false });
    const [eventContent, setEventContent] = React.useState({ content: [], loaded: false });
    const [discussionContent, setDiscussionContent] = React.useState({ content: [], loaded: false });


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
            case "Art Items":
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

        setArtContent({ content: [], loaded: false });
        setEventContent({ content: [], loaded: false });
        setDiscussionContent({ content: [], loaded: false });

        fetch('api/homepage/artItem', fetchArgs)
            .then((response) => response.json())
            .then((data) => {


                const artItems = data.map((item) => {

                    return {
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
                });

                setArtContent({ content: artItems, loaded: true });
            })
            .catch((error) => {
                setArtContent({ content: [], loaded: true });
                setError(error)
            })


        fetch('api/homepage/event', fetchArgs)
            .then((response) => response.json())
            .then((data) => {
                const events = data.map((item) => {
                    return {
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
                });

                setEventContent({ content: events, loaded: true });
            })
            .catch((error) => {
                setEventContent({ content: [], loaded: true });
                setError(error)
            })

        fetch('api/discussionPost', fetchArgs)
            .then((response) => response.json())
            .then((data) => {
                const discussionPosts = data.map((item) => {
                    return {
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

                });

                setDiscussionContent({ content: discussionPosts, loaded: true });

            })
            .catch((error) => {
                setDiscussionContent({ content: [], loaded: true });
                setError(error)
            })


    }, [token, userData])

    // Merge and sort the content
    React.useEffect(() => {
        if (artContent.loaded && eventContent.loaded && discussionContent.loaded) {
            const content = [...artContent.content, ...eventContent.content, ...discussionContent.content];
            content.sort((a, b) => {
                return new Date(b.content.creationDate) - new Date(a.content.creationDate);
            });
            setDisplayContent(content);
        }
    }, [artContent, eventContent, discussionContent])


    if (error) {
        return <div>Error: {error.message}</div>
    } else if (!artContent.loaded || !eventContent.loaded || !discussionContent.loaded) {
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
                    <FilterChip label="Art Items" filterState={filter.artitem} onClick={(event) => handleFilter(event)} />
                    <FilterChip label="Events" filterState={filter.event} onClick={(event) => handleFilter(event)} />
                    <FilterChip label="Discussions" filterState={filter.discussionPost} onClick={(event) => handleFilter(event)} />

                </Stack>
                <Stack spacing={2} direction="column">
                    {displayContent.map((item, index) => {
                        return (
                            <FeedCard key={index} filtered={item.content.type === "artitem" ? filter.artitem : (item.content.type === "event" ? filter.event : filter.discussionPost)} content={item.content} creator={item.creator} />
                        )
                    })}
                </Stack>
            </GenericCardLayout>
        )
}

export default HomePage