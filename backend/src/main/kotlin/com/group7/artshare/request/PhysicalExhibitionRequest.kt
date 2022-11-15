package com.group7.artshare.request

import com.group7.artshare.entity.EventInfo
import com.group7.artshare.entity.Location
import lombok.Data
import lombok.Getter
import lombok.RequiredArgsConstructor
import javax.validation.constraints.NotEmpty


@Data
@RequiredArgsConstructor
class PhysicalExhibitionRequest {

    @NotEmpty
    val creatorId: Long? = null

    @NotEmpty
    val eventInfo: EventInfo? = null

    @NotEmpty
    val location: Location? = null

    val rules: String? = null
}