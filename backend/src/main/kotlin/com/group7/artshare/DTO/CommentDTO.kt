package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Report
import lombok.Data
import java.util.*

@Data
class CommentDTO {

    var id : Long? = null
    var text : String? = null
    var creationDate : Date? = null
    var lastEditDate : Date? = null
    var upVotedUsernames : MutableSet<String> = mutableSetOf()
    var downVotedUsernames : MutableSet<String> = mutableSetOf()
    var reports : MutableList<Report> = mutableListOf()
    var authorAccountInfo : AccountInfo? = null
    var authorId : Long? = null
}