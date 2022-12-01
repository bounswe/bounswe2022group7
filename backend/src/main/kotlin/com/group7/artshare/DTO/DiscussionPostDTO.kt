package com.group7.artshare.DTO

import lombok.Data
import java.util.Date

@Data
class DiscussionPostDTO{
    var id : Long? = null
    var title : String? = null
    var textBody : String? = null
    var posterId : Long? = null
    var creationDate : Date? = null
    var lastEditDate : Date? = null
    var upVotedUserIds : MutableSet<Long> = mutableSetOf()
    var downVotedUserIds : MutableSet<Long> = mutableSetOf()
    var commentList: MutableList<CommentDTO> = mutableListOf()
}
