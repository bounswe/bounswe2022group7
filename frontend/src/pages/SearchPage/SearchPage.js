import * as React from "react";

import { useAuth } from "../../auth/useAuth";
import { ArtItemPreview } from "../../components/ArtItemPreview";
import { DiscussionPostPreview } from "../../components/DiscussionPostPreview";
import { EventPreview } from "../../components/EventPreview";
import GenericCardLayout from "../../layouts/GenericCardLayout";


import Box from "@mui/material/Box";
import Container from "@mui/material/Container";
import Divider from "@mui/material/Divider";
import Stack from "@mui/material/Stack";
import Typography from "@mui/material/Typography";

import UserPreview from "../../components/UserPreview";
import ArrowForwardIosIcon from "@mui/icons-material/ArrowForwardIos";

import { Link, useLocation } from "react-router-dom";
import { Paper } from "@mui/material";


function useQuery() {
    const { search } = useLocation();

    return React.useMemo(() => new URLSearchParams(search), [search]);
}


export default function SearchPage() {
    const [error, setError] = React.useState(null);
    const [onlineGalleryData, setOnlineGalleryData] = React.useState([]);
    const [physicalExhibitionData, setPhysicalExhibitionData] = React.useState([]);
    const [artItemData, setArtItemData] = React.useState([]);
    const [userProfileData, setUserProfileData] = React.useState([]);
    const [discussionPostData, setDiscussionPostData] = React.useState([]);

    const { userData } = useAuth();

    let query = useQuery().get("keywords");


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


    React.useEffect(() => {
        fetch(`/api/search_user?keywords=${encodeURIComponent(query)}`)
            .then((response) => response.json())
            .then((data) => {
                if (data.error) {
                    setError(data.error);
                }
                else {
                    const users = data.map((item) => {
                        return (
                            {
                                username: item.accountInfo.username,
                                imageId: item.accountInfo.profileImageId,
                                followed: followStatus(item.accountInfo.username),
                            })
                    });
                    setUserProfileData(users);
                }
            })
            .catch((error) => {
                setError(error);
            })
    }, [query]);


    React.useEffect(() => {
        fetch(`/api/search_physical_exhibition?keywords=${encodeURIComponent(query)}`)
            .then((response) => response.json())
            .then((data) => {
                if (data.error) {
                    setError(data.error);
                }
                else {
                    const events = data.map((item) => {
                        return {
                            creator: {
                                username: item.creatorAccountInfo.username,
                                imageId: item.creatorAccountInfo.profileImageId,
                                followed: followStatus(item.creatorAccountInfo.username),

                            },
                            content: {
                                id: item.id,
                                title: item.eventInfo.title,
                                description: item.eventInfo.description,
                                creationDate: item.creationDate,
                                imageId: item.eventInfo.posterId,
                                participated: eventParticipateStatus(item.id),
                                participantCount: item.participantUsernames.length,
                                commentCount: item.commentList.length,
                            }
                        }
                    });
                    setPhysicalExhibitionData(events);
                }
            })
            .catch((error) => {
                setError(error);
            })
    }, [query]);


    React.useEffect(() => {
        fetch(`/api/search_online_gallery?keywords=${encodeURIComponent(query)}`)
            .then((response) => response.json())
            .then((data) => {
                if (data.error) {
                    setError(data.error);
                }
                else {
                    const events = data.map((item) => {
                        return {
                            creator: {
                                username: item.creatorAccountInfo.username,
                                imageId: item.creatorAccountInfo.profileImageId,
                                followed: followStatus(item.creatorAccountInfo.username),
                            },
                            content: {
                                id: item.id,
                                title: item.eventInfo.title,
                                description: item.eventInfo.description,
                                creationDate: item.creationDate,
                                imageId: item.eventInfo.posterId,
                                participated: eventParticipateStatus(item.id),
                                participantCount: item.participantUsernames.length,
                                commentCount: item.commentList.length,
                            }
                        }
                    });
                    setOnlineGalleryData(events);
                }
            })
            .catch((error) => {
                setError(error);
            })
    }, [query]);

    React.useEffect(() => {
        fetch(`/api/search_discussion_post?keywords=${encodeURIComponent(query)}`)
            .then((response) => response.json())
            .then((data) => {
                if (data.error) {
                    setError(data.error);
                }
                else {
                    const discussionPosts = data.map((item) => {
                        return {
                            creator: {
                                username: item.creatorAccountInfo.username,
                                imageId: item.creatorAccountInfo.profileImageId,
                                followed: followStatus(item.creatorAccountInfo.username),

                            },
                            content: {
                                id: item.id,
                                title: item.title,
                                creationDate: item.creationDate,
                                description: item.textBody,
                                commentCount: item.commentList.length,
                                voteCount: item.upVotedUsernames.length - item.downVotedUsernames.length,
                                voteStatus: userData && (item.upVotedUsernames.includes(userData.accountInfo.username) ? 1 : item.downVotedUsernames.includes(userData.accountInfo.username) ? -1 : 0)
                            }
                        }

                    });
                    setDiscussionPostData(discussionPosts);
                }
            })
            .catch((error) => {
                setError(error);
            })
    }, [query]);



    React.useEffect(() => {
        fetch(`/api/search_art_item?keywords=${encodeURIComponent(query)}`)
            .then((response) => response.json())
            .then((data) => {
                if (data.error) {
                    setError(data.error);
                }
                else {
                    const artItems = data.map((item) => {

                        return {
                            creator: {
                                username: item.creatorAccountInfo.username,
                                imageId: item.creatorAccountInfo.profileImageId,
                                followed: followStatus(item.creatorAccountInfo.username),

                            },
                            content: {
                                id: item.id,
                                title: item.name,
                                description: item.description,
                                creationDate: item.creationDate,
                                imageId: item.imageId,
                                commentCount: item.commentList.length,
                                liked: artLikeStatus(item.id),
                                likeCount: item.likedByUsernames.length,
                            }
                        }
                    });
                    setArtItemData(artItems);
                }
            })
            .catch((error) => {
                setError(error);
            })
    }, [query]);

    const renderUser = (info, date) => {
        const dateObject = new Date(date);
        const dateStr = dateObject.toLocaleString();

        return (
            <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center" sx={{ marginBottom: 1 }}>
                <UserPreview user={info} followDisable />
                <Typography variant="body2" color="text.secondary">
                    {"posted on " + dateStr}
                </Typography>
            </Stack>
        );
    }


    return (
        <>
            <Container sx={{ maxWidth: 750, mt: 4 }}>
                <Typography variant="h4" component="h3" gutterBottom sx={{ fontWeight: 600 }}>
                    Showing search results for "{query}"
                </Typography>
            </Container>
            <Stack spacing={2} >
                {userProfileData.length > 0 &&
                    <GenericCardLayout key="user-profile" customTopMargin={0}>
                        <Stack direction="column" spacing={4}>
                            <Typography key="users-title" variant="h5" component="h2" gutterBottom sx={{ fontWeight: 600 }}>
                                Users:
                            </Typography>
                            {userProfileData.map((item) => {
                                return (
                                    <Box key={"user-detail-" + item.username} width='100%'>
                                        <Box position="relative" width='100%'>
                                            <UserPreview user={item} />
                                            <Link to={`/profile/${item.username}`} style={{ textDecoration: 'none' }}>
                                                <ArrowForwardIosIcon fontSize="small" sx={{ color: 'gray', position: 'absolute', top: '50%', right: 0, transform: 'translate(0, -50%)' }} />
                                            </Link>
                                        </Box>
                                    </Box>
                                );
                            })}
                        </Stack>
                    </GenericCardLayout>
                }
                {onlineGalleryData.length > 0 &&
                    <GenericCardLayout key="online-galleries" customTopMargin={0}>
                        <Stack direction="column" spacing={4}>
                            <Typography key="online-galleries-title" variant="h5" component="h2" gutterBottom sx={{ fontWeight: 600 }}>
                                Online Galleries:
                            </Typography>
                            {onlineGalleryData.map((item) => {
                                return (
                                    <Box key={"online-gallery-" + item.content.id} width='100%'>
                                        {renderUser(item.creator, item.content.creationDate)}
                                        <EventPreview content={item.content} />
                                    </Box>
                                );
                            })}
                        </Stack>
                    </GenericCardLayout>
                }
                {physicalExhibitionData.length > 0 &&
                    <GenericCardLayout key="physical-exhibitions" customTopMargin={0}>
                        <Stack direction="column" spacing={4}>
                            <Typography key="physical-exhibitions-title" variant="h5" component="h2" gutterBottom sx={{ fontWeight: 600 }}>
                                Physical Exhibitions:
                            </Typography>
                            {physicalExhibitionData.map((item) => {
                                return (
                                    <Box key={"physical-exhibition-" + item.content.id} width='100%'>
                                        {renderUser(item.creator, item.content.creationDate)}
                                        <EventPreview content={item.content} />
                                    </Box>
                                );
                            })}
                        </Stack>
                    </GenericCardLayout>
                }
                {artItemData.length > 0 &&
                    <GenericCardLayout key="art-items" customTopMargin={0}>
                        <Stack direction="column" spacing={4}>
                            <Typography key="art-items-title" variant="h5" component="h2" gutterBottom sx={{ fontWeight: 600 }}>
                                Art Items:
                            </Typography>
                            {artItemData.map((item) => {
                                return (
                                    <Box key={"art-item-" + item.content.id} width='100%'>
                                        {renderUser(item.creator, item.content.creationDate)}
                                        <ArtItemPreview content={item.content} />
                                    </Box>
                                );
                            })}
                        </Stack>
                    </GenericCardLayout>
                }
                {discussionPostData.length > 0 &&
                    <GenericCardLayout key="discussion-posts" customTopMargin={0}>
                        <Stack direction="column" spacing={4}>
                            <Typography key="discussion-posts-title" variant="h5" component="h2" gutterBottom sx={{ fontWeight: 600 }}>
                                Discussion Posts:
                            </Typography>
                            {discussionPostData.map((item) => {
                                return (
                                    <Box key={"discussion-post-" + item.content.id} width='100%'>
                                        {renderUser(item.creator, item.content.creationDate)}
                                        <DiscussionPostPreview content={item.content} />
                                    </Box>
                                );
                            })}
                        </Stack>
                    </GenericCardLayout>
                }
            </Stack>
        </>
    )
}