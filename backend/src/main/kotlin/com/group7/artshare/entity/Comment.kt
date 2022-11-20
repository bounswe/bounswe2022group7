package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.fasterxml.jackson.annotation.JsonManagedReference
import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class Comment {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @Column
    var text: String? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var lastEditDate: Date = Calendar.getInstance().time

    @Column
    var upvoteNo : Int = 0

    @Column
    var downvoteNo : Int = 0

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var reports: MutableList<Report> = mutableListOf()

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    @JsonBackReference
    var author : RegisteredUser? = null
}