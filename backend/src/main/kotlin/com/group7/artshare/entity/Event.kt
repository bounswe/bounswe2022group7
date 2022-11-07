package com.group7.artshare.entity

import lombok.Data
import java.util.*
import javax.persistence.*
import java.util.Calendar


@Data
@MappedSuperclass
abstract class Event{
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    var id: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var creator: Artist? = null

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var collaborators: List<Artist> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var participants: List<RegisteredUser> = mutableListOf()

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var commentList: List<Comment> = mutableListOf()


    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "eventInfoId")
    var eventInfo: EventInfo? = null
}