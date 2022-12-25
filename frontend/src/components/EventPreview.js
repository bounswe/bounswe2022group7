import * as React from 'react';
import { Box, Typography, CircularProgress, Button } from '@mui/material';
import { useAuth } from '../auth/useAuth';
import { Suspense } from 'react';
import Stack from '@mui/material/Stack';

import { Link } from 'react-router-dom';

import ThumbUpOffAltIcon from '@mui/icons-material/ThumbUpOffAlt';
import ThumbUpAltIcon from '@mui/icons-material/ThumbUpAlt';

const ImageDisplay = React.lazy(() => import('./ImageDisplay'));


export default function EventPreview(props) {

    const [participantStatus, setParticipantStatus] = React.useState("a");
    const [participantCount, setParticipantCount] = React.useState(props.content.participantCount || 0);


    React.useEffect(() => {
        setParticipantStatus(props.content.participated);
    }, [props.content.participated])

    const { token } = useAuth();

    function handleParticipate() {
        console.log(participantCount);
        fetch('/api/event/participate/' + props.content.id,
            {
                method: "POST", headers: {
                    Authorization: 'Bearer ' + token,
                }
            })
            .then(response => {
                if (response.ok) {
                    console.log(response);
                    setParticipantCount(participantStatus ? participantCount - 1 : participantCount + 1);
                    setParticipantStatus(!participantStatus);
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

            <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center" sx={{ width: '100%' }}>
                <Typography variant="body1" sx={{ fontSize: 14, fontWeight: 600, color: 'gray' }}> {participantCount} people participating</Typography>
                <Button onClick={handleParticipate} sx={{ fontWeight: 600, color: participantStatus ? "grey" : 'primary' }} variant="outlined">
                    {participantStatus ? "Participating" : "Participate"}
                </Button>
            </Stack>
        </Stack>
    );

}