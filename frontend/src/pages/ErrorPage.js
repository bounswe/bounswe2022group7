import React from 'react'
import { Link } from 'react-router-dom';

export default function ErrorPage(props) {

  return (
    <div style={{textAlign:"center"}}>
      <h1>Oops!</h1>
      
      <p>
        {props.message || "Sorry, an unexpected error has occured."}</p>
      <p>      
        {
        props.hyperlink ?
          <Link to={props.hyperlink.to}>{props.hyperlink.text}</Link>
        :
          <Link to="/">Go to Home</Link>  
        }
      </p>
    </div>
  );
}