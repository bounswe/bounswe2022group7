import React, {useEffect, useState} from 'react'
import {useParams} from "react-router-dom";
import { useAuth } from "../../auth/useAuth"

import { Typography, Grid, useTheme, Divider } from '@mui/material';
import CommentSection from "../../common/CommentSection"
import UserCard from "../../common/UserCard"
import ImageDisplay from "../../components/ImageDisplay"
import IconWithText from "../../components/IconWithText"
import AnnotatableText from "../../components/AnnotatableText"
import GenericCardLayout from "../../layouts/GenericCardLayout";
import MapComponent from "../../components/MapComponent"
import ImageCollection from "./ImageCollection"
import {EventParticipate} from '../../components/EventPreview';
import LoadingButton from "../../components/LoadingButton"

import PersonIcon from '@mui/icons-material/Person';
import DateRangeIcon from '@mui/icons-material/DateRange';
import LabelIcon from '@mui/icons-material/Label';
import CategoryIcon from '@mui/icons-material/Category';
import RuleIcon from '@mui/icons-material/Rule';
import GroupsIcon from '@mui/icons-material/Groups';

function EventPage() {
  
  let { id } = useParams();

  const [state, setState] = useState({
    error: null,
    isLoaded: false,
    event: [] 
  })

  const theme = useTheme();
  const { token, userData } = useAuth()
  
  useEffect(() => {

    const fetchArgs = {
      method: "GET",  
    }

    if (token) fetchArgs.headers = {Authorization: "Bearer " + token}
    fetch('/api/event/' + id, fetchArgs)
      .then((response) => response.json())
      .then((data) => {
        setState({error: null, isLoaded: true, event: data})
      },
        error => {
          setState({error: error})
        }
      )
  }, [id, token])

  const {error, isLoaded, event} = state

  const eventParticipateStatus = (id) => {
    if (userData === null) {
        return false;
    }
    return userData.participatedEventIds.includes(id);
  };

  if (error) {
    return <div>Error: {error.message}</div>
  } else if (!isLoaded) {
    return <div>Loading...</div>
  } else {
    let eventStartTime = new Date(event.eventInfo.startingDate)
    eventStartTime = eventStartTime.toLocaleString()

    let eventEndTime = new Date(event.eventInfo.endingDate)
    eventEndTime = eventEndTime.toLocaleString()

  return (
    <GenericCardLayout maxWidth={1000}>
      <Typography
        variant="h5"
        color={theme.palette.primary.main}
      >
        {event.type == "online" ? "Online Event:": "Physical Event:"}
      </Typography>
      <Typography variant="h4">
        {event.eventInfo.title}
      </Typography>
    
      <ImageDisplay imageId={event.eventInfo.posterId}/>   
      <EventParticipate content={{
        participated: eventParticipateStatus(event.id),
        participantCount: event?.participantUsernames?.length,
        id: event.id
      }}/>       

      <Grid container spacing={2}>
        <Grid item xs={12} sm={8}>
          <IconWithText
            text="Description"
            variant="h5"
          />
          <AnnotatableText text={event.eventInfo.description}/>
        </ Grid>
        <Grid item xs={12} sm={4}>

          <IconWithText
            icon={<PersonIcon/>}
            text="Organizer"
            variant="h5"
          />
          <UserCard data={event.creatorAccountInfo}/>

          <IconWithText
            icon={<DateRangeIcon/>}
            text="Event Time"
            variant="h5"
          />
          <Typography variant="body1">Start: {eventStartTime}</Typography>
          <Typography variant="body1">End: {eventEndTime}</Typography>
          
          <IconWithText
            icon = {<LabelIcon/>}
            text="Labels:"
            variant="h5"
          />
          {event.eventInfo.labels.join(", ")}

          <IconWithText
            icon = {<CategoryIcon/>}
            text="Categories:"
            variant="h5"
          />
          {event.eventInfo.category.join(", ")}

          {event.rules && // render rules if there are any
          <>
            <IconWithText
              icon = {<RuleIcon/>}
              text="Rules:"
              variant="h5"
            />
            {event.rules}
          </>
          }

          <IconWithText
            icon = {<GroupsIcon/>}
            text="All collaborators:"
            variant="h6"
          />
          {event.collaboratorAccountInfos.map((info) => <UserCard data={info}/>)}
        </ Grid>

        
      </ Grid>  

      <Divider variant="fullWidth" style={{ margin: "30px 0" }} />

      { event.location && // render locaiton iff there is one. (physical event)

      <>
        <IconWithText
          text="Address"
          variant="h5"
        />
        
        <br/>

        <Grid container spacing={2}>
          <Grid item xs={12} sm={8}>
            <MapComponent
              position={{
                lat:event?.location?.latitude, 
                lng:event?.location?.longitude
              }}
              eventTitle={event.eventInfo.title}
            />
          </Grid>

          <Grid item xs={12} sm={4}>
            <Typography variant="body1">{event.location.address}</Typography>
          </Grid>        
        </Grid>
      </>
      }

      { event.artItemList && // render images iff there are any (online event)
      <>
        
        <ImageCollection artItemList={event.artItemList}/>
        <br/>
      </>
      }
      <CommentSection
        contentId={id}
        commentList={event.commentList}
      />

      {event.creatorId == userData?.id &&
        <div>
          <br/>
          As the owner user:
          <br/>
          <LoadingButton
            label="Delete Event"
            onClick={() => {
              fetch("/api/event/" + event.id, {
                method: "DELETE",
                headers: {Authorization: "Bearer " + token}
              }).then((response) => {window.location.href = "/"})
            }}
            type="submit"
            variant="contained"
            color="primary"
          />
        </div>
      }
    </GenericCardLayout>
    
  )}
}


export default EventPage