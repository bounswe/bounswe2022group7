package com.group7.artshare.entity

import lombok.Data
import java.util.ArrayList
import javax.persistence.*

@Data
@Entity
@Table(name = "online_gallery")
class OnlineGallery {
    @Id
    @GeneratedValue
    val id: Long = 0L

    @OneToMany(orphanRemoval = true, fetch = FetchType.EAGER)
    val artItems: List<ArtItem> = ArrayList()

    @Column
    val platform: String = "ArtShare"

    @Column
    val externalUrl: String? = null

}