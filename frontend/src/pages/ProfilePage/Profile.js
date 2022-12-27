import { Grid, ListItem } from '@mui/material';
import { useParams } from "react-router-dom";
import {useEffect,useState} from "react";
import {useAuth} from "../../auth/useAuth";
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import FeedCard from "../HomePage/FeedCard";

const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 400,
    bgcolor: 'background.paper',
    border: '2px solid #eee',
    boxShadow: 24,
    p: 4,
};

function Profile() {
    let { username } = useParams();
    const [user, setUser] = useState(null);
    const [otherUser, setOtherUser] = useState(null);
    const [artItems, setArtItems] = useState(null);
    const [bookmarkedEvents, setBookmarkedEvents] = useState(null);
    const [bookmarkedArtItems, setBookmarkedArtItems] = useState(null);
    const [participatedEvents, setParticipatedEvents] = useState(null);
    const [level, setLevel] = useState(null);
    const [followingUsernames, setFollowingUsernames] = useState([]);
    const { token } = useAuth()
    const [open, setOpen] = useState(false);
    const handleOpen = () => setOpen(true);
    const handleClose = () => setOpen(false);


    useEffect(() => {
        fetch(`/api/profile/${username}`, {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${token}`
            }
        })
            .then((response) => response.json())
            .then((data) => {
                    //TODO setLoading(false)

                    setUser(data.accountInfo)
                    setLevel(data.level)
                    setOtherUser(data.following)

                    data.artItems.forEach((artItem) => {
                        fetch(`/api/art_item/${artItem.id}`, {
                            method: "GET",
                            headers: {
                                "Authorization": `Bearer ${token}`
                            }
                        }).then((response) => response.json())
                            .then((data) => {
                                // artItems ? setArtItems([...artItems, data]) : setArtItems([data])
                                setArtItems([data])
                            })
                    })
                    data.bookmarkedEventIds.forEach((bookmarkedEventId) => {
                        fetch(`/api/event/${bookmarkedEventId}`, {
                            method: "GET",
                            headers: {
                                "Authorization": `Bearer ${token}`
                            }
                        }).then((response) => response.json())
                            .then((data) => {
                                // bookmarkedEvents ? setBookmarkedEvents([...bookmarkedEvents, data]) : setBookmarkedEvents([data])
                                setBookmarkedEvents([data])
                            })
                    })

                    data.bookmarkedArtItemIds.forEach((bookmarkedArtItemId) => {
                        fetch(`/api/art_item/${bookmarkedArtItemId}`, {
                            method: "GET",
                            headers: {
                                "Authorization": `Bearer ${token}`
                            }
                        }).then((response) => response.json())
                            .then((data) => {
                                // bookmarkedArtItems ? setBookmarkedArtItems([...bookmarkedArtItems, data]) : setBookmarkedArtItems([data])
                                setBookmarkedArtItems([data])
                            })
                    })

                    data.participatedEventIds.forEach((participatedEventId) => {
                        fetch(`/api/event/${participatedEventId}`, {
                            method: "GET",
                            headers: {
                                "Authorization": `Bearer ${token}`
                            }
                        }).then((response) => response.json())
                            .then((data) => {
                                participatedEvents ? setParticipatedEvents([...participatedEvents, data]) : setParticipatedEvents([data])
                            })
                    })


                    setFollowingUsernames([data.followingUsernames])
                }
            )
            .catch((error) => {
                // Error
                //console.log(error);
            });
    },[])
    return (
        <Grid
            container
        >
            <Modal
                keepMounted
                open={open}
                onClose={handleClose}
                aria-labelledby="keep-mounted-modal-title"
                aria-describedby="keep-mounted-modal-description"
            >
                <Box sx={style}>
                    <Typography id="keep-mounted-modal-title" variant="h6" component="h2">
                        Following
                    </Typography>
                    <Typography id="keep-mounted-modal-description" sx={{ mt: 2 }}>
                        <ul>
                            {
                                followingUsernames[0]&&followingUsernames[0].map((user,index)=>{
                                    return <li key={index}>{user}</li>
                                })
                            }
                        </ul>
                    </Typography>
                </Box>
            </Modal>
            <Grid
                container
                item
                xs={12} md={4}
                direction='column'
                wrap='wrap'
                sx={{
                    // display: { xs: 'block', md: 'block' }
                }}>
                {
                    user && <Box sx={{ minWidth: 275 }}>
                        <Card variant="outlined">
                            <>
                                <CardContent>
                                    <Typography variant="h6" component="div">
                                        @{user.username}
                                    </Typography>
                                    <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
                                        {user.name}
                                    </Typography>
                                    <Typography sx={{ fontSize: 14 }} color="text.secondary" gutterBottom>
                                        user level: {level}
                                    </Typography>

                                    <Grid container
                                    >
                                        <Grid item xs={3}>
                                            <Typography variant="body2">
                                                {user.country}
                                            </Typography>
                                        </Grid>
                                        <Grid item xs={3}>
                                            <Typography color="text.secondary">
                                                {new Date(user.dateOfBirth).toISOString().slice(0, 10)}
                                            </Typography>
                                        </Grid>

                                    </Grid>
                                    <Button color="info" onClick={handleOpen}>Following</Button>

                                </CardContent>
                            </>
                        </Card>
                    </Box>
                }

            </Grid>

            <Grid
                container
                item
                xs={12} md={6}
                direction='column'
                wrap='wrap'
                sx={{
                    // display: { xs: 'block', md: 'block' }
                }}>

                {
                    artItems && artItems.map((artItem)=>{

                        return (<FeedCard key={artItem.id}  content={{
                            type: "artitem",
                            id: 40,
                            title: artItem.name,
                            description: artItem.description,
                            imageId: artItem.imageId,
                            creationDate: artItem.creationDate,
                        }}
                                          creator={
                                              {
                                                  id: user.id,
                                                  username: user.username,
                                                  followed: false,
                                                  imageId: user.profilePictureId,
                                              }
                                          } />)

                    })
                }


            </Grid>
            <Grid
                container
                item
                xs={12} md={6}
                direction='column'
                wrap='wrap'
                sx={{
                    // display: { xs: 'block', md: 'block' }
                }}>

                {
                    bookmarkedEvents && bookmarkedEvents.map((bookmarkedEvent)=>{

                        return (<FeedCard key={bookmarkedEvent.id}  content={{
                            type: "event",
                            id: 40,
                            title: bookmarkedEvent.eventInfo.title,
                            description: bookmarkedEvent.eventInfo.description,
                            imageId: bookmarkedEvent.eventInfo.posterId,
                            creationDate: bookmarkedEvent.eventInfo.startingDate,
                        }}
                                          creator={
                                              {
                                                  id: user.id,
                                                  username: user.username,
                                                  followed: false,
                                                  imageId: user.profilePictureId,
                                              }
                                          } />)

                    })
                }


            </Grid>

            <Grid
                container
                item
                xs={12} md={6}
                direction='column'
                wrap='wrap'
                sx={{
                    // display: { xs: 'block', md: 'block' }
                }}>

                {
                    bookmarkedArtItems && bookmarkedArtItems.map((bookmarkedArtItem)=>{

                        return (<FeedCard key={bookmarkedArtItem.id}  content={{
                            type: "artitem",
                            id: 40,
                            title: bookmarkedArtItem.name,
                            description: bookmarkedArtItem.description,
                            imageId: bookmarkedArtItem.imageId,
                            creationDate: bookmarkedArtItem.creationDate,
                        }}
                                          creator={
                                              {
                                                  id: user.id,
                                                  username: user.username,
                                                  followed: false,
                                                  imageId: user.profilePictureId,
                                              }
                                          } />)

                    })
                }


            </Grid>

            <Grid
                container
                item
                xs={12} md={6}
                direction='column'
                wrap='wrap'
                sx={{
                    // display: { xs: 'block', md: 'block' }
                }}>

                {
                    participatedEvents && participatedEvents.map((participatedEvent)=>{

                        return (<FeedCard key={participatedEvent.id}  content={{
                            type: "event",
                            id: 40,
                            title: participatedEvent.eventInfo.title,
                            description: participatedEvent.eventInfo.description,
                            imageId: participatedEvent.eventInfo.posterId,
                            creationDate: participatedEvent.eventInfo.startingDate,
                        }}
                                          creator={
                                              {
                                                  id: user.id,
                                                  username: user.username,
                                                  followed: false,
                                                  imageId: user.profilePictureId,
                                              }
                                          } />)

                    })
                }


            </Grid>


        </Grid>
    )
}

export default Profile