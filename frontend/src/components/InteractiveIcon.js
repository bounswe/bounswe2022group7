//
// An icon component which takes the following parameters:
// - state: int
// - stateToIconMap: a function mapping state to icon
// - onClick: a function that handles the click

import React from "react";

function InteractiveIcon(props) {
  const {state, stateToIconMap, onClick, text, clickDisabled} = props

  if (clickDisabled) {
    return <div>
      {stateToIconMap(state)}
      {text}
    </div>
  }

  return (
    <div onClick={onClick} style={{cursor: "pointer"}}>
      {stateToIconMap(state)}
      {text}
    </div>
  )
}

export default InteractiveIcon