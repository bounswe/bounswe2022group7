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
    val eventId: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    val creator: Artist = null

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    val collaborators: List<Artist> = ArrayList()

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    val participants: List<RegisteredUser> = ArrayList()

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    val lastEdited: Date = Calendar.getInstance().time

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER, cascade = [CascadeType.ALL])
    val commentList: List<Comment> = ArrayList()

    @OneToOne
    @JoinColumn(name = "eventInfoId", referencedColumnName = "id")
    val eventInfo: EventInfo = null

}