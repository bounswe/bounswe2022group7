package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import lombok.Data
import java.util.*
import javax.persistence.*
import java.util.Calendar


@Data
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
open class Event{
    @Id
    @GeneratedValue(strategy =  GenerationType.TABLE)
    var id: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var creator: Artist? = null
    
    @ManyToMany(mappedBy = "hostedEvents")
    var collaborators: MutableSet<Artist> = mutableSetOf()

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var commentList: MutableList<Comment> = mutableListOf()

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "eventInfoId")
    var eventInfo: EventInfo? = null

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "event_participants",
        joinColumns = [JoinColumn(name = "attending_user_id")],
        inverseJoinColumns = [JoinColumn(name = "physical_exhibition_id")]
    )
    var participants: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(mappedBy = "bookmarkedEvents")
    var bookmarkedBy: MutableSet<RegisteredUser> = mutableSetOf()
}