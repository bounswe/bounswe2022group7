package com.group7.artshare.entity

import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class Comment {

    @Id
    @GeneratedValue
    var itemId: Long = 0L

    @Column
    var body : String = ""

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var createdAt: Date = Calendar.getInstance().time

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var author : RegisteredUser? = null
}