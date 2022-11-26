package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import lombok.Data
import java.util.*
import javax.persistence.*
import kotlin.collections.ArrayList
import java.util.Calendar


@Data
@Entity
class Notification{
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    val id: Long = 0L

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var date: Date = Calendar.getInstance().time

    @Column
    var description: String? = null

    @ManyToMany(mappedBy = "readNotifications",cascade = [CascadeType.MERGE, CascadeType.PERSIST])
    @JsonIgnore
    var readBy: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(mappedBy = "unreadNotifications",cascade = [CascadeType.MERGE, CascadeType.PERSIST])
    @JsonIgnore
    var unreadBy: MutableSet<RegisteredUser> = mutableSetOf()

}