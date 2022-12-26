import * as React from 'react';
import { Typography, CircularProgress, Button } from '@mui/material';
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


    React.useEffect(() => {
        setLikeStatus(props.content.liked);
    }, [props.content.liked]);

    React.useEffect(() => {
        setLikeCount(props.content.likeCount);
    }, [props.content.likeCount]);


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
                    if (likeStatus) {
                        setLikeCount(likeCount - 1);
                    } else {
                        setLikeCount(likeCount + 1);
                    }
                    setLikeStatus(!likeStatus);
                } else {
                    props.onResponse("error", "Error liking art item");
                }
            })
            .catch(error => props.onResponse("error", error));
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

            <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center" sx={{ mt: 2, width: '100%', color: 'grey' }}>
                <Button color={likeStatus ? 'secondary' : 'inherit'} disabled={token ? false : true} onClick={handleLike} sx={{fontWeight: 600}} startIcon={likeStatus ? <ThumbUpAltIcon /> : <ThumbUpOffAltIcon />}>{likeStatus ? "liked | " + likeCount : "like | " + likeCount}</Button>
                <Typography variant="body1" sx={{ fontSize: 14, fontWeight: 600, color: 'gray'}}>{props.content.commentCount + ' comments'}</Typography>
            </Stack>
        </Stack>
    );

}