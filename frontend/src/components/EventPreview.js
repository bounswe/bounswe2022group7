import * as React from 'react';
import { Typography, CircularProgress, Button } from '@mui/material';
import { useAuth } from '../auth/useAuth';
import { Suspense } from 'react';
import Stack from '@mui/material/Stack';

import { Link } from 'react-router-dom';

const ImageDisplay = React.lazy(() => import('./ImageDisplay'));


export default function EventPreview(props) {

    const [participantStatus, setParticipantStatus] = React.useState("a");
    const [participantCount, setParticipantCount] = React.useState(props.content.participantCount || 0);

    const { token } = useAuth();



    React.useEffect(() => {
        setParticipantStatus(props.content.participated);
    }, [props.content.participated])


    function handleParticipate() {
        fetch('/api/event/participate/' + props.content.id,
            {
                method: "POST", headers: {
                    Authorization: 'Bearer ' + token,
                }
            })
            .then(response => {
                if (response.ok) {
                    setParticipantCount(participantStatus ? participantCount - 1 : participantCount + 1);
                    setParticipantStatus(!participantStatus);
                }
                else {
                    props.onResponse("error", "Error participating in event");
                }
            })
            .catch(error => props.onResponse("error", error));
    }



    return (
        <Stack sx={{ width: '100%' }}>
            <Link to={"/event/" + props.content.id} style={{ width: '100%', textDecoration: 'none', color: "black" }}>
                <Typography variant="title" gutterBottom sx={{ fontWeight: 700, fontSize: 18 }}>
                    {props.content.title}
                </Typography>
                <Typography variant="body1" gutterBottom sx={{ fontSize: 16 }}>
                    {props.content.description}
                </Typography>
                {props.content.imageId &&
                    <Suspense fallback={<div><CircularProgress /></div>}>
                        <ImageDisplay data-testid="imageDisplay" imageId={props.content.imageId} />
                    </Suspense>
                }
            </Link>

            <Stack spacing={2} direction="row" justifyContent="space-between" alignItems="center" sx={{ mt: 2, width: '100%', color: 'grey' }}>
                <Typography variant="body1" sx={{ fontSize: 14, fontWeight: 600, color: 'gray' }}>{participantCount + " people participating"}</Typography>
                {token && <Button color={participantStatus ? 'secondary' : 'inherit'} onClick={handleParticipate} sx={{ fontWeight: 600 }} variant="outlined">
                    {participantStatus ? "Participating" : "Participate"}
                </Button>}
            </Stack>
        </Stack>
    );

}