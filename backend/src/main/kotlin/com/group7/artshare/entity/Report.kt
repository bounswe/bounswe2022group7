package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class Report {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "reported_art_item_id")
    @JsonIgnore
    var reportedArtItem : ArtItem? = null

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var creationDate: Date = Calendar.getInstance().time

    @Column
    var description : String? = null

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "reporter_user_id")
    @JsonIgnore
    var reporter : RegisteredUser? = null

}