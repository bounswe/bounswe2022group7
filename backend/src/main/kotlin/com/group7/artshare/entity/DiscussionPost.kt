package com.group7.artshare.entity

import com.group7.artshare.DTO.DiscussionPostDTO
import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.ObjectIdGenerators

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
    var title: String? = null

    @Column
    var textBody: String? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var creator: RegisteredUser? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var lastEditDate: Date = Calendar.getInstance().time

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "discussion_post_upvoter",
        joinColumns = [JoinColumn(name = "post_id")],
        inverseJoinColumns = [JoinColumn(name = "post_upvoter_user_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var upVotedUsers : MutableSet<RegisteredUser> = mutableSetOf()


    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE])
    @JoinTable(
        name = "discussion_post_downvoter",
        joinColumns = [JoinColumn(name = "post_id")],
        inverseJoinColumns = [JoinColumn(name = "post_downvoter_user_id")]
    )
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var downVotedUsers : MutableSet<RegisteredUser> = mutableSetOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "id")
    var commentList: MutableList<Comment> = mutableListOf()

    fun mapToDTO() : DiscussionPostDTO {
        var discussionPostDTO = DiscussionPostDTO()
        discussionPostDTO.id = this.id
        discussionPostDTO.title = this.title
        discussionPostDTO.textBody = this.textBody
        discussionPostDTO.creatorAccountInfo = this.creator?.accountInfo
        discussionPostDTO.creatorId = this.creator?.id
        discussionPostDTO.creationDate = this.creationDate
        discussionPostDTO.lastEditDate = this.lastEditDate
        discussionPostDTO.upVotedUsernames = this.upVotedUsers.map { it.username }.toMutableSet()
        discussionPostDTO.downVotedUsernames = this.downVotedUsers.map { it.username }.toMutableSet()
        discussionPostDTO.commentList = this.commentList.map { it.mapToDTO() }.toMutableList()
        return discussionPostDTO
    }
}