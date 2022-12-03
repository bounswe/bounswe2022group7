package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import lombok.Data
import java.util.Date

@Data
class DiscussionPostDTO{
    var id : Long? = null
    var title : String? = null
    var textBody : String? = null
    var creatorAccountInfo : AccountInfo? = null
    var creatorId : Long? = null
    var creationDate : Date? = null
    var lastEditDate : Date? = null
    var upVotedUsernames : MutableSet<String> = mutableSetOf()
    var downVotedUsernames : MutableSet<String> = mutableSetOf()
    var commentList: MutableList<CommentDTO> = mutableListOf()
}
