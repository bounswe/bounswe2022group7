package com.group7.artshare.entity

import com.fasterxml.jackson.annotation.JsonBackReference
import com.group7.artshare.utils.StringToListConverter
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
    @Convert(converter = StringToListConverter::class)
    var category: MutableList<String> = mutableListOf()

    @Column
    var imageId: Long? = null

    @Column
    @Convert(converter = StringToListConverter::class)
    var labels: MutableList<String> = mutableListOf()
}