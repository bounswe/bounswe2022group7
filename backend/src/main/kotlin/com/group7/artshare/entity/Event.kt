package com.group7.artshare.entity

import lombok.Data
import java.util.*
import javax.persistence.*
import kotlin.collections.ArrayList
import java.util.Calendar

@Data
@Entity
@Table(name = "event")
class Event{

    @Id
    @GeneratedValue
    var eventId: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var creator: Artist? = null

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var collaborators: List<Artist> = ArrayList()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var participants: List<RegisteredUser> = ArrayList()

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var lastEdited: Date = Calendar.getInstance().time

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var commentList: List<Comment> = ArrayList()

    @OneToOne
    @JoinColumn(name = "eventInfoId", referencedColumnName = "id")
    var eventInfo: EventInfo? = null
}