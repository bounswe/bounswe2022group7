package com.group7.artshare.entity

import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class Report {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @Column
    var reportedObjectId : Int? = null //we should update it either ArtItem, DiscussionPost, or Comment

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var date: Date = Calendar.getInstance().time

    @Column
    var description : String = ""

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    var reporter : RegisteredUser? = null

}