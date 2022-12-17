package com.group7.artshare.DTO

import com.group7.artshare.entity.*
import lombok.Data
import java.util.*

@Data
open class EventDTO : Comparable<EventDTO> {
    var id : Long? = null
    var type: String? = null
    var creatorId: Long? = null
    var creatorAccountInfo: AccountInfo? = null
    var creationDate : Date? = null
    var commentList: MutableList<CommentDTO> = mutableListOf()
    var eventInfo: EventInfo? = null
    var participantUsernames : MutableList<String> = mutableListOf()

    override fun compareTo(other: EventDTO): Int {
        return other.participantUsernames.size - this.participantUsernames.size
    }

}