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
    var itemId: Long = 0L

    @Column
    var body : String = ""

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var createdAt: Date = Calendar.getInstance().time

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator")
    @JsonBackReference
    var author : RegisteredUser? = null
}