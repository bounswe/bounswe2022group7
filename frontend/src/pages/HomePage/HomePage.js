import React, { useEffect } from 'react'

import Alert from '@mui/material/Alert';
import CircularProgress from '@mui/material/CircularProgress';
import Snackbar from '@mui/material/Snackbar';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';

import { useAuth } from "../../auth/useAuth"
import GenericCardLayout from '../../layouts/GenericCardLayout';
import FeedCard from './FeedCard';
import FilterChip from '../../components/FilterChip';

const HomePage = ({onResponse}) => {
    const [error, setError] = React.useState(null)
    const [userData, setUserData] = React.useState(null)
    const [displayContent, setDisplayContent] = React.useState([]);

    const [snackbar, setSnackbar] = React.useState({
        open: false,
        message: "",
        severity: "success",
        handleClose: () => { setSnackbar({ ...snackbar, open: false }) }
    });

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
        if (token) {
            fetch("/api/profile", {
                method: "GET",
                headers: {
                    "Authorization": "Bearer " + token,
                }
            })
                .then(response => response.json())
                .then(data => {
                    setUserData(data);
                })
        }
    }, [token])


    // Filter function to filter out the content that is not selected
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

    // Checks if the art item is bookmarked by the user
    const bookmarkStatus = (type, id) => {
        if (userData === null) {
            return false;
        }
        if (type === "artitem") {
            return userData ? userData.bookmarkedArtItemIds.includes(id) : false;
        }
        else if (type === "event") {
            return userData ? userData.bookmarkedEventIds.includes(id) : false;
        }
    };

    // Checks if the user is following the creator of the art item
    const followStatus = (username) => {
        if (userData === null) {
            return true;
        }
        if (userData.accountInfo.username === username) {
            return true;
        }
        else {
            return userData.followingUsernames.includes(username);
        }
    };

    // Checks if art item is liked by the user
    const artLikeStatus = (id) => {
        if (userData === null) {
            return false;
        }
        return userData.likedArtItemIds.includes(id);
    };

    // Checks if event is participated by the user
    const eventParticipateStatus = (id) => {
        if (userData === null) {
            return false;
        }
        return userData.participatedEventIds.includes(id);
    };

    // Updates the follow status of the user
    const followUpdate = (username) => {

        if (userData === null) {
            return;
        }

        const updatedContent = displayContent.map((item) => {
            if (item.creator.username === username) {
                item.creator.followed = true;
            }
            return item;
        });

        setDisplayContent(updatedContent);
    };

    // Loads all items from the database
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
                            imageId: item.creatorAccountInfo.profilePictureId,
                            followed: followStatus(item.creatorAccountInfo.username),
                        },
                        content: {
                            bookmarked: bookmarkStatus("artitem", item.id),
                            type: "artitem",
                            id: item.id,
                            title: item.name,
                            description: item.description,
                            imageId: item.imageId,
                            creationDate: item.creationDate,
                            commentCount: item.commentList.length,
                            liked: artLikeStatus(item.id),
                            likeCount: item.likedByUsernames.length,
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
                            imageId: item.creatorAccountInfo.profilePictureId,
                            followed: followStatus(item.creatorAccountInfo.username),
                        },
                        content: {
                            bookmarked: bookmarkStatus("event", item.id),
                            type: "event",
                            id: item.id,
                            title: item.eventInfo.title,
                            description: item.eventInfo.description,
                            imageId: item.eventInfo.posterId,
                            creationDate: item.creationDate,
                            participated: eventParticipateStatus(item.id),
                            participantCount: item.participantUsernames.length,
                            commentCount: item.commentList.length,
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
                            imageId: item.creatorAccountInfo.profilePictureId,
                            followed: followStatus(item.creatorAccountInfo.username),
                        },
                        content: {
                            type: "discussionPost",
                            id: item.id,
                            title: item.title,
                            description: item.textBody,
                            creationDate: item.creationDate,
                            commentCount: item.commentList.length,
                            voteCount: item.upVotedUsernames.length - item.downVotedUsernames.length,
                            voteStatus: userData && (item.upVotedUsernames.includes(userData.accountInfo.username) ? 1 : item.downVotedUsernames.includes(userData.accountInfo.username) ? -1 : 0)
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
        return (
            <GenericCardLayout maxWidth="md" customTopMargin={1}>
                <CircularProgress />
            </GenericCardLayout>
        );
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
                            <FeedCard
                                followAction={() => followUpdate(item.creator.username)}
                                key={index}
                                filtered={item.content.type === "artitem" ? filter.artitem : (item.content.type === "event" ? filter.event : filter.discussionPost)}
                                onResponse={(severity, message) => onResponse(severity, message)}
                                content={item.content}
                                creator={item.creator} />
                        )
                    })}
                </Stack>
            </GenericCardLayout>
        )
}

export default HomePage;