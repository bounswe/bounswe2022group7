
import React from 'react';
import { Avatar } from "@mui/material";

export default function UserAvatar({username, id, sx}) {

    const [image, setImage] = React.useState(null);

    React.useEffect(() => {
        fetch('/api/image/' + id, { method: "GET" })
            .then((response) => response.json())
            .then((json) => setImage(json.base64String))
            .catch((error) => console.log(error))
    }, [id])

    return (
        <Avatar data-testid="userAvatar" alt={username} src={image} sx={{...sx}} />
    )
}

UserAvatar.defaultProps = {
    username: null,
    id: 0,
    sx: {}
}