package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*

@Data
@Entity
class ArtItemInfo {

    @Id
    @GeneratedValue
    var id: Long = 0L

    @Column
    var name: String? = null

    @Column
    var description: String? = null

    @Column
    var category: String? = null

    @Column
    var imageUrl: String? = null

    @Column
    var labels: String? = null
}