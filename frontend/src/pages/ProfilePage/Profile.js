import { UserInfo } from "./UserInfo";
import { Grid, Link } from '@mui/material';
import { useParams } from "react-router-dom";

function Profile() {
    let { username } = useParams();

    return (
        <Grid
            container
        >
            <Grid
                container
                item
                xs={12} md={4}
                direction='column'
                wrap='wrap'
                sx={{
                    display: { xs: 'none', md: 'block' }
                }}>
                <Grid
                    item
                    sx={{
                        height: '100%'
                    }}>
                    <UserInfo username={username} />
                </Grid>
            </Grid>
            <Grid container item xs={12} md={4} direction='column' wrap='wrap'>
                <p>User Events</p>
            </Grid>
            <Grid container item xs={12} md={4} direction='column' wrap='wrap'>
                <p>User Art Items</p>
            </Grid>

        </Grid>
    )
}

export default Profile