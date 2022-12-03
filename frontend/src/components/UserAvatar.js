
import React from 'react';
import { Avatar } from "@mui/material";

export default function UserAvatar({ id, sx}) {

    const [image, setImage] = React.useState(null);

    React.useEffect(() => {
        fetch('/api/image/' + id, { method: "GET" })
            .then((response) => response.json())
            .then((json) => setImage(json.base64String))
            .catch((error) => console.log(error))
    }, [id])

    return (
        <Avatar alt="User" src={image} sx={{...sx}} />
    )
}

UserAvatar.defaultProps = {
    id: 0,
    sx: {}
}