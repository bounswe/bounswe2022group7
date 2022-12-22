package com.group7.artshare.DTO

import com.group7.artshare.entity.*
import lombok.Data
import java.util.*

@Data
class ArtItemDTO : Comparable<ArtItemDTO> {
    var id : Long? = null
    var name : String? = null
    var description : String? = null
    var category : MutableList<String>  = mutableListOf()
    var imageId : Long? = null
    var labels : MutableList<String> = mutableListOf()
    var creatorAccountInfo : AccountInfo? = null
    var creatorId : Long? = null
    var creationDate : Date? = null
    var ownerAccountInfo : AccountInfo? = null
    var ownerId : Long? = null
    var onAuction : Boolean? = null
    var bids : MutableList<Bid> = mutableListOf()
    var lastPrice : Double? = null
    var commentList: MutableList<CommentDTO> = mutableListOf()
    var bookmarkedByUsernames : MutableList<String> = mutableListOf()
    var likedByUsernames : MutableList<String> = mutableListOf()
    override fun compareTo(other: ArtItemDTO): Int {
        return other.likedByUsernames.size - this.likedByUsernames.size
    }

}