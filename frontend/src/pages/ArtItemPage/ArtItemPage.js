import React from 'react'
import {useParams} from "react-router-dom";

import CommentSection from "../../common/CommentSection"

function ArtItemPage() {
    
    let { id } = useParams();

    return (
        <div>
            You are on the page of art item with id={id}

            <CommentSection />
        </div>
    )
}


export default ArtItemPage