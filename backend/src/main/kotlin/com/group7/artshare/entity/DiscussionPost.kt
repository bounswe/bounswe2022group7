package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.group7.artshare.DTO.DiscussionPostDTO
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

    @Column
    var posterId: Long? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    @JsonBackReference
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
    var reports: MutableList<Report> = mutableListOf()

    @OneToMany(orphanRemoval = true, cascade = [CascadeType.ALL])
    var commentList: MutableList<Comment> = mutableListOf()

    fun mapToDTO() : DiscussionPostDTO {
        var discussionPostDTO = DiscussionPostDTO()
        discussionPostDTO.id = this.id
        discussionPostDTO.title = this.title
        discussionPostDTO.textBody = this.textBody
        discussionPostDTO.posterId = this.posterId
        discussionPostDTO.creationDate = this.creationDate
        discussionPostDTO.lastEditDate = this.lastEditDate
        discussionPostDTO.upvoteNo = this.upvoteNo
        discussionPostDTO.downvoteNo = this.downvoteNo
        return discussionPostDTO
    }
}