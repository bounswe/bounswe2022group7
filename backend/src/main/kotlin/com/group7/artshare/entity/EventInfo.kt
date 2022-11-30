
package com.group7.artshare.entity

import com.group7.artshare.utils.StringToListConverter
import lombok.Data
import java.util.*
import javax.persistence.*

@Data
@Entity
class EventInfo {

    @Id
    @GeneratedValue
    var id: Long = 0L

    @Column
    var title : String = ""

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var startingDate: Date = Calendar.getInstance().time

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    var endingDate: Date = Calendar.getInstance().time

    @Column
    var description: String? = null

    @Column
    @Convert(converter = StringToListConverter::class)
    var category: MutableList<String> = mutableListOf()

    @Column
    var eventPrice: Double = 0.0;

    @Column
    @Convert(converter = StringToListConverter::class)
    var labels: MutableList<String> = mutableListOf()

    @Column
    var posterId: Long? = null
}