import React from "react";
import UserCard from '../../common/UserCard'
import LoadingButton from "../../components/LoadingButton"
import { Typography, Grid, useTheme, Paper } from '@mui/material';
import TextField from '@mui/material/TextField';
import { useAuth } from "../../auth/useAuth";
import IconWithText from "../../components/IconWithText"
import SellIcon from '@mui/icons-material/Sell';

function BidForm(props) {

  const { art_item_id } = props
  const { token } = useAuth()
  
  const [bidState, setBidState] = React.useState(0)
  const handleInput = event => {
    const name = event.target.name;
    const newValue = event.target.value;
    setBidState({ [name]: newValue });
  };

  return (
    <div>
      <TextField
        required
        type="number"
        id="outlined-required"
        label="Bid Amount"
        name="bidAmount"
        defaultValue={bidState}
        onChange={handleInput}
      />
      <LoadingButton
        type = "submit"
        label = "Make Bid"
        onClick = {() => {
          fetch("/api/art_item/bid/" + art_item_id, {
            method: "POST",
            body: JSON.stringify(bidState),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer " + token
            }
          })
          .then(response => window.location.reload())
        }}
      />
    </div>
  )
}

function AuctionDisplay(props) {
  const {art_item_id, max_bid, on_auction, user_id, owner_id } = props
  const { token } = useAuth()

  /*
  States: 
  
  2. Not onAuction, yes max_bid
  3. onAuction, no max_bid
  4. onAuction, yes max_bid
  */
  
  // 1. Not onAuction, no max_bid
  if (!on_auction && !max_bid) {return;}
  // 2. Not onAuction, there is a max_bid
  return (
    <Paper style={{ padding: "10px 20px", marginTop: 10 }}>
      <Grid container>
        <IconWithText
          icon = {<SellIcon/>}
          text = "Auction Status"
          variant = "h5"
        />
        <Grid item xs={12} sm={4}>
          {on_auction
          ?
          <div>On Auction!</div>
          :
          (
            max_bid
            ?
            <div>Item was sold after an auction. Auction is closed.</div>
            :
            <div>Not on auction.</div>
          )
          }
        </Grid>
        <Grid item xs={12} sm={4}>
          {max_bid
          ?
          <div>
            Max Bid: {max_bid.bidAmount}
            <UserCard data = {max_bid.bidderAccountInfo} />
          </div>  
          :
          <div>
            Be first to bid!  
          </div>  
          }
          
        </Grid>
        <Grid item xs={12} sm={4}>
          {user_id == owner_id
          ? // user is the owner. Show end/start auction buttons
            (on_auction
            ?
              <LoadingButton
                type = "submit"
                label = "End the Auction"
                onClick = {() => {
                  fetch("/api/art_item/auction/" + art_item_id, {
                    method: "POST",
                    headers: {"Authorization": "Bearer " + token}
                  })
                  .then(response => window.location.reload())
                }}
              />
            :
              <LoadingButton
                type = "submit"
                label = "Start Auction!"
                onClick = {() => {
                  fetch("/api/art_item/auction/" + art_item_id, {
                    method: "POST",
                    headers: {"Authorization": "Bearer " + token}
                  })
                  .then(response => window.location.reload())
                }}
              />
            )
          : // user is not the owner. Show bid button if on_auction&&user_id
            (on_auction && user_id && <BidForm art_item_id = {art_item_id}/>)
          }
        </Grid>
      </Grid>
    </Paper>
  );
  
}

export default AuctionDisplay
