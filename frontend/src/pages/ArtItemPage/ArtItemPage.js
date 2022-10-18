import React from 'react'
import {useParams} from "react-router-dom";

function ArtItemPage() {
    
    let { id } = useParams();

    return (
        <div>
            You are on the page of art item with id={id}
        </div>
    )
}


export default ArtItemPage