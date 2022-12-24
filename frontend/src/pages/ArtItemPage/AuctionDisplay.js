import React from "react";
import UserCard from '../../common/UserCard'
import LoadingButton from "../../components/LoadingButton"
import { Typography, Grid, useTheme, Paper } from '@mui/material';
import TextField from '@mui/material/TextField';
import { useAuth } from "../../auth/useAuth";

function BidForm(props) {

  const {art_item_id} = props
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
  const {art_item_id, user_can_bid, max_bid, on_auction} = props

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
        <Grid item xs={12} sm={6}>
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
        <Grid item xs={12} sm={6}>
          {(on_auction && user_can_bid)
          ?
            <BidForm art_item_id = {art_item_id}/>
          :
          (!on_auction ? <div>Not on auction.</div>:<div>You can not bid in your own auction.</div>)
          }
        </Grid>
      </Grid>
    </Paper>
  );
  
}

export default AuctionDisplay
