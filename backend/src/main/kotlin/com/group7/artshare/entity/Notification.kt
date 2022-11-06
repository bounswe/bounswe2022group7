package com.group7.artshare.entity

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

    @ManyToMany(mappedBy = "readNotifications",cascade = [CascadeType.ALL])
    var readBy: MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(mappedBy = "unreadNotifications",cascade = [CascadeType.ALL])
    var unreadBy: MutableSet<RegisteredUser> = mutableSetOf()

}