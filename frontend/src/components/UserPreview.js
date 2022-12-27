import * as React from 'react';
import { Link } from 'react-router-dom';
import Stack from '@mui/material/Stack';
import Typography from '@mui/material/Typography';
import { useAuth } from '../auth/useAuth';
import UserAvatar from "./UserAvatar";
import LoadingButton from "./LoadingButton";

export default function UserPreview({ user, ...props }) {

    const [followStatus, setFollowStatus] = React.useState(false);

    const { token } = useAuth();

    React.useEffect(() => {
        setFollowStatus(user.followed);
    }, [user.followed])


    function followRequest() {
        fetch('/api/follow/' + user.username,
            {
                method: "POST", headers: {
                    'Authorization': 'Bearer ' + token,
                }
            })
            .then(response => {
                if (response.status === 202) {
                    if (props.followAction) props.followAction();
                    setFollowStatus(!followStatus)
                } else {
                    console.log("error")
                }
            })
            .catch(error => console.log(error));
    }

    return (
        <Stack spacing={2} direction="row" justifyContent="left" alignItems="center">

            <Link key={"link1-" + user.username} to={"/profile/" + user.username} style={{ textDecoration: 'none', color: "black" }}>
                <UserAvatar username={user.username} id={user.imageId} sx={{ h: 32, w: 32, border: 1, borderColor: 'divider' }} />
            </Link>
            <Link key={"link2-" + user.username} to={"/profile/" + user.username} style={{ textDecoration: 'none', color: "black" }}>
                <Typography variant="h6" component="h2" sx={{ fontSize: 17, fontWeight: 700 }}>
                    {user.username}
                </Typography>
            </Link>
            {(token && !props.followDisable) && <LoadingButton key={"button-" + user.username} disabled={followStatus} dataTestId="followButton" onClick={() => followRequest()} loading={false} label={followStatus ? "following" : "follow"} loadingText="Saving" variant="text" color="primary" size="small" sx={{ fontSize: 12, fontWeight: 600, borderRadius: '10%' }} />}
        </Stack>
    );
}