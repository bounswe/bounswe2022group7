import * as React from 'react';
import Box from '@mui/material/Box';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';

import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';

import { useAuth } from '../auth/useAuth';

import { Link } from 'react-router-dom';
import { IconButton } from '@mui/material';
import ThumbUpAlt from '@mui/icons-material/ThumbUpAlt';
import ThumbUpOffAlt from '@mui/icons-material/ThumbUpOffAlt';
import ThumbDownAltIcon from '@mui/icons-material/ThumbDownAlt';
import ThumbDownOffAltIcon from '@mui/icons-material/ThumbDownOffAlt';


export default function DiscussionPostPreview(props) {

    const [likeStatus, setLikeStatus] = React.useState(0);
    const [likeCount, setLikeCount] = React.useState(props.content.likeCount || 0);


    // React.useEffect(() => {
    //     setParticipantStatus(props.content.participated);
    // }, [props.content.participated])

    const { token } = useAuth();

    function handleUpvote() {
        setLikeStatus(1);
        // console.log(participantCount);
        // fetch('/api/event/participate/' + props.content.id,
        //     {
        //         method: "POST", headers: {
        //             Authorization: 'Bearer ' + token,
        //         }
        //     })
        //     .then(response => {
        //         if (response.ok) {
        //             setParticipantCount(participantStatus ? participantCount - 1 : participantCount + 1);
        //             setParticipantStatus(!participantStatus);
        //         }
        //     })
        //     .catch(error => console.log(error));
    }

    function handleDownvote() {
        setLikeStatus(-1);
    }

    return (
        <Stack sx={{ width: '100%' }}>
            <Link to={"/discussionPost/" + props.content.id} style={{ width: '100%', textDecoration: 'none', color: "black" }}>
                <Box position="relative" width='100%'>
                    <Stack spacing={2} direction="column" justifyContent="center" alignItems="flex-start" sx={{ display: 'relative', width: '90%' }} >
                        <Typography variant="title" sx={{ fontWeight: 700, fontSize: 18 }}>
                            {props.content.title}
                        </Typography>
                        <Typography variant="body1" gutterBottom sx={{ fontSize: 16 }}>
                            {props.content.description}
                        </Typography>
                    </Stack>
                    <ArrowForwardIosIcon sx={{ color: 'gray', position: 'absolute', top: '50%', right: 0, transform: 'translate(0, -50%)' }} />
                </Box>
            </Link>

            <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center" sx={{ mt: 2, width: '100%' }}>
                <Box>
                    <IconButton onClick={handleUpvote} sx={{ display: 'inline'}} variant="outlined">
                        {likeStatus === 1 ? <ThumbUpAlt color='primary' /> : <ThumbUpOffAlt />}
                    </IconButton>
                    <Typography variant="body1" sx={{ display: 'inline', fontWeight: 600, color: 'gray', fontSize: 14}}> {likeCount}</Typography>
                    <IconButton onClick={handleDownvote} sx={{ display: 'inline', color: likeStatus === 1 ? 'primary' : 'grey'}} variant="outlined">
                        {likeStatus === -1 ? <ThumbDownAltIcon size="small" color='primary' /> : <ThumbDownOffAltIcon size="small" />}
                    </IconButton>
                </Box>
                <Typography variant="body1" sx={{ fontSize: 14, fontWeight: 600, color: 'gray' }}> {props.commentCount} comments</Typography>
            </Stack>
        </Stack>
    );

}