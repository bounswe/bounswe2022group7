package com.group7.artshare.entity

import lombok.Data
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id

@Data
@Entity
class Comment {

    @Id
    @GeneratedValue
    var itemId: Long = 0L
}