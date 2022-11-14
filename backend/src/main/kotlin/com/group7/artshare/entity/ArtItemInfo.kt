package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import lombok.Data
import javax.persistence.*

@Data
@Entity
class ArtItemInfo {

    @Id
    @GeneratedValue
    var id: Long = 0L

    @OneToOne(mappedBy = "artItemInfo", cascade = [CascadeType.ALL])
    @JsonBackReference
    var artItem: ArtItem? = null

    @Column
    var name: String? = null

    @Column
    var description: String? = null

    @Column
    var category: String? = null

    @Column
    var imageId: Long? = null

    @Column
    var labels: String? = null
}