
package com.group7.artshare.entity

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
    var category: String? = null

    @Column
    var eventPrice: Double = 0.0;

    @Column
    var labels: String? = null

    @Column
    var posterId: Long? = null
}