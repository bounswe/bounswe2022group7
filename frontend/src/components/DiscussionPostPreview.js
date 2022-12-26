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


function DiscussionPostVote(props) {

    const [likeStatus, setLikeStatus] = React.useState(props.content.voteStatus || 0);
    const [likeCount, setLikeCount] = React.useState(props.content.voteCount || 0);

    const { token, userData } = useAuth();

    React.useEffect(() => {
        setLikeStatus(props.content.voteStatus);
    }, [props.content.voteStatus]);

    React.useEffect(() => {
        setLikeCount(props.content.voteCount);
    }, [props.content.voteCount]);

    function handleUpvote() {
        fetch('/api/discussionPost/vote/',
            {
                method: "POST", headers: {
                    Authorization: 'Bearer ' + token,
                    "Content-Type": 'application/json',
                },
                body: JSON.stringify({
                    id: props.content.id,
                    vote: 1,
                })
            })
            .then(response => response.json())
            .then(data => {
                try {
                    if (data.upVotedUsernames.includes(userData.accountInfo.username)) {
                        setLikeStatus(1);
                        setLikeCount(likeCount + 1);
                    }
                    else {
                        setLikeStatus(0);
                        setLikeCount(likeCount - 1);
                    }
                } catch (e) {
                    props.onResponse("error", e);
                }
            })
            .catch(error => props.onResponse("error", error));
    }

    function handleDownvote() {
        fetch('/api/discussionPost/vote/',
            {
                method: "POST", headers: {
                    Authorization: 'Bearer ' + token,
                    "Content-Type": 'application/json',
                },
                body: JSON.stringify({
                    id: props.content.id,
                    vote: -1,
                })
            })
            .then(response => response.json())
            .then(data => {
                try {
                    if (data.downVotedUsernames.includes(userData.accountInfo.username)) {
                        setLikeStatus(-1);
                        setLikeCount(likeCount - 1);
                    }
                    else {
                        setLikeStatus(0);
                        setLikeCount(likeCount + 1);
                    }
                } catch (e) {
                    props.onResponse("error", e);
                }
            })
            .catch(error => props.onResponse("error", error));
    }

    return (
        <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center" sx={{ mt: 2, width: '100%' }}>
            {token && <Box>
                <IconButton onClick={handleUpvote} sx={{ display: 'inline' }} variant="outlined">
                    {likeStatus === 1 ? <ThumbUpAlt color='secondary' /> : <ThumbUpOffAlt />}
                </IconButton>
                <Typography variant="body1" sx={{ display: 'inline', fontWeight: 600, color: 'gray', fontSize: 14 }}>{likeCount}</Typography>
                <IconButton onClick={handleDownvote} sx={{ display: 'inline', color: likeStatus === 1 ? 'primary' : 'grey' }} variant="outlined">
                    {likeStatus === -1 ? <ThumbDownAltIcon size="small" color='secondary' /> : <ThumbDownOffAltIcon size="small" />}
                </IconButton>
            </Box>}
            <Typography variant="body1" sx={{ fontSize: 14, fontWeight: 600, color: 'gray' }}>{props.content.commentCount + " comments"}</Typography>
        </Stack>
    )
}

function DiscussionPostPreview(props) {    

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

            <DiscussionPostVote content={props.content}/>
        </Stack>
    );
}

export {DiscussionPostVote, DiscussionPostPreview}