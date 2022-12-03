
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import ShareIcon from '@mui/icons-material/Share';
import WarningIcon from '@mui/icons-material/Warning';
import BookmarkBorderOutlinedIcon from '@mui/icons-material/BookmarkBorderOutlined';

import { Link } from 'react-router-dom';

import ImageDisplay from './ImageDisplay';
import UserAvatar from "./UserAvatar";
import CustomizableDropdownMenu from "./CustomizableDropdownMenu";
import LoadingButton from "./LoadingButton";
import { IconButton } from '@mui/material';


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


    function followRequest() {
        fetch('/api/follow/' + props.creator.username, { method: "POST" })
            .then((response) => response.json())
            .then((json) => console.log(json))
            .catch((error) => console.log(error))

    }

    return (
        <Box hidden={!props.filtered} fullWidth sx={{ p: 2, mb: 2 }}>
            <Grid container spacing={2}>

                <Grid item xs={12}>
                    <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center">
                        <Stack spacing={2} direction="row" justifyContent="left" alignItems="center">

                            <Link to={"/profile/" + props.creator.username} style={{ textDecoration: 'none', color: "black" }}>
                                <UserAvatar id={props.creator.imageId} sx={{ h: 32, w: 32, border: 1, borderColor: 'divider' }} />
                            </Link>
                            <Link to={"/profile/" + props.creator.username} style={{ textDecoration: 'none', color: "black" }}>
                                <Typography variant="h6" component="h2" sx={{ fontSize: 17, fontWeight: 700 }}>
                                    {props.creator.username}
                                </Typography>
                            </Link>
                            <LoadingButton hidden={props.creator.followed} onClick={() => followRequest()} loading={false} label="Follow" loadingText="Saving" variant="text" color="primary" size="small" sx={{ fontSize: 12, fontWeight: 600, borderRadius: '10%' }} />
                        </Stack>
                        <Stack spacing={2} direction="row" justifyContent="end" alignItems="center">
                            <IconButton> <BookmarkBorderOutlinedIcon color="secondary" /></IconButton>
                            <CustomizableDropdownMenu color="secondary" tooltip="More Actions" menuContent={menuContent} />
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
                                        <ImageDisplay imageId={props.content.imageId} />
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
    creator: {
        username: "undefined",
        id: 0,
        imageId: 0,
        followed: false,
    },

    content: {
        type: "artitem",
        title: "Untitled",
        description: "Lorem Impsum",
        imageId: 0,
        creationDate: "2021-09-01T00:00:00.000Z",
    },
}