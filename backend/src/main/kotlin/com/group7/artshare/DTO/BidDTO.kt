package com.group7.artshare.DTO

import com.group7.artshare.entity.AccountInfo
import com.group7.artshare.entity.Report
import lombok.Data
import java.util.*

@Data
class BidDTO {

    var id : Long? = null
    var bidAmount : Double? = null
    var bidderAccountInfo : AccountInfo? = null
}