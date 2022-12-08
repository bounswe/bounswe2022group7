package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import com.group7.artshare.DTO.CommentDTO
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

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "comment_upvoter",
        joinColumns = [JoinColumn(name = "upvoter_user_id")],
        inverseJoinColumns = [JoinColumn(name = "comment_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var upVotedUsers : MutableSet<RegisteredUser> = mutableSetOf()

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "comment_downvoter",
        joinColumns = [JoinColumn(name = "downvoter_user_id")],
        inverseJoinColumns = [JoinColumn(name = "comment_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var downVotedUsers : MutableSet<RegisteredUser> = mutableSetOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    @JsonIgnore
    var reports: MutableList<Report> = mutableListOf()

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property ="id")
    var author : RegisteredUser? = null



    fun mapToDTO() : CommentDTO {
        var commentDTO = CommentDTO()
        commentDTO.id = this.id
        commentDTO.text = this.text
        commentDTO.creationDate = this.creationDate
        commentDTO.lastEditDate = this.lastEditDate
        commentDTO.downVotedUsernames = this.downVotedUsers.map { it.username }.toHashSet()
        commentDTO.upVotedUsernames = this.upVotedUsers.map { it.username }.toHashSet()
        commentDTO.reports = this.reports
        commentDTO.authorAccountInfo = this.author?.accountInfo
        commentDTO.authorId = this.author?.id
        return commentDTO
    }
}