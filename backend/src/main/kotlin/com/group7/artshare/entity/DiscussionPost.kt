package com.group7.artshare.entity

import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class DiscussionPost {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @Column
    var title: String = ""

    @Column
    var textBody: String = ""

    @Column
    var imageURL: String = ""

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    var creator: RegisteredUser? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var lastEditDate: Date = Calendar.getInstance().time

    @Column
    var upvoteNo: Int = 0

    @Column
    var downvoteNo: Int = 0

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var reports: List<Report> = ArrayList()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var commentList: List<Comment> = ArrayList()

}