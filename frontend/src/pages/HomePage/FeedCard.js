import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import ShareIcon from '@mui/icons-material/Share';
import WarningIcon from '@mui/icons-material/Warning';
import BookmarkIcon from '@mui/icons-material/Bookmark';
import BookmarkBorderOutlinedIcon from '@mui/icons-material/BookmarkBorderOutlined';
import Link from '@mui/material/Link';


import React, { lazy, Suspense } from 'react';

// import { Link } from 'react-router-dom';

import { useAuth } from '../../auth/useAuth';

import UserAvatar from "../../components/UserAvatar";
import CustomizableDropdownMenu from "../../components/CustomizableDropdownMenu";
import LoadingButton from "../../components/LoadingButton";
import { CircularProgress, IconButton } from '@mui/material';

const ImageDisplay = lazy(() => import('../../components/ImageDisplay'));

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

    const [followStatus, setFollowStatus] = React.useState(props.creator.followed);


    function followRequest() {
        fetch('/api/follow/' + props.creator.username,
            {
                method: "POST", headers: {
                    'Authorization': 'Bearer ' + token,
                }
            })
            .then(response => response.json())
            .then(data => {
                setFollowStatus(data.followed);            })
            .catch(error => {
                console.log(error);
            });
    }

    function setBookmarked() {
        // TODO: Implement bookmarking
    }

    return (
        <Box hidden={!props.filtered} sx={{ p: 2, mb: 2 }}>
            <Grid container spacing={2}>

                <Grid item xs={12}>
                    <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center">
                        <Stack spacing={2} direction="row" justifyContent="left" alignItems="center">

                            <Link href={"/profile/" + props.creator.username} style={{ textDecoration: 'none', color: "black" }}>
                                <UserAvatar username={props.creator.username} id={props.creator.imageId} sx={{ h: 32, w: 32, border: 1, borderColor: 'divider' }} />
                            </Link>
                            <Link href={"/profile/" + props.creator.username} style={{ textDecoration: 'none', color: "black" }}>
                                <Typography variant="h6" component="h2" sx={{ fontSize: 17, fontWeight: 700 }}>
                                    {props.creator.username}
                                </Typography>
                            </Link>
                            {(token && !followStatus) && <LoadingButton dataTestId="followButton" onClick={() => followRequest()} loading={false} label="Follow" loadingText="Saving" variant="text" color="primary" size="small" sx={{ fontSize: 12, fontWeight: 600, borderRadius: '10%' }} />}
                        </Stack>
                        <Stack spacing={2} direction="row" justifyContent="end" alignItems="center">
                            {(token) && <IconButton data-testid="bookmarkButton" onClick={setBookmarked} color="secondary"> {props.content.bookmarked ? <BookmarkIcon data-testid="bookmarked" />  : <BookmarkBorderOutlinedIcon data-testid="notBookmarked" />}</IconButton>}
                            <CustomizableDropdownMenu data-testid="menuButton" color="secondary" tooltip="More Actions" menuContent={menuContent} />
                        </Stack>
                    </Stack>

                </Grid>
                <Grid item xs={12}>
                    <Stack spacing={2} direction="column" justifyContent="center" alignItems="flex-start" sx={{}}>
                        <Typography variant="body1" gutterBottom sx={{ fontSize: 14 }}>
                            Posted a new <strong>{props.content.type === "artitem" ? "artwork" : (props.content.type === "event" ? "event" : "discussion")} </strong> on {date}.
                        </Typography>
                        <Link to={"/" + props.content.type + "/" + props.content.id} style={{ width: '100%', textDecoration: 'none', color: "black" }}>

                            <Box sx={{ p: 2, width: "100%", border: 1, borderColor: "divider" }}>
                                <Stack spacing={2} direction="column" justifyContent="center" alignItems="flex-start">
                                    {props.content.type !== "discussionPost" ? <>
                                        <Typography variant="title" gutterBottom sx={{ fontWeight: 700, fontSize: 18 }}>
                                            {props.content.title}
                                        </Typography>
                                        <Typography variant="body1" gutterBottom sx={{ fontSize: 16 }}>
                                            {props.content.description}
                                        </Typography>
                                        <Suspense fallback={<div><CircularProgress /></div>}>
                                            <ImageDisplay data-testid="imageDisplay" imageId={props.content.imageId} />
                                        </Suspense>
                                    </> :
                                        <Stack direction="row" justifyContent="space-between" alignItems="center">
                                            <Stack spacing={2} direction="column" justifyContent="center" alignItems="flex-start">
                                                <Typography variant="title" sx={{ fontWeight: 700, fontSize: 18 }}>
                                                    {props.content.title}
                                                </Typography>
                                                <Typography variant="body1" gutterBottom sx={{ fontSize: 16 }}>
                                                    {props.content.description}
                                                </Typography>
                                            </Stack>

                                            <ArrowForwardIosIcon sx={{ color: 'gray' }} />
                                        </Stack>
                                    }
                                </Stack>
                            </Box>
                        </Link>
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