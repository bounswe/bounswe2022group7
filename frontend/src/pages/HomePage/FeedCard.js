import React from 'react';

import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import IconButton from '@mui/material/IconButton';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';

import BookmarkIcon from '@mui/icons-material/Bookmark';
import BookmarkBorderOutlinedIcon from '@mui/icons-material/BookmarkBorderOutlined';
import ShareIcon from '@mui/icons-material/Share';
import WarningIcon from '@mui/icons-material/Warning';

import { useAuth } from '../../auth/useAuth';
import { Link } from 'react-router-dom';

import UserAvatar from "../../components/UserAvatar";
import CustomizableDropdownMenu from "../../components/CustomizableDropdownMenu";
import LoadingButton from "../../components/LoadingButton";
import {ArtItemPreview} from '../../components/ArtItemPreview';
import {EventPreview} from '../../components/EventPreview';
import {DiscussionPostPreview} from '../../components/DiscussionPostPreview';

// TODO: Implement menu items
let menuContent = [
    {
        label: "Share",
        icon: <ShareIcon />,
        action: () => { console.log("Share") }
    },
    {
        label: "Report",
        icon: <WarningIcon />,
        action: () => { console.log("Report") }
    }
]


export default function FeedCard(props) {

    let parsedDate = new Date(props.content.creationDate);
    let date = parsedDate.toLocaleString();

    const { token } = useAuth();

    const [followStatus, setFollowStatus] = React.useState(false);
    const [bookmarked, setBookmarked] = React.useState(false);

    React.useEffect(() => {
        setFollowStatus(props.creator.followed);
    }, [props.creator.followed])

    React.useEffect(() => {
        setBookmarked(props.content.bookmarked);
    }, [props.content.bookmarked])


    function followRequest() {
        fetch('/api/follow/' + props.creator.username,
            {
                method: "POST", headers: {
                    'Authorization': 'Bearer ' + token,
                }
            })
            .then(response => {
                if (response.status === 202) {
                    props.followAction();
                    setFollowStatus(!followStatus)
                } else {
                    props.onResponse("error", "Couldn't complete follow request");
                }
            })
            .catch(error => props.onResponse("error", error));
    }

    function handleBookmark() {
        var endpoint = "";

        if (props.content.type === "artitem") {
            endpoint = "art_item";
        } else if (props.content.type === "event") {
            endpoint = "event";
        }
        else {
            return;
        }


        fetch('/api/' + endpoint + '/bookmark/' + props.content.id,
            {
                method: "POST", headers: {
                    'Authorization': 'Bearer ' + token,
                }
            })
            .then(response => {
                if (response.ok) {
                    setBookmarked(!bookmarked);
                } else {
                    props.onResponse("error", "Couldn't complete bookmark request");
                }
            })
            .catch(error => props.onResponse("error", error));
    }

    return (
        <Box hidden={!props.filtered} sx={{ p: 2, mb: 2 }}>
            <Grid container spacing={2}>

                <Grid item xs={12}>
                    <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center">
                        <Stack spacing={2} direction="row" justifyContent="left" alignItems="center">

                            <Link to={"/profile/" + props.creator.username} style={{ textDecoration: 'none', color: "black" }}>
                                <UserAvatar username={props.creator.username} id={props.creator.imageId} sx={{ h: 32, w: 32, border: 1, borderColor: 'divider' }} />
                            </Link>
                            <Link to={"/profile/" + props.creator.username} style={{ textDecoration: 'none', color: "black" }}>
                                <Typography variant="h6" component="h2" sx={{ fontSize: 17, fontWeight: 700 }}>
                                    {props.creator.username}
                                </Typography>
                            </Link>
                            {token && <LoadingButton disabled={followStatus} dataTestId="followButton" onClick={() => followRequest()} loading={false} label={followStatus ? "following" : "follow"} loadingText="Saving" variant="text" color="primary" size="small" sx={{ fontSize: 12, fontWeight: 600, borderRadius: '10%' }} />}
                        </Stack>
                        <Stack spacing={2} direction="row" justifyContent="end" alignItems="center">
                            {(token) && <IconButton data-testid="bookmarkButton" onClick={handleBookmark} color="secondary"> {bookmarked ? <BookmarkIcon data-testid="bookmarked" /> : <BookmarkBorderOutlinedIcon data-testid="notBookmarked" />}</IconButton>}
                            <CustomizableDropdownMenu data-testid="menuButton" color="secondary" tooltip="More Actions" menuContent={menuContent} />
                        </Stack>
                    </Stack>

                </Grid>
                <Grid item xs={12}>
                    <Stack spacing={2} direction="column" justifyContent="center" alignItems="flex-start" sx={{}}>
                        <Typography variant="body1" gutterBottom sx={{ fontSize: 14 }}>
                            Posted a new <strong>{props.content.type === "artitem" ? "art item" : (props.content.type === "event" ? "event" : "discussion")} </strong> on {date}.
                        </Typography>

                        <Box sx={{ p: 2, width: "100%", border: 1, borderColor: "divider" }}>
                            <Stack spacing={2} direction="column" justifyContent="center" alignItems="flex-start">
                                {props.content.type === "artitem" ?
                                    <ArtItemPreview onResponse={(severity, message) => props.onResponse(severity, message)} content={props.content} /> :
                                    props.content.type === "event" ?
                                        <EventPreview onResponse={(severity, message) => props.onResponse(severity, message)} content={props.content} />
                                        :
                                        <DiscussionPostPreview onResponse={(severity, message) => props.onResponse(severity, message)} content={props.content} />
                                }
                            </Stack>
                        </Box>
                    </Stack>
                </Grid>
            </Grid>

        </Box>
    );
}

FeedCard.defaultProps = {
    filtered: true,
    creator: {
        username: "undefined",
        id: 0,
        imageId: 0,
        followed: false,
    },

    content: {
        bookmarked: false,
        id: 0,
        type: "artitem",
        title: "Untitled",
        description: "Lorem Impsum",
        imageId: 0,
        creationDate: "2021-09-01T00:00:00.000Z",
    },
}