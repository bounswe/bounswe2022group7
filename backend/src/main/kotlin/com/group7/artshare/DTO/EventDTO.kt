package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.EventInfo
import lombok.Data
import java.util.*

@Data
open class EventDTO {
    var id : Long? = null
    var type: String? = null
    var creatorId: Long? = null
    var creatorAccountInfo: AccountInfo? = null
    var creationDate : Date? = null
    var commentList: MutableList<CommentDTO> = mutableListOf()
    var eventInfo: EventInfo? = null
    var participantUsernames : MutableList<String> = mutableListOf()
}