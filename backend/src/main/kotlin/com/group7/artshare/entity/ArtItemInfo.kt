package com.group7.artshare.entity

import lombok.Data
import javax.persistence.*

@Data
@Entity
class ArtItemInfo {

    @Id
    @GeneratedValue
    val id: Long = 0L

    @OneToOne
    @JoinColumn(name = "artItem", referencedColumnName = "itemId")
    val artItem: ArtItem? = null

    @Column
    val name: String? = null

    @Column
    val description: String? = null

    @Column
    val category: String? = null

    @Column
    val imageUrl: String? = null

    @Column
    val labels: List<String> = ArrayList()
}