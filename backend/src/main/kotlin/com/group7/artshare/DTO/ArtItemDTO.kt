package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Auction
import lombok.Data
import java.util.*

@Data
class ArtItemDTO {
    var name : String? = null
    var description : String? = null
    var category : String? = null
    var imageUrl : String? = null
    var labels : MutableList<String> = mutableListOf()
    var creatorAccountInfo : AccountInfo? = null
    var creatorId : Long? = null
    var creationDate : Date? = null
    var ownerAccountInfo : AccountInfo? = null
    var ownerId : Long? = null
    var onAuction : Boolean? = null
    var auction : Auction? = null
    var lastPrice : Double? = null
    var commentList: MutableList<CommentDTO> = mutableListOf()
    var bookMarkedByIds : MutableList<Long> = mutableListOf()

}