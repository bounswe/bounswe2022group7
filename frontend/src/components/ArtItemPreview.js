import * as React from 'react';
import { Box, Typography, CircularProgress, Button } from '@mui/material';
import { useAuth } from '../auth/useAuth';
import { Suspense } from 'react';
import Stack from '@mui/material/Stack';

import { Link } from 'react-router-dom';

import ThumbUpOffAltIcon from '@mui/icons-material/ThumbUpOffAlt';
import ThumbUpAltIcon from '@mui/icons-material/ThumbUpAlt';

const ImageDisplay = React.lazy(() => import('./ImageDisplay'));


export default function ArtItemPreview(props) {

    const [likeStatus, setLikeStatus] = React.useState(false);
    const [likeCount, setLikeCount] = React.useState(props.content.likeCount || 0);
    const [commentCount, setCommentCount] = React.useState(props.content.commentCount || 0);


    // React.useEffect(() => {
    //     setLikeStatus(props.content.liked);
    // }, [props.content.liked]);

    // React.useEffect(() => {
    //     setLikeCount(props.content.likeCount);
    // }, [props.content.likeCount]);

    // React.useEffect(() => {
    //     setCommentCount(props.content.commentCount);
    // }, [props.content.commentCount]);

    const { token } = useAuth();

    function handleLike() {
        fetch('/api/art_item/like/' + props.content.id,
            {
                method: "POST", headers: {
                    Authorization: 'Bearer ' + token,
                }
            })
            .then(response => {
                if (response.ok) {
                    console.log(likeCount);
                    setLikeCount(likeCount + 1);
                    // setLikeStatus(!likeStatus);
                }
            })
            .catch(error => console.log(error));
    }

    return (
        <Stack sx={{ width: '100%' }}>
            <Link to={"/" + props.content.type + "/" + props.content.id} style={{ width: '100%', textDecoration: 'none', color: "black" }}>
                <Typography variant="title" gutterBottom sx={{ fontWeight: 700, fontSize: 18 }}>
                    {props.content.title}
                </Typography>
                <Typography variant="body1" gutterBottom sx={{ fontSize: 16 }}>
                    {props.content.description}
                </Typography>
                <Suspense fallback={<div><CircularProgress /></div>}>
                    <ImageDisplay data-testid="imageDisplay" imageId={props.content.imageId} />
                </Suspense>
            </Link>

            <Box ml={1} sx={{width: '100%', marginTop: 2, alignItems: 'center', justifyItems: 'center' }} position="relative">
                <Button onClick={handleLike} sx={{fontWeight: 600, color: likeStatus ? 'primary' : 'grey'}} startIcon={likeStatus ? <ThumbUpAltIcon /> : <ThumbUpOffAltIcon />}>Like | {likeCount}</Button>
                <Typography variant="body1" sx={{position: 'absolute', fontSize: 14, fontWeight: 600, color: 'gray', display: 'inline', right: 8}}> {commentCount} comments</Typography>
            </Box>
        </Stack>
    );

}