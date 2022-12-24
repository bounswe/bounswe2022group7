package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import com.group7.artshare.DTO.EventDTO
import lombok.Data
import java.util.*
import javax.persistence.*
import java.util.Calendar


@Data
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
abstract class Event{
    @Id
    @GeneratedValue(strategy =  GenerationType.TABLE)
    var id: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var creator: Artist? = null

    @ManyToMany(mappedBy = "hostedEvents", fetch = FetchType.EAGER,cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var collaborators: MutableSet<Artist> = mutableSetOf()

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var commentList: MutableList<Comment> = mutableListOf()

    @OneToOne(cascade = [CascadeType.ALL])
    @JoinColumn(name = "eventInfoId")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var eventInfo: EventInfo? = null

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "event_participants",
        joinColumns = [JoinColumn(name = "event_id")],
        inverseJoinColumns = [JoinColumn(name = "attending_user_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var participants: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(mappedBy = "bookmarkedEvents")
    @JsonIgnore
    var bookmarkedBy: MutableSet<RegisteredUser> = mutableSetOf()

    abstract fun mapToDTO() : EventDTO
}